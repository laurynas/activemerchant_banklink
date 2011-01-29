module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module SwedbankEst #:nodoc:
        class Helper < ActiveMerchant::Billing::Integrations::Helper #:nodoc:
          include Pizza::Common
          include Pizza::Helper

          def vk_charset
            'ISO-8859-1'
          end

          def vk_charset_param
            'VK_ENCODING'
          end
        end
      end
    end
  end
end
