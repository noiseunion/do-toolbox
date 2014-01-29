##
## https://github.com/railscasts/383-uploading-to-amazon-s3/blob/master/gallery-jquery-fileupload/app/helpers/upload_helper.rb
##
module DigitalOpera
  module Builders
    class S3FormBuilder
      def initialize(options)


        @options = {
          id: "file_upload",
          aws_access_key_id: ENV["S3_ACCESS_KEY"],
          aws_secret_access_key: ENV["S3_SECRET_ACCESS_KEY"],
          bucket: S3Uploader.bucket,
          acl: "authenticated-read",
          expiration: 10.hours.from_now.to_time.iso8601,
          max_file_size: nil,
          as: "file",
          post_method: 'post',
          class: '',
          success_action_redirect: nil,
          data: {}
        }.merge(options)
      end

      def form_options
        hash = {
          id: @options[:id],
          method: "post",
          authenticity_token: false,
          multipart: true,
          class: @options[:class],
          data: {
            post: @options[:post],
            as: @options[:as],
            post_method: @options[:post_method],
            post_authenticity_token: @options[:post_authenticity_token]
          }
        }

        hash[:data][:max_file_size] = @options[:max_file_size] if @options[:max_file_size].present?
        @options[:data].each do |k,v|
          hash[:data][k] = v
        end

        hash
      end

      def fields
        hash = {
          :key => key,
          :acl => @options[:acl],
          :policy => policy,
          :signature => signature,
          "AWSAccessKeyId" => @options[:aws_access_key_id]
          #:success_action_redirect => @options[:post]
        }
        if @options[:success_action_redirect].present?
          hash[:success_action_redirect] = @options[:success_action_redirect]
        end

        hash
      end

      def key
        @key ||= "accounts/#{@account.id.to_s}/#{@options[:type]}/#{SecureRandom.hex}/${filename}"
      end

      def url
        S3Uploader.url
      end

      def policy
        Base64.encode64(policy_data.to_json).gsub("\n", "")
      end

      def policy_data
        hash = {
          expiration: @options[:expiration],
          conditions: [
            ["starts-with", "$utf8", ""],
            ["starts-with", "$key", ""],
            # ["content-length-range", 0, @options[:max_file_size]],
            {bucket: @options[:bucket]},
            {acl: @options[:acl]}
          ]
        }

        if @options[:max_file_size].present?
          hash[:conditions].push( ["content-length-range", 0, @options[:max_file_size]] )
        end

        if @options[:success_action_redirect].present?
          hash[:conditions].push( { success_action_redirect: @options[:success_action_redirect] } )
        end

        hash
      end

      def signature
        Base64.encode64(
          OpenSSL::HMAC.digest(
            OpenSSL::Digest::Digest.new('sha1'),
            @options[:aws_secret_access_key], policy
          )
        ).gsub("\n", "")
      end

      def self.url
        "https://#{S3Uploader.bucket}.s3.amazonaws.com/"
      end

      def self.bucket
        ENV["S3_BUCKET_NAME"]
      end
    end
  end
end