require 'spec_helper'

describe Object do

  describe '#be_nil_or_zero?' do

    context 'numbers' do
      it 'should be false' do
        (1.1).should_not be_nil_or_zero
      end

      it 'should be false' do
        1.should_not be_nil_or_zero
      end

      it 'should be true' do
        0.should be_nil_or_zero
      end
    end

    context 'string' do
      it 'should be false' do
        'boo'.should_not be_nil_or_zero
      end

      it 'should be false' do
        ''.should_not be_nil_or_zero
      end
    end

    context 'array' do
      it 'should be false' do
        [].should_not be_nil_or_zero
      end

      it 'should be false' do
        [1,2,3].should_not be_nil_or_zero
      end

      it 'should be false' do
        ['12',2,3].should_not be_nil_or_zero
      end

      it 'should be false' do
        [''].should_not be_nil_or_zero
      end
    end

    context 'hash' do
      it 'should be false' do
        {}.should_not be_nil_or_zero
      end

      it 'should be false' do
        {foo: 'bar'}.should_not be_nil_or_zero
      end
    end

    context 'nil' do
      it 'should be true' do
        nil.should be_nil_or_zero
      end
    end

  end

end