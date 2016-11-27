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
#  administrator               :boolean          default(FALSE)
#  sub_user                    :boolean
#  knee_dom_max                :float
#  hor_push_max                :float
#  hor_pull_max                :float
#  power_index                 :integer
#  current_phase               :integer
#  phone                       :string(255)
#  last_weight_day_created     :integer          default(0)
#  last_warmup_day_created     :integer          default(0)
#  last_plyometric_day_created :integer          default(0)
#  last_sprint_day_created     :integer          default(0)
#  user_name                   :string(255)
#  sprint_diff                 :integer          default(1)
#  weight                      :float
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
#  points                      :integer          default(10)
#  status                      :integer          default(1)
#  paid_tier                   :integer          default(1)
#  facebook                    :string
#  provider                    :string
#  uid                         :string
#  image                       :string
#  stripe_id                   :string
#  active_until                :datetime
#  subscription_id             :string
#  level                       :integer
#  dummyone                    :string
#  dummytwo                    :string
#  dummythree                  :string
#  dummyfour                   :string
#  dummyfive                   :string
#  dummysix                    :string
#  dummyseven                  :string
#  dummyeight                  :string
#  dummynine                   :string
#  dummyten                    :string
#  dummyeleven                 :string
#  dummytwelve                 :string
#  dummythirteen               :string
#  dummyfourteen               :string
#  needs_pw_reset              :boolean
#  avatar                      :string
#  failed_attempts             :integer          default(0), not null
#  unlock_token                :string
#  locked_at                   :datetime
#  bio                         :text
#

# Status: 1 = active, 2 = disabled, 3 = active with failed payment, 4 = active but cancelling
# Experience level = 1-3
# Level: 1 = sub, 2= reg user, 5 coach
# paid_tier: 1 = basic, 2 = premium

