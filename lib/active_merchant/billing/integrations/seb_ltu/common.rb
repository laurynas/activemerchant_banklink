module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module SebLtu #:nodoc:
        module Common
          include Banklink::Common

          def required_service_params
            {
              1001 => [
                'VK_SERVICE',
                'VK_VERSION',
                'VK_SND_ID',
                'VK_STAMP',
                'VK_AMOUNT',
                'VK_CURR',
                'VK_ACC',
                'VK_NAME',
                'VK_REF',
                'VK_MSG'],
              1101 => [
                'VK_SERVICE',
                'VK_VERSION',
                'VK_SND_ID',
                'VK_REC_ID',
                'VK_STAMP',
                'VK_T_NO',
                'VK_AMOUNT',
                'VK_CURR',
                'VK_REC_ACC',
                'VK_REC_NAME',
                'VK_SND_ACC',
                'VK_SND_NAME',
                'VK_REF',
                'VK_MSG',
                'VK_T_DATE'],
              1201 => [
                'VK_SERVICE',
                'VK_VERSION',
                'VK_SND_ID',
                'VK_REC_ID',
                'VK_STAMP',
                'VK_AMOUNT',
                'VK_CURR',
                'VK_ACC',
                'VK_REC_NAME',
                'VK_SND_ACC',
                'VK_SND_NAME',
                'VK_REF',
                'VK_MSG'],
              1901 => [
                'VK_SERVICE',
                'VK_VERSION',
                'VK_SND_ID',
                'VK_REC_ID',
                'VK_STAMP',
                'VK_REF',
                'VK_MSG']
            }
          end
        end
      end
    end
  end
end
