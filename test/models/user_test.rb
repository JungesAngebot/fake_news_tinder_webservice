require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'do not destroy db entry but tombstone it' do
    assert_no_difference('User.unscoped.count') do
      users(:admin).destroy
    end
  end

  test 'tombstoned objects should not show normally' do
    assert_difference('User.count', -1) do
      users(:admin).destroy
    end
  end

  test 'no empty users' do
    user = User.new
    assert_not user.save
  end

  test 'no users with only email' do
    user = User.new
    user.email = 'company@fluidmobile.de'
    assert_not user.save
  end

  test 'user must have email and password' do
    assert User.create!(email: 'company@fluidmobile.de', password: 'Password123')
  end

  test 'user password complexity' do
    user = User.new(email: 'company@fluidmobile.de')
    assert_not user.update(password: '123')
    assert_not user.update(password: 'test')
    assert_not user.update(password: 'test1234')
    assert user.update(password: 'Test1234')
  end

end
