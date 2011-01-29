module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module SebEst #:nodoc:
        class Helper < ActiveMerchant::Billing::Integrations::Helper #:nodoc:
          include Pizza::Common
          include Pizza::Helper

          def vk_charset
            'UTF-8'
          end
        end
      end
    end
  end
end
