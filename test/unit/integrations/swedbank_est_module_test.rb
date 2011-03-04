#require File.dirname(__FILE__) + '/../../test_helper'
require 'test_helper'

class SwedbankEstModuleTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def test_notification_method
    #assert_instance_of SwedbankEst::Notification, SwedbankEst.notification({'name' => 'cody'})
    assert_instance_of SwedbankEst::Notification, SwedbankEst.notification('name=cody')
  end
end

