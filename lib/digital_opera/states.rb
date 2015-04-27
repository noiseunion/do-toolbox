module DigitalOpera
  class States
    US_STATES =  [
      ['Alabama', 'AL'],
      ['Alaska', 'AK'],
      ['American Samoa', 'AS'],
      ['Arizona', 'AZ'],
      ['Arkansas', 'AR'],
      ['California', 'CA'],
      ['Colorado', 'CO'],
      ['Connecticut', 'CT'],
      ['Delaware', 'DE'],
      ['District of Columbia', 'DC'],
      ['Federated States of Micronesia', 'FM'],
      ['Florida', 'FL'],
      ['Georgia', 'GA'],
      ['Guam', 'GU'],
      ['Hawaii', 'HI'],
      ['Idaho', 'ID'],
      ['Illinois', 'IL'],
      ['Indiana', 'IN'],
      ['Iowa', 'IA'],
      ['Kansas', 'KS'],
      ['Kentucky', 'KY'],
      ['Louisiana', 'LA'],
      ['Maine', 'ME'],
      ['Marshall Islands', 'MH'],
      ['Maryland', 'MD'],
      ['Massachusetts', 'MA'],
      ['Michigan', 'MI'],
      ['Minnesota', 'MN'],
      ['Mississippi', 'MS'],
      ['Missouri', 'MO'],
      ['Montana', 'MT'],
      ['Nebraska', 'NE'],
      ['Nevada', 'NV'],
      ['New Hampshire', 'NH'],
      ['New Jersey', 'NJ'],
      ['New Mexico', 'NM'],
      ['New York', 'NY'],
      ['North Carolina', 'NC'],
      ['North Dakota', 'ND'],
      ['Northern Mariana Islands', 'MP'],
      ['Ohio', 'OH'],
      ['Oklahoma', 'OK'],
      ['Oregon', 'OR'],
      ['Palau', 'PW'],
      ['Pennsylvania', 'PA'],
      ['Puerto Rico', 'PR'],
      ['Rhode Island', 'RI'],
      ['South Carolina', 'SC'],
      ['South Dakota', 'SD'],
      ['Tennessee', 'TN'],
      ['Texas', 'TX'],
      ['Utah', 'UT'],
      ['Vermont', 'VT'],
      ['Virgin Islands', 'VI'],
      ['Virginia', 'VA'],
      ['Washington', 'WA'],
      ['West Virginia', 'WV'],
      ['Wisconsin', 'WI'],
      ['Wyoming', 'WY']
    ]

    def self.to_collection(mapping={})
      @collection = (
        states = US_STATES

        if mapping[:key].present? || mapping[:value].present?
          states =US_STATES.map do |state|
            key = state.last
            value = state.first

            if mapping[:value] == :abbr
              value = state.last
            elsif mapping[:value] == :name
              value = state.first
            end

            if mapping[:key] == :name
              key = state.first
            elsif mapping[:key] == :abbr
              key = state.last
            end

            [value, key]

          end
        end

        states.sort{|a, b| a.first <=> b.first }
      )
    end

    def self.abbreviations
      to_hash.keys.sort
    end

    def self.names
      to_hash.values.sort
    end

    def self.find_name_by_abbreviation(abbr)
      to_hash[abbr.to_s.upcase]
    end

    def self.find_abbreviation_by_name(name)
      to_hash.detect{ |k, v| v == name.to_s.capitalize }.first
    end

    def self.to_hash
      @hash ||= (
        h = {}
        US_STATES.map{ |state| h[state.last] = state.first }
        h
      )
    end
  end
end