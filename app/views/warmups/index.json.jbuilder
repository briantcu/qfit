json.static_stretch @warmups.where(:ex_type => 1), :id, :name, :ex_type, :is_stretch, :video_link
json.dynamic_stretch @warmups.where(:ex_type => 2), :id, :name, :ex_type, :is_stretch, :video_link
json.warm_up @warmups.where(:ex_type => 3), :id, :name, :ex_type, :is_stretch, :video_link

