require 'spec_helper'
require 'digital_opera/states'

describe DigitalOpera::States do
  subject{ DigitalOpera::States }

  describe '#to_collection' do
    its(:to_collection){ should include ['Alabama', 'AL']}
    it 'should have 51 records' do
      subject.to_collection.size.should eq 51
    end

    it 'should have a collection of arrays' do
      subject.to_collection.all?{ |item| item.is_a?(Array) }.should eq true
    end

    it 'should have a key matching the name' do
      subject.to_collection.all?{|item| item.first[0] == item.last[0] }.should be_true
    end
  end

  describe '#abbreviations' do
    its(:abbreviations){ should be_is_a Array }
    its(:abbreviations){ should include 'AK' }

    it 'should have 51 records' do
      subject.abbreviations.size.should eq 51
    end
  end

  describe '#names' do
    its(:names){ should be_is_a Array }
    its(:names){ should include 'Wyoming' }

    it 'should have 51 records' do
      subject.names.size.should eq 51
    end
  end

  describe '#find_name_by_abbreviation' do
    context 'when param is a string' do
      context 'when is uppercase' do
        it 'should find state names' do
          subject.find_name_by_abbreviation('MN').should eq 'Minnesota'
        end
      end

      context 'when is downcase' do
        it 'should find state names' do
          subject.find_name_by_abbreviation('mn').should eq 'Minnesota'
        end
      end

      context 'when is mixed case' do
        it 'should find state names' do
          subject.find_name_by_abbreviation('Mn').should eq 'Minnesota'
        end
      end
    end

    context 'when param is a symbol' do
      context 'when is uppercase' do
        it 'should find state names' do
          subject.find_name_by_abbreviation(:MN).should eq 'Minnesota'
        end
      end

      context 'when is downcase' do
        it 'should find state names' do
          subject.find_name_by_abbreviation(:mn).should eq 'Minnesota'
        end
      end

      context 'when is mixed case' do
        it 'should find state names' do
          subject.find_name_by_abbreviation(:Mn).should eq 'Minnesota'
        end
      end
    end
  end

  describe '#find_abbreviation_by_name' do
    context 'when param is a string' do
      context 'when is uppercase' do
        it 'should find state names' do
          subject.find_abbreviation_by_name('MINNESOTA').should eq 'MN'
        end
      end

      context 'when is downcase' do
        it 'should find state names' do
          subject.find_abbreviation_by_name('minnesota').should eq 'MN'
        end
      end

      context 'when is mixed case' do
        it 'should find state names' do
          subject.find_abbreviation_by_name('Minnesota').should eq 'MN'
        end
      end
    end

    context 'when param is a symbol' do
      context 'when is uppercase' do
        it 'should find state names' do
          subject.find_abbreviation_by_name(:MINNESOTA).should eq 'MN'
        end
      end

      context 'when is downcase' do
        it 'should find state names' do
          subject.find_abbreviation_by_name(:minnesota).should eq 'MN'
        end
      end

      context 'when is mixed case' do
        it 'should find state names' do
          subject.find_abbreviation_by_name(:Minnesota).should eq 'MN'
        end
      end
    end
  end

  describe '#to_hash' do
    it 'should be a hash' do
      subject.to_hash.should be_is_a(Hash)
    end

    it 'should have a key of abbreviation and a value of name' do
      subject.to_hash['KY'].should eq 'Kentucky'
    end

    it 'should keys of abbreviations' do
      subject.to_hash.keys.all?{|key| key.size.should eq 2 }
    end

    it 'should values of names' do
      subject.to_hash.values.all?{|key| key.size.should > 2 }
    end

    it 'should have a key matching the name' do
      subject.to_hash.all?{|key, value| key[0] == value[0] }.should be_true
    end
  end
end