class User < ActiveRecord::Base

  STRETCHING = 4
  WEIGHTS = 1
  PLYOS = 2
  SPRINTING = 3

  mount_uploader :avatar, AvatarUploader

  before_save :ensure_authentication_token
  before_save :downcase_fields

  after_commit :check_user_name

  validates :user_name, uniqueness: true, allow_blank: true, allow_nil: true, format: {with: /\A[\w\-]+\z/, message: 'Usernames can only have letters, numbers, dashes, and underscores.'}
  validates :email, presence: true, uniqueness: true
  validates_inclusion_of :sex, in: %w( male female ), :allow_blank => true
  validates_length_of :first_name, maximum: 50
  validates_length_of :last_name, maximum: 50
  validates_length_of :email, maximum: 50
  validates_length_of :user_name, maximum: 30

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :lockable, :omniauth_providers => [:facebook]

  has_many :daily_routines, dependent: :destroy
  has_many :recent_workouts, -> { order(day_performed: :desc).limit(10) }, class_name: DailyRoutine
  has_many :user_maxes, dependent: :destroy
  has_many :coach_groups, foreign_key: :coach_user_id, class_name: Group
  has_many :custom_exercises, through: :daily_routines
  has_many :performed_exercises, through: :daily_routines
  has_many :performed_plyometrics, through: :daily_routines
  has_many :performed_sprints, through: :daily_routines
  has_many :performed_warm_ups
  has_many :laps, through: :performed_sprints
  has_many :weight_sets, through: :performed_exercises
  has_many :user_goals
  has_many :user_points, class_name: UserPoints
  has_many :players, class_name: User, foreign_key: :master_user_id
  has_many :outbox, class_name: Message, foreign_key: :poster_id

  has_one :group_join, dependent: :destroy
  has_one :group, through: :group_join
  has_many :sign_up_codes, dependent: :destroy
  has_one :used_sign_up_code, class_name: SignUpCode, foreign_key: :used_by_id
  has_one :user_schedule, dependent: :destroy
  has_one :coach_account, dependent: :destroy

  belongs_to :program_type
  belongs_to :coach, foreign_key: :master_user_id, class_name: User

  scope :sub_users, -> {where(sub_user: true)}
  scope :regular_users, -> {where(sub_user: false, level: [2,7])}
  scope :without_group ,-> {}
  scope :logged_in_recently, -> {where('last_sign_in_at > ?', Time.now - 3.weeks)}
  scope :males, -> {where(sex: 'male')}
  scope :females, -> {where(sex: 'female')}
  scope :most_sprinted, -> (date){select('users.*, count(laps.lap_number) AS value')
                                      .joins(:laps)
                                      .group('users.id')
                                      .where('laps.completed = true')
                                      .where('laps.created_at > ?', date)
                                      .order('value DESC').limit(5)}
  scope :most_plyos, -> (date){select('users.*, count(performed_plyometrics.id) AS value')
                                   .joins(:performed_plyometrics)
                                   .group('users.id')
                                   .where('performed_plyometrics.performed_one = true')
                                   .where('performed_plyometrics.performed_two = true')
                                   .where('performed_plyometrics.performed_three = true')
                                   .where('performed_plyometrics.created_at > ?', date)
                                   .order('value DESC').limit(5)}
  scope :most_sets_performed, -> (date){select('users.*, count(weight_sets.id) AS value')
                                            .joins(:weight_sets)
                                            .group('users.id')
                                            .where('weight_sets.perf_reps > 0')
                                            .where('weight_sets.created_at > ?', date)
                                            .order('value DESC').limit(5)}
  scope :most_reps_performed, -> (date){select('users.*, sum(weight_sets.perf_reps) AS value')
                                            .joins(:weight_sets)
                                            .group('users.id')
                                            .where('weight_sets.perf_reps > 0')
                                            .where('weight_sets.created_at > ?', date)
                                            .order('value DESC').limit(5)}
  def downcase_fields
    self.email.downcase!
  end

  def self.active_coaches
    coaches = includes(:coach_account).where(level: [5,7], status: [1, 4])
    coaches = coaches.select { |coach| coach.eligible_for_workouts? }
    coaches
  end

  def self.without_group
    includes(:group_join).where(group_joins: { id: nil })
  end

  def self.from_omniauth(auth)
    fb_user = where(provider: auth.provider, uid: auth.uid).first
    if fb_user.present?
      # You already have fb details in the system
      fb_user.image = auth.info.image + '?type=large'
      fb_user.save!
      return fb_user
    else
      existing_user = where(email: auth.info.email).first
      if existing_user.present?
        # You don't have fb details in the system, but you do have a user matching the provided email
        existing_user.update!(provider: auth.provider, uid: auth.uid, image: auth.info.image)
        return existing_user
      end

      # New user registration based on fb detes. user not saved until registration
      user = User.new
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      if auth.info.first_name.present? && auth.info.last_name.present?
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
      else
        name_arr = auth.info.name.split(' ')
        if name_arr.count == 2
          user.first_name = name_arr[0]
          user.last_name = name_arr[1]
        end
      end
      user.image = auth.info.image + '?type=large'
      return user
    end
  end

  def needs_setup?
    (self.program_type.blank?) || (self.user_schedule.blank?) ||  self.user_schedule.invalid? || self.hor_push_max.blank?
  end

  def exercise_tier
    @exercise_tier ||=
      if has_premium_access?
        2
      else
        1
      end
  end

  def has_subscription?
    # Used to determine if we have a stripe acct for this user. Does not mean sub is in good standing
    if is_coach?
      return coach_account.num_accts > 5
    end

    paid_tier == 2
  end

  def eligible_for_workouts?
    @eligible_for_workouts ||=
      if is_coach?
        if coach_account.num_accts > 5 # They're a paid subscriber
          players.count <= coach_account.num_accts && active_until >= Time.now && (status == 1 || status == 4)
        else
          players.count <= coach_account.num_accts && (status == 1 || status == 4)
        end
      else
        if is_sub_user?
          coach.eligible_for_workouts?
        else
          true
        end
      end
  end

  def has_premium_access?
    @has_premium_access ||=
      if is_coach?
        if coach_account.num_accts > 5 # They're a paid subscriber
          players.count <= coach_account.num_accts && active_until >= Time.now && (status == 1 || status == 4)
        else
          false
        end
      else
        if is_sub_user?
          coach.has_premium_access?
        else
          paid_tier == 2 && (status == 1 || status == 4) && active_until >= Time.now
        end
      end
  end

  def inbox
    Message.where(poster_id: friends.map(&:id).push(id)).where(message_type: [1,3]).order(created_at: :desc).limit(20)
  end

  def check_user_name
    if user_name.present?
      unless UserGoal.where(user_id: self.id, goal_definition_id: 3).first.present?
        UserGoal.create!(user_id: self.id, goal_definition_id: 3)
        gd = GoalDefinition.find(3)
        self.points += gd.points
        self.save
      end
    end
  end

  def avatar_path
    if avatar.file.present?
      avatar.url
    else
      image
    end
  end

  def friends
    User.where('users.id IN (SELECT CASE WHEN id_one=? THEN id_two ELSE id_one END FROM friends WHERE ? IN (id_one, id_two))',
               self.id, self.id)
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

  def is_coach?
    self.level == 5 || self.level == 7
  end

  def is_super_user?
    self.level == 7
  end

  def is_sub_user?
    self.level == 1
  end

  def is_individual?
    self.level == 2
  end

  def is_group?
    false
  end

  def is_coach_of_user?(id)
    sub_user = User.find(id)
    sub_user.master_user_id == self.id
  end

  def update_program_info
    self.program_type = self.user_schedule.program_type
    self.current_phase = self.user_schedule.get_current_phase
    self.save
  end

  def update_status(status)
    self.status = status
    self.save!
    if self.is_coach?
      self.players.update_all(status: status) if self.players.present?
    end
  end

  def will_workout_for_day?(day)
    self.user_schedule.weekly_schedule_days[day].stretching
  end

  def owns_workout?(daily_routine_id)
    owns = false
    daily_routine = DailyRoutine.find(daily_routine_id)
    if daily_routine.present?
      owns = (((daily_routine.user_id == self.id) && !self.sub_user) ||
          (daily_routine.user.master_user_id == self.id))
    end
    owns
  end

  def owns_group?(group_id)
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

  def create_routine(date, custom = false)
    if self.user_schedule.is_valid_workout_day?(date) || custom
      DailyRoutine.create_routine(self.id, date, 0, 0)
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

  def flag_text_for_coach
    if self.user_schedule.blank?
      return "You haven't set up this member's workouts yet."
    end

    open_workouts = self.daily_routines.open.where('created_at < ?', Time.now - 3.days)
    if open_workouts.present?
      return 'This member has an open workout that is at least 2 days old.  The results from the performed workout
              should be entered, or the workout should be skipped.'
    end

    nil
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

end
