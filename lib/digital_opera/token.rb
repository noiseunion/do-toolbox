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
        alphanumerics = ('a'..'z').to_a.concat(('A'..'Z').to_a.concat(('0'..'9').to_a))
        secret_key    = alphanumerics.sort_by{rand}.join[0..key_len]
        secret_key
    end
  end
end