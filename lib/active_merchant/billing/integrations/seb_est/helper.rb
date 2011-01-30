module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module SebEst #:nodoc:
        class Helper < ActiveMerchant::Billing::Integrations::Helper #:nodoc:
          include Banklink::Common
          include Banklink::Helper

          def vk_charset
            'UTF-8'
          end
        end
      end
    end
  end
end
