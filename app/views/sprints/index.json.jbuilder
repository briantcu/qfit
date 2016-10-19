json.track @sprints.where(:sprint_type => 1).order(difficulty: :asc), :id, :difficulty, :name, :sprint_type, :num_laps
json.basketball_court @sprints.where(:sprint_type => 2).order(difficulty: :asc), :id, :difficulty, :name, :sprint_type, :num_laps
json.treadmill @sprints.where(:sprint_type => 3).order(difficulty: :asc), :id, :difficulty, :name, :sprint_type, :num_laps
