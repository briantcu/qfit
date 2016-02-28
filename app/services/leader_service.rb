class LeaderService

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
    create_leaders(male_leaders, Leader::MALE_POWER_INDEX)
    create_leaders(female_leaders, Leader::FEMALE_POWER_INDEX)
  end

  def insert_pi_ratio_leaders
    male_leaders   = User.logged_in_recently.males.select('*, (power_index/ weight) AS ratio ').order('ratio desc').limit(5)
    female_leaders = User.logged_in_recently.females.select('*, (power_index/ weight) AS ratio ').order('ratio desc').limit(5)
    create_leaders(male_leaders, Leader::MALE_POWER_INDEX_RATIO)
    create_leaders(female_leaders, Leader::FEMALE_POWER_INDEX_RATIO)
  end

  def insert_most_laps_sprinted
    leaders = User.logged_in_recently.most_sprinted
    create_leaders(leaders, Leader::SPRINTS_PERFORMED)
  end

  def insert_most_plyos_performed
    leaders = User.logged_in_recently.most_plyos
    create_leaders(leaders, Leader::PLYOS_PERFORMED)
  end

  def insert_most_sets_performed
    leaders = User.logged_in_recently.most_sets
    create_leaders(leaders, Leader::SETS_PERFORMED)
  end

  def insert_most_reps_performed
    leaders = User.logged_in_recently.most_reps
    create_leaders(leaders, Leader::REPS_PERFORMED)
  end

  def create_leaders(group, type)
    group.each do |user|
      Leader.create!(user_id: user.id, first_name: user.first_name, last_name: user.last_name, value: user.value, type: type)
    end
  end

end