json.track @sprints.where(:sprint_type => 1), :id, :difficulty, :name, :sprint_type, :num_laps
json.basketball_court @sprints.where(:sprint_type => 2), :id, :difficulty, :name, :sprint_type, :num_laps
json.treadmill @sprints.where(:sprint_type => 3), :id, :difficulty, :name, :sprint_type, :num_laps
