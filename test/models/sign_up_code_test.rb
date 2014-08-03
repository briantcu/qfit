require 'test_helper'

class SignUpCodeTest < ActiveSupport::TestCase
  test 'returns record for code' do
    record = SignUpCode.with_code('MyString').first
    assert (record.user.id == 1)
  end

  test 'returns nothing if code does not exist' do
    record = SignUpCode.with_code('MyString3').first
    assert (record.nil?)
  end
end
