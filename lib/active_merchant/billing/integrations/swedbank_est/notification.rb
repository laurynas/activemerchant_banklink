module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module SwedbankEst #:nodoc:
        class Notification < ActiveMerchant::Billing::Integrations::Notification #:nodoc:
          include Pizza::Common
          include Pizza::Notification
        end
      end
    end
  end
end
