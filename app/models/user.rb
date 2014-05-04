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
#

class User < ActiveRecord::Base

  before_save :ensure_authentication_token

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :daily_routines
  has_one :user_schedule
  has_many :user_maxes
  belongs_to :program_type

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

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

end
