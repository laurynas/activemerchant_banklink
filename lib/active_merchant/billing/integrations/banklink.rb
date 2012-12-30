require 'active_merchant/billing/integrations/banklink/helper.rb'
require 'active_merchant/billing/integrations/banklink/notification.rb'
module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Banklink

        # Detect bank module from params
        #def self.get_class(params)
        #  case params['VK_SND_ID']
        #    when 'EYP' then SebEst
        #    when 'SAMPOPANK' then SampoEst
        #    when 'HP' then SwedbankEst

			      # Swedbank uses same sender id for different countries, currently can't detect Lithuanian
            # use:
            #   notify = SwedbankLtu::Notification.new(params)
            #when 'HP' then SwedbankLtu

      			#when '70440' then SebLtu
            #when 'SMPOLT22' then DanskeLtu
            #when 'SNORLT22' then SnorasLtu
            #when '112029720' then DnbnordLtu
            #when '70100' then UbLtu

        #    else raise(ArgumentError, "unknown sender id: #{params['VK_SND_ID']}")
        #  end
        #end

        # Calculation using method VK_VERSION=008:
        # VK_MAC is RSA signature of the request fields coded into BASE64.
        # VK_MAC will be calculated using secret key of the sender using RSA. Signature will
        # be calculated for string that consists of all field lengths and contents in the query. Also
        # empty fields are used in calculation – lenght “000”. Unnumbered (optional) fields are
        # not used in calculation.
        # MAC(x1,x2,...,xn) := RSA( SHA-1(p(x1 )|| x1|| p(x2 )|| x2 || ... ||p( xn )||xn),d,n)
        # where:
        # || is string concatenation mark
        # x1, x2, ..., xn are parameters of the query
        # p(x) is the length of the field x in bytes, represented by three digits
        # d is RSA secret exponent
        # n is RSA modulus
        module Common
          # Define required fields for each service message.
          # We need to know this in order to calculate VK_MAC
          # from a given hash of parameters.
          # Order of the parameters is important.
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
              2001 => [
                'VK_SERVICE',
                'VK_VERSION',
                'VK_SND_ID',
                'VK_STAMP',
                'VK_AMOUNT',
                'VK_CURR',
                'VK_ACC',
                'VK_PANK',
                'VK_NAME',
                'VK_REF',
                'VK_MSG'],
              1002 => [
                'VK_SERVICE',
                'VK_VERSION',
                'VK_SND_ID',
                'VK_STAMP',
                'VK_AMOUNT',
                'VK_CURR',
                'VK_REF',
                'VK_MSG' ],
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
                'VK_REC_ACC',
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

          # p(x) is the length of the field x in bytes, represented by three digits
          def func_p(val)
            sprintf("%03i", val.bytesize)
          end

          # Generate a string to be signed out of service message parameters.
          # p(x1 )|| x1|| p(x2 )|| x2 || ... ||p( xn )||xn
          # || is string concatenation mark
          # p(x) is length of the field x represented by three digits
          # Parameters val1, val2, value3 would be turned into:
          # '003val1003val2006value3'
          def generate_data_string(service_msg_number, sigparams)
            str = ''
            required_service_params[Integer(service_msg_number)].each do |param|
              val = sigparams[param].to_s # nil goes to ''
              str << func_p(val) << val
            end
            str
          end

          def generate_signature(service_msg_number, sigparams)
            privkey = self.class.parent.get_private_key
            privkey.sign(OpenSSL::Digest::SHA1.new, generate_data_string(service_msg_number, sigparams))
          end

          def generate_mac(service_msg_number, sigparams)
            Base64.encode64(generate_signature(service_msg_number, sigparams)).gsub(/\n/,'')
          end
        end
      end
    end
  end
end
