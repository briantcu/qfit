FactoryGirl.define do
  factory(:goal_definition) do
    achieved_text "ToFactory: RubyParser exception parsing this attribute"
    goal_text "Complete your workout schedule"
    goal_type 1
    order 1
    points 10
  end
end
