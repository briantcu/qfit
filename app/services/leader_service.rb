class LeaderService

  MALE_POWER_INDEX = 1
  FEMALE_POWER_INDEX = 2
  MALE_POWER_INDEX_RATIO = 3
  FEMALE_POWER_INDEX_RATIO = 4
  SPRINTS_PERFORMED = 5
  PLYOS_PERFORMED = 6
  SETS_PERFORMED = 7
  REPS_PERFORMED = 8

  def populate_leaderboards
    insert_power_index_leaders
    insert_pi_ratio_leaders
    insert_most_laps_sprinted
    insert_most_plyos_performed
    insert_most_sets_performed
    insert_most_reps_performed
  end

  private

  def insert_power_index_leaders
    male_leaders   = User.logged_in_recently.males.order(power_index: :desc).limit(5)
    female_leaders = User.logged_in_recently.females.order(power_index: :desc).limit(5)
    create_leaders(male_leaders, 1)
    create_leaders(female_leaders, 2)
  end

  def insert_pi_ratio_leaders
    male_leaders   = User.logged_in_recently.males.select('*, (power_index/ weight) AS ratio ').order('ratio desc').limit(5)
    female_leaders = User.logged_in_recently.females.select('*, (power_index/ weight) AS ratio ').order('ratio desc').limit(5)
    create_leaders(male_leaders, 3)
    create_leaders(female_leaders, 4)
  end

  def insert_most_laps_sprinted
    leaders = User.logged_in_recently.most_sprinted
    create_leaders(leaders, 5)
  end

  def insert_most_plyos_performed
    leaders = User.logged_in_recently.most_plyos
    create_leaders(leaders, 7)
  end

  def insert_most_sets_performed
    leaders = User.logged_in_recently.most_sets
    create_leaders(leaders, 7)
  end

  def insert_most_reps_performed
    leaders = User.logged_in_recently.most_reps
    create_leaders(leaders, 8)
  end

  def create_leaders(group, type)
    group.each do |user|
      Leader.create!(user_id: user.id, first_name: user.first_name, last_name: user.last_name, value: user.value, type: type)
    end
  end

end