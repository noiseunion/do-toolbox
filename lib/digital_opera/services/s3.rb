require 'aws'

## Service for handling interactions with S3
##
module DigitalOpera
  module Services
    class S3
      def initialize(document, options={})
        throw 'AWS SDK is required' if !defined?(AWS) || AWS.nil?

        if document.class == String
          @key = self.get_key(document)
        else
          @document = document
        end

        @options = {
          acl: 'authenticated-read'
        }.merge(options)
      end

      def document
        @document
      end

      def base_url
        "https://#{self.bucket_name}.s3.amazonaws.com/"
      end

      def key
        @key ||= if document.s3_key.present?
          self.get_key document.s3_key
        else
          nil
        end
      end

      def document_name
        if key.present?
          key.downcase.split('/').last
        else
          nil
        end
      end

      def public_url
        if self.s3_object.present?
          self.s3_object.public_url.to_s
        else
          nil
        end
      end

      def private_url
        if self.s3_object.present?
          disposition = "attachment; filename=#{document_name.parameterize}"
          self.s3_object.url_for(:read, :expires => self.expiration(10.minutes), :response_content_disposition => disposition).to_s
        else
          nil
        end
      end

      def expiration(time=10.hours)
        (time).from_now.to_time.iso8601
      end

      def delete
        s3_object.delete
      end

      def policy
        Base64.encode64(self.policy_data.to_json).gsub("\n", "")
      end

      def policy_data
        {
          expiration: self.expiration,
          conditions: [
            ["starts-with", "$utf8", ""],
            ["starts-with", "$key", ""],
            { bucket: self.bucket_name },
            { acl: @options[:acl] }
          ]
        }
      end

      def s3_object
        @s3_object ||= if self.key.present?
          self.bucket.objects[self.key]
        else
          nil
        end
      end

      def signature
        Base64.encode64(
          OpenSSL::HMAC.digest(
            OpenSSL::Digest::Digest.new('sha1'),
            self.secret_access_key, policy
          )
        ).gsub("\n", "")
      end

      def upload_key
        'documents/${filename}'
      end

      def bucket
        ::AWS::S3.new.buckets[self.bucket_name]
      end

      def bucket_name
        self.class.bucket_name
      end

      def access_key
        self.class.access_key
      end

      def secret_access_key
        self.class.secret_access_key
      end

      def get_key(url)
        if url.start_with? self.base_url
          url.split(self.base_url).last
        else
          if url.start_with? '/'
            url[1..(url.length-1)]
          else
            url
          end
        end
      end

      def self.bucket_name
        ENV["S3_BUCKET_NAME"]
      end

      def self.access_key
        ENV["S3_ACCESS_KEY"]
      end

      def self.secret_access_key
        ENV["S3_SECRET_ACCESS_KEY"]
      end
    end
  end
end