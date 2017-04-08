require 'test_helper'

class DeviceTest < ActiveSupport::TestCase

  test 'has uuid on creation' do
    device = Device.create!
    assert device.uuid
  end

end
