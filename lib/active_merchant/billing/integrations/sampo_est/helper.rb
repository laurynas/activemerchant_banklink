module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module SampoEst #:nodoc:
        class Helper < ActiveMerchant::Billing::Integrations::Helper #:nodoc:
          include Banklink::Common
          include Banklink::Helper

          def vk_charset
            'ISO-8859-4'
          end

        end
      end
    end
  end
end
