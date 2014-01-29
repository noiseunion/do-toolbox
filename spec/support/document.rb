class Document
  # simulate fields
  attr_accessor :s3_key

  def initialize(opts)
    opts.each do |key, val|
      self.send "#{key}=", val if self.respond_to? "#{key}="
    end
  end
end