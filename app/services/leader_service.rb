class LeaderService
  include Singleton

  def populate_leaderboards
    Leader.destroy_all
    insert_power_index_leaders
    insert_pi_ratio_leaders
    insert_most_laps_sprinted
    insert_most_plyos_performed
    insert_most_sets_performed
    insert_most_reps_performed
  end

  private

  def insert_power_index_leaders
    male_leaders   = User.logged_in_recently.males.select('*, power_index AS value').order(power_index: :desc).limit(5)
    female_leaders = User.logged_in_recently.females.order(power_index: :desc).limit(5)
    create_leaders(male_leaders, Leader::MALE_POWER_INDEX)
    create_leaders(female_leaders, Leader::FEMALE_POWER_INDEX)
  end

  def insert_pi_ratio_leaders
    male_leaders   = User.logged_in_recently.males.select('*, (power_index/ weight) AS value ').order('value desc').limit(5)
    female_leaders = User.logged_in_recently.females.select('*, (power_index/ weight) AS value ').order('value desc').limit(5)
    create_leaders(male_leaders, Leader::MALE_POWER_INDEX_RATIO)
    create_leaders(female_leaders, Leader::FEMALE_POWER_INDEX_RATIO)
  end

  def insert_most_laps_sprinted
    leaders = User.logged_in_recently.most_sprinted(Time.zone.today - 3.weeks)
    create_leaders(leaders, Leader::SPRINTS_PERFORMED)
  end

  def insert_most_plyos_performed
    leaders = User.logged_in_recently.most_plyos(Time.zone.today - 3.weeks)
    create_leaders(leaders, Leader::PLYOS_PERFORMED)
  end

  def insert_most_sets_performed
    leaders = User.logged_in_recently.most_sets_performed(Time.zone.today - 3.weeks)
    create_leaders(leaders, Leader::SETS_PERFORMED)
  end

  def insert_most_reps_performed
    leaders = User.logged_in_recently.most_reps_performed(Time.zone.today - 3.weeks)
    create_leaders(leaders, Leader::REPS_PERFORMED)
  end

  def create_leaders(group, leader_type)
    group.each do |user|
      Leader.create!(user_id: user.id, first_name: user.first_name, last_name: user.last_name, value: user.value, leader_type: leader_type)
    end
  end

end