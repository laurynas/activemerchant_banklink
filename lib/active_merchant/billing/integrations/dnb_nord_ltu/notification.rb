module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module DnbNordLtu #:nodoc:
        class Notification < ActiveMerchant::Billing::Integrations::Notification #:nodoc:
          include DnbNordLtu::Common
          include Banklink::Notification
        end
      end
    end
  end
end
