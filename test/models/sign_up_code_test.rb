require 'test_helper'

class SignUpCodeTest < ActiveSupport::TestCase
  test 'returns record for code' do
    record = SignUpCode.where(code: 'MyString').first
    assert (record.user.id == 1)
  end

  test 'returns nothing if code does not exist' do
    record = SignUpCode.where(code: 'MyString3').first
    assert (record.nil?)
  end
end
