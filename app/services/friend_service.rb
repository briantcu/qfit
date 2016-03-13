class FriendService

  def make_friends(user_id_one, user_id_two)
    begin
      Friend.create!(id_one: user_id_one, id_two: user_id_two)
    rescue Exception => ex
      nil #already friends
    end
  end
end