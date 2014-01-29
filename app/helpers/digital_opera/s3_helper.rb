module DigitalOpera
  module S3Helper
    def s3_uploader_form(options = {}, &block)
      options[:post_authenticity_token] = form_authenticity_token
      builder = DigitalOpera::Builders::S3FormBuilder.new options

      form_tag(builder.url, builder.form_options) do
        builder.fields.map do |name, value|
          hidden_field_tag(name, value)
        end.join.html_safe + capture(&block)
      end
    end
  end
end