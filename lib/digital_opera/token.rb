##
# Class:  Token
# Author: JD Hendrickson
# Date:   07/16/2011
#
# Generates random alpha-numeric strings of the specified key length.
# Default key length is 40 characters.
module DigitalOpera
  class Token
    def self.generate(key_len = 40)
      alphanumerics = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
      (0...key_len).map{ alphanumerics[rand(alphanumerics.length)] }.join
    end
  end
end