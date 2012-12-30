module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Banklink #:nodoc:
        module Helper #:nodoc:

          def self.included(base)
            base.class_eval do
              mapping :account, 'VK_SND_ID'
              # Amount paid, for example, "33.00"
              mapping :amount, 'VK_AMOUNT'
              # Unique order id
              mapping :order, 'VK_STAMP'
              # Currency used, 3-letter ISO 4217 code
              mapping :currency, 'VK_CURR'
              mapping :notify_url, 'VK_RETURN'
              mapping :return_url, 'VK_RETURN'
              mapping :cancel_return_url, 'VK_CANCEL'
              
              mapping :reference, 'VK_REF'
              mapping :description, 'VK_MSG'
            end
          end

          def initialize(order, account, options = {})
            @options = options
            @fields = ActiveSupport::OrderedHash.new
            @raw_html_fields = []

            if options[:service_msg_number]
              @service_msg_number = options.delete(:service_msg_number)
            else
              @service_msg_number = default_service_msg_number
            end

            add_required_params

            self.order = order
            self.account = account
            self.amount = options[:amount]
            self.currency = options[:currency]
            self.description = options[:description]
            self.reference = options[:reference]

            old_valid_keys = [:amount, :currency, :test]
            new_valid_keys = [:description, :reference]
            valid_keys = (old_valid_keys + new_valid_keys + required_service_params[@service_msg_number] << :service_msg_number).uniq
            options.assert_valid_keys(valid_keys)

            add_charset_field
            add_vk_mac
          end

          def add_field(name, value)
            return if name.blank?
            @fields[name.to_s] = value.to_s
          end

          # Amount can be supplied with a optional dot separator for cents.
          def amount=(amount)
            # TODO check this, sooner or later someone will get a wrong amount.

            amount = Money.new(amount) unless amount.is_a?(Money)
            amount = "%0.2f" % amount

            add_field('VK_AMOUNT', amount)

            # If a string is passed to us, don't do anything.
            # If a Money object is passed to us, don't do anything.
            # Otherwise delegate the handling to the money object
            # and free ourself from the responsibility, yay.
            #if amount.is_a?(String) || amount.is_a?(Money)
            #  add_field('VK_AMOUNT', amount)
            #else
            #  add_field('VK_AMOUNT', Money.new(amount))
            #end
          end

          def add_vk_mac
            # Signature used to validate previous parameters
            add_field('VK_MAC', generate_mac(@service_msg_number, form_fields))
          end

          def add_charset_field
            add_field vk_charset_param, vk_charset
          end

          def add_required_params
            required_params = required_service_params[@service_msg_number]
            required_params.each do |param|
              param_value = (@options.delete(param) || send(param.to_s.downcase)).to_s
              add_field param, iconv.iconv(param_value)
            end
          end

          # Default parameters
          def vk_charset
            'ISO-8859-1'
          end

          def vk_charset_param
            'VK_CHARSET'
          end

          def vk_service
            @service_msg_number
          end

          def vk_version
            '008'
          end

          # Default service message number.
          # Use '1002' because it requires the least amount of parameters.
          def default_service_msg_number
            1002
          end

          private
          # Iconv converter to convert from utf8 to
          # the charset the bank api expects.
          def iconv
            @iconv ||= Iconv.new(vk_charset, 'UTF-8')
          end

        end
      end
    end
  end
end
