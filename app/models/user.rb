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
#  password                    :string(255)
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
#  program_type                :integer
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
#

class User < ActiveRecord::Base

  before_save :ensure_authentication_token

  SEX_OPTIONS = %w(male female )

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :daily_routines
  has_one :user_schedule
  has_many :user_maxes
  belongs_to :program_type
  validates_presence_of :first_name, :last_name
  #validates :sex, :inclusion => {:in => SEX_OPTIONS}

  def self.try_login(email, password)
    salt = '1lasfj3932kak3'
    initial_hashed_pw = Digest::SHA1.hexdigest(salt+password)
    hashed_pw = initial_hashed_pw[0..39]

    user = User.where(email: email, password: hashed_pw).first
    if user.nil?
      #try again because you're a moron and you truncated the table once
      hashed_pw = hashed_pw[0..24]
      user = User.where(email: email, password: hashed_pw).first
    end

    unless user.nil?
      #Update to use new password system (devise)
      user.password = password
      user.save
    end
    user
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

  def is_coach_of_user(current_user, id)
    sub_user = User.find(id)
    sub_user.master_user_id == current_user.id
  end

  def self.update_program_info(user_schedule)
    user = User.find(user_schedule.user.id)
    user.program_type = user_schedule.program_type
    user.current_phase = user_schedule.get_current_phase
    user.save
  end

  def will_workout_for_day(day)
    self.user_schedule.weekly_schedule_days[day].stretching
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

end
