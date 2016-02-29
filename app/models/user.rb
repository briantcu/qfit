# == Schema Information
#
# Table name: users
#
#  id                          :integer          not null, primary key
#  master_user_id              :integer
#  first_name                  :string(255)
#  last_name                   :string(255)
#  email                       :string(255)
#  sex                         :string(255)
#  administrator               :boolean
#  sub_user                    :boolean
#  knee_dom_max                :float
#  hor_push_max                :float
#  hor_pull_max                :float
#  power_index                 :integer
#  old_password                :string(255)
#  current_phase               :integer
#  phone                       :string(255)
#  last_weight_day_created     :integer
#  last_warmup_day_created     :integer
#  last_plyometric_day_created :integer
#  last_sprint_day_created     :integer
#  user_name                   :string(255)
#  sprint_diff                 :integer
#  weight                      :float
#  level                       :integer
#  program_type_id             :integer
#  birth_year                  :integer
#  subscription_date           :date
#  created_at                  :datetime
#  updated_at                  :datetime
#  encrypted_password          :string(255)      default(""), not null
#  reset_password_token        :string(255)
#  reset_password_sent_at      :datetime
#  remember_created_at         :datetime
#  sign_in_count               :integer          default(0), not null
#  current_sign_in_at          :datetime
#  last_sign_in_at             :datetime
#  current_sign_in_ip          :string(255)
#  last_sign_in_ip             :string(255)
#  authentication_token        :string(255)
#  experience_level            :integer
#

class User < ActiveRecord::Base

  before_save :ensure_authentication_token

  STRETCHING = 4
  WEIGHTS = 1
  PLYOS = 2
  SPRINTING = 3

  SEX_OPTIONS = %w(male female )

  validates :displayed_user_name, uniqueness: true, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :group_joins, dependent: :destroy
  has_many :groups, through: :group_joins
  has_many :daily_routines, dependent: :destroy
  has_many :user_maxes, dependent: :destroy
  has_many :custom_exercises, through: :daily_routines
  has_many :performed_exercises, through: :daily_routines
  has_many :performed_plyometrics, through: :daily_routines
  has_many :performed_sprints, through: :daily_routines
  has_many :performed_warm_ups
  has_many :laps, through: :performed_sprints
  has_many :weight_sets, through: :performed_exercises

  has_one :user_schedule, dependent: :destroy
  has_one :coach_account, dependent: :destroy

  belongs_to :program_type
  belongs_to :coach, :foreign_key => :master_user_id, :class_name => 'User'
  #validates :sex, :inclusion => {:in => SEX_OPTIONS}

  scope :logged_in_recently, -> {where('last_sign_in_at > ?', Time.now - 21.days)}
  scope :males, -> {where(sex: 'male')}
  scope :females, -> {where(sex: 'female')}
  scope :most_sprinted, select('users.*, count(laps.lap_number) AS value').joins(:laps)
                            .group('users.id').where('laps.completed = true').order('value DESC').limit(5)
  scope :most_plyos, select('users.*, count(performed_plyometrics.id) AS value').joins(:performed_plyometrics)
                            .group('users.id')
                         .where('performed_plyometrics.performed_one = true')
                         .where('performed_plyometrics.performed_two = true')
                         .where('performed_plyometrics.performed_three = true')
                         .order('value DESC').limit(5)
  scope :most_sets_performed, select('users.*, count(weight_sets.id) AS value').joins(:weight_sets)
                            .group('users.id').where('weight_sets.perf_reps > 0').order('value DESC').limit(5)
  scope :most_reps_performed, select('users.*, sum(weight_sets.perf_reps) AS value').joins(:weight_sets)
                                  .group('users.id').where('weight_sets.perf_reps > 0').order('value DESC').limit(5)

  def self.try_login(email, password)
    salt = '1lasfj3932kak3'
    initial_hashed_pw = Digest::SHA1.hexdigest(salt+password)
    hashed_pw = initial_hashed_pw[0..39]

    user = User.where(email: email, old_password: hashed_pw).first
    if user.nil?
      #try again because you're a moron and you truncated the table once
      hashed_pw = hashed_pw[0..24]
      user = User.where(email: email, old_password: hashed_pw).first
    end

    if user.nil?
      #Devise needs a user to proceed with login
      user = User.where(email: email).first
    else
      #Update to use new password system (devise)
      user.password = password
      user.save
    end
    user
  end

  def update_og_password(password)
    password = password[0..24]
    self.old_password = password
    self.save
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def reset_authentication_token
    self.authentication_token = generate_authentication_token
    save
  end

  def is_coach
    self.level == 5
  end

  def is_super_user
    self.level == 7
  end

  def is_sub_user
    self.level == 1
  end

  def is_individual
    self.level == 2
  end

  def is_group
    false
  end

  def is_coach_of_user(current_user, id)
    sub_user = User.find(id)
    sub_user.master_user_id == current_user.id
  end

  def update_program_info
    self.program_type = self.user_schedule.program_type
    self.current_phase = self.user_schedule.get_current_phase
    self.save
  end

  def will_workout_for_day(day)
    self.user_schedule.weekly_schedule_days[day].stretching
  end

  def owns_workout(daily_routine_id)
    owns = false
    daily_routine = DailyRoutine.find(daily_routine_id)
    if daily_routine.present?
      owns = (((daily_routine.user_id == self.id) && !self.sub_user) ||
          (daily_routine.user.master_user_id == self.id))
    end
    owns
  end

  def owns_group(group_id)
    group = Group.find(group_id)
    group.coach_user_id == self.id
  end

  def get_schedule
    self.user_schedule
  end

  def update_email(email)
    self.email = email
    self.save
  end

  def create_routine(date)
    if self.user_schedule.is_valid_workout_day?(date)
      DailyRoutine.create_routine(self.id, date, 0)
    end
  end

  def note_last_day_created(day_id, type)
    case type
      when STRETCHING
        self.last_warmup_day_created = day_id
      when WEIGHTS
        self.last_weight_day_created = day_id
      when PLYOS
        self.last_plyometric_day_created = day_id
      when SPRINTING
        self.last_sprint_day_created = day_id
    end
    self.save
  end

  def get_last_day_created(type)
    case type
      when STRETCHING
        self.last_warmup_day_created
      when WEIGHTS
        self.last_weight_day_created
      when PLYOS
        self.last_plyometric_day_created
      when SPRINTING
        self.last_sprint_day_created
    end
  end

  def get_num_sub_users
    sub_users = User.where(:master_user_id => self.id)
    sub_users.length
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

end
