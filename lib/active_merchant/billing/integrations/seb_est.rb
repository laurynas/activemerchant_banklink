require File.dirname(__FILE__) + '/seb_est/helper.rb'
require File.dirname(__FILE__) + '/seb_est/notification.rb'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:

      # This module implements bank payments through
      # SEB Eesti Ühispank (http://www.seb.ee/index/1305) using
      # their bank link service (see http://www.seb.ee/page/130212050205).
      #
      # Configuration:
      # ActiveMerchant::Billing::Integrations::SebEst.bank_certificate = File.read('cert')
      # ActiveMerchant::Billing::Integrations::SebEst.test_bank_certificate = File.read('cert')
      # ActiveMerchant::Billing::Integrations::SebEst.private_key = File.read('keyfile')
      # ActiveMerchant::Billing::Integrations::SebEst.test_private_key = File.read('keyfile')
      # ActiveMerchant::Billing::Integrations::SebEst.test_url = 'https://test-gateway.tld/gw'
      # ActiveMerchant::Billing::Integrations::SebEst.production_url = 'https://production-gateway.tld/gw/'
      #
      # The syntax of the helper is as follows:
      #   <% payment_service_for order_id, account_id,
      #     :amount => 50.00,
      #     :service => :seb_est do |service| %>
      #
      #     <% service.notify_url url_for(:action => 'notify', :only_path => false) %>
      #     <% service.cancel_return_url 'http://mystore.com' %>
      #   <% end %>
      #
      # The order_id parameter is a random id referencing the transaction (VK_STAMP)
      # The account_id parameter is a id given to you from the bank (VK_SND_ID)
      # The notify_url is the URL that the bank will send its responses.
      #
      # You can handle the notification in
      # your controller action as follows:
      #
      #   class NotificationController < ApplicationController
      #     include ActiveMerchant::Billing::Integrations
      #
      #     def notify
      #       # Notification class is automatically fetched based on the request parameters.
      #       notify = Pizza::Notification.get_notification(params)
      #
      #       if notify.acknowledge
      #         ... process order ... if notify.complete?
      #       else
      #         ... log possible hacking attempt ...
      #       end
      #     end
      #   end

      module SebEst

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

        # Our raw RSA private key, string format.
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
