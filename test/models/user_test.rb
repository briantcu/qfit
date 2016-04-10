require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'should note day created' do
    user = FactoryGirl.create(:user)
    user.note_last_day_created(2, 1)
    assert(user.last_weight_day_created == 2)

    user.note_last_day_created(2, 2)
    assert(user.last_plyometric_day_created == 2)

    user.note_last_day_created(2, 3)
    assert(user.last_sprint_day_created == 2)

    user.note_last_day_created(2, 4)
    assert(user.last_warmup_day_created == 2)
  end


end
