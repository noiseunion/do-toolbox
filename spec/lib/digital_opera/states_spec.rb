require 'spec_helper'
require 'digital_opera/states'

describe DigitalOpera::States do
  subject{ DigitalOpera::States }

  describe '#to_collection' do
    its(:to_collection){ should include ['Alabama', 'AL']}
    it 'should have 59 records' do
      subject.to_collection.size.should eq 59
    end

    it 'should have a collection of arrays' do
      subject.to_collection.all?{ |item| item.is_a?(Array) }.should eq true
    end

    context 'when mapping is supplied' do
      subject{ DigitalOpera::States.to_collection({key: :abbr, value: :name}) }

      it 'should not raise error' do
        expect{ subject }.to_not raise_error
      end

      it 'should have abbreviation as key' do
        subject.first.last.should eq 'AL'
      end

      it 'should have name as key' do
        subject = DigitalOpera::States.to_collection({key: :name})
        subject.first.last.should eq 'Alabama'
      end

      it 'should have abbreviation as key' do
        subject = DigitalOpera::States.to_collection({key: :abbr})
        subject.first.last.should eq 'AL'
      end

      it 'should have name as value' do
        subject = DigitalOpera::States.to_collection({value: :name})
        subject.first.first.should eq 'Alabama'
      end

      it 'should have abbreviation as value' do
        subject = DigitalOpera::States.to_collection({value: :abbr})
        subject.first.first.should eq 'AK'
      end

      it 'should have name as key and name as value' do
        subject = DigitalOpera::States.to_collection({key: :name, value: :name})
        subject.first.first.should eq 'Alabama'
        subject.first.last.should eq 'Alabama'
      end

      it 'should have abbreviation as key and abbreviation as value' do
        subject = DigitalOpera::States.to_collection({key: :abbr, value: :abbr})
        subject.first.first.should eq 'AK'
        subject.first.last.should eq 'AK'
      end

      it 'should have name as key and abbreviation as value' do
        subject = DigitalOpera::States.to_collection({key: :name, value: :abbr})
        subject.first.first.should eq 'AK'
        subject.first.last.should eq 'Alaska'
      end

      it 'should have abbreviation as key and name as value' do
        subject = DigitalOpera::States.to_collection({key: :abbr, value: :name})
        subject.first.first.should eq 'Alabama'
        subject.first.last.should eq 'AL'
      end
    end
  end

  describe '#abbreviations' do
    its(:abbreviations){ should be_is_a Array }
    its(:abbreviations){ should include 'AK' }

    it 'should have 59 records' do
      subject.abbreviations.size.should eq 59
    end
  end

  describe '#names' do
    its(:names){ should be_is_a Array }
    its(:names){ should include 'Wyoming' }

    it 'should have 59 records' do
      subject.names.size.should eq 59
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
  end
end