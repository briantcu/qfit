json.static_stretch @warmups.where(:ex_type => 1).order(name: :asc), :id, :name, :ex_type, :is_stretch, :video_link, :paid_tier
json.dynamic_stretch @warmups.where(:ex_type => 2).order(name: :asc), :id, :name, :ex_type, :is_stretch, :video_link, :paid_tier
json.warm_up @warmups.where(:ex_type => 3).order(name: :asc), :id, :name, :ex_type, :is_stretch, :video_link, :paid_tier

