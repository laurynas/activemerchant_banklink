module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module SebLtu #:nodoc:
        class Helper < ActiveMerchant::Billing::Integrations::Helper #:nodoc:
          include SebLtu::Common
          include Banklink::Helper

          def default_service_msg_number
            1001
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
