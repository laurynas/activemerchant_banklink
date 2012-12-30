require File.dirname(__FILE__) + '/dnb_nord_ltu/common.rb'
require File.dirname(__FILE__) + '/dnb_nord_ltu/helper.rb'
require File.dirname(__FILE__) + '/dnb_nord_ltu/notification.rb'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:

      module DnbNordLtu

        # Raw X509 certificate of the bank, string format.
        mattr_accessor :bank_certificate
        mattr_accessor :test_bank_certificate
        # RSA public key of the bank, taken from the X509 certificate of the bank. OpenSSL container.
        def self.get_bank_public_key
          if ActiveMerchant::Billing::Base.integration_mode == :production
            cert = self.bank_certificate
          else
            cert = self.test_bank_certificate
          end
          OpenSSL::X509::Certificate.new(cert.gsub(/  /, '')).public_key
        end

        mattr_accessor :private_key
        mattr_accessor :test_private_key
        # Our RSA private key. OpenSSL container.
        def self.get_private_key
          if ActiveMerchant::Billing::Base.integration_mode == :production
            private_key = self.private_key
          else
            private_key = self.test_private_key
          end
          OpenSSL::PKey::RSA.new(private_key.gsub(/  /, ''))
        end

        mattr_accessor :test_url
        mattr_accessor :production_url
        def self.service_url
          mode = ActiveMerchant::Billing::Base.integration_mode
          case mode
          when :production
            self.production_url
          when :test
            self.test_url
          else
            raise StandardError, "Integration mode set to an invalid value: #{mode}"
          end
        end

        def self.notification(post)
          Notification.new(post)
        end

      end
    end
  end
end
