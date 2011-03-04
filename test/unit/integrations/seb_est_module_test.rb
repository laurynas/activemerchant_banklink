#require File.dirname(__FILE__) + '/../../test_helper'
require 'test_helper'

class SebEstModuleTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def test_notification_method
    #assert_instance_of SebEst::Notification, SebEst.notification({'name' => 'cody'})
    assert_instance_of SebEst::Notification, SebEst.notification('name=cody')
  end
end

