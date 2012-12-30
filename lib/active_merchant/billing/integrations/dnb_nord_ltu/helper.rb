module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module DnbNordLtu #:nodoc:
        class Helper < ActiveMerchant::Billing::Integrations::Helper #:nodoc:
          include DnbNordLtu::Common
          include Banklink::Helper

          def default_service_msg_number
            2001
          end

          def vk_charset
            'ISO-8859-13'
          end

          def add_charset_field
            # skip
          end
        end
      end
    end
  end
end
