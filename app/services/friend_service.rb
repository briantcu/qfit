require 'singleton'

class FriendService
  include Singleton

  def make_friends(user_id_one, user_id_two)
    ids = [user_id_one, user_id_two].sort
    Friend.create!(id_one: ids[0], id_two: ids[1]) unless are_friends?(user_id_one, user_id_two)
  end

  def are_friends?(user_id_one, user_id_two)
    ids = [user_id_one.to_i, user_id_two.to_i].sort
    Friend.where(id_one: ids[0], id_two: ids[1]).first.present?
  end

  def get_friends_record(user_id_one, user_id_two)
    ids = [user_id_one.to_i, user_id_two.to_i].sort
    Friend.where(id_one: ids[0], id_two: ids[1]).first
  end
end