#require File.dirname(__FILE__) + '/../../test_helper'
require 'test_helper'

class SampoEstModuleTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def test_notification_method
#    assert_instance_of SampoEst::Notification, SampoEst.notification({'name' => 'cody'})
    assert_instance_of SampoEst::Notification, SampoEst.notification('name=cody')
  end
end

