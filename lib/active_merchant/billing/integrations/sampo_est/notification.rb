module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module SampoEst #:nodoc:
        class Notification < ActiveMerchant::Billing::Integrations::Notification #:nodoc:
          include Banklink::Common
          include Banklink::Notification
        end
      end
    end
  end
end
