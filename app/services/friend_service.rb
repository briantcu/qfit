require 'singleton'

class FriendService
  include Singleton

  def make_friends(user_id_one, user_id_two)
    ids = [user_id_one, user_id_two].sort
    begin
      Friend.create!(id_one: ids[0], id_two: ids[1])
    rescue Exception => ex
      nil #already friends
    end
  end

  def are_friends?(user_id_one, user_id_two)
    ids = [user_id_one, user_id_two].sort
    Friend.where(id_one: ids[0], id_two: ids[1]).first.present?
  end
end