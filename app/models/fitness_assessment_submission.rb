class FitnessAssessmentSubmission
  include ActiveAttr::BasicModel
  include ActiveAttr::TypecastedAttributes
  include ActiveAttr::MassAssignment
  include ActiveModel::Validations

  SEX_OPTIONS = %w(male female)

  attribute :user_id, type: Integer
  attribute :weight, type: Float
  attribute :bench_reps, type: Integer
  attribute :bench_weight, type: Integer
  attribute :squat_reps, type: Integer
  attribute :squat_weight, type: Integer
  attribute :pull_ups, type: Integer
  attribute :push_ups, type: Integer
  attribute :assisted_push_ups, type: Integer
  attribute :experience_level, type: Integer
  attribute :sex, type: String

  validates :user_id, presence: true
  validates :weight, presence: true
  validates :sex, presence: true, :inclusion => {:in => SEX_OPTIONS}
  validates :experience_level, presence: true, :inclusion => {:in => 1..3}
  validate :must_have_minimum_info

  def process_submission
    user = User.find(self.user_id)
    user.sex = self.sex
    user.weight = self.weight
    user.experience_level = self.experience_level
    @hor_push_max = get_hor_push_max
    @hor_pull_max = get_hor_pull_max
    @knee_dom_max = get_knee_dom_max
    adjust_for_experience
    user.hor_pull_max = @hor_pull_max
    user.hor_push_max = @hor_push_max
    user.knee_dom_max = @knee_dom_max
    user.save!
    user
  end

  def adjust_for_experience
    multiplier = 0.78
    if self.experience_level == 2
      multiplier = 0.85
    end
    if self.experience_level == 3
      multiplier = 0.92
    end
    @hor_push_max = (@hor_push_max * multiplier).to_i
    @hor_pull_max = (@hor_pull_max * multiplier).to_i
    @knee_dom_max = (@knee_dom_max * multiplier).to_i
  end

  def get_knee_dom_max
    if is_valid_number(self.squat_reps) && is_valid_number(self.squat_weight)
      return OneRepMax.get_max(self.squat_reps, self.squat_weight)
    end
    (@hor_push_max * 1.2).to_i
  end

  def get_hor_pull_max
    if is_valid_number(self.pull_ups)
      return OneRepMax.get_max(self.pull_ups, self.weight)
    end
    (@hor_push_max * 0.6).to_i
  end

  def get_hor_push_max
    if is_valid_number(self.bench_reps) && is_valid_number(self.bench_weight)
      return OneRepMax.get_max(self.bench_reps, self.bench_weight)
    end
    if is_valid_number(self.push_ups)
      return OneRepMax.get_max(self.push_ups, (self.weight * 0.3).to_i)
    end
    OneRepMax.get_max(self.assisted_push_ups, (self.weight * 0.4).to_i)
  end

  def is_valid_number(num)
    unless num.nil? || num <= 0
      return true
    end
    false
  end

  def must_have_minimum_info
    errors.add(:base, 'Must include bench info, push up info, or assisted push up info, at a minimum') unless hor_push_max_present
  end

  def hor_push_max_present
    (is_valid_number(self.bench_reps) && is_valid_number(self.bench_weight)) ||
        is_valid_number(self.push_ups) ||
        is_valid_number(self.assisted_push_ups)
  end

end