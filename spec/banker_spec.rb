require 'spec_helper'
require 'support/user'

describe DigitalOpera::Banker do
  subject { User.new }

  it{ should be_respond_to :money_in_account }
  it{ should be_respond_to :money_in_account= }
  it{ should be_respond_to :money_in_account_in_cents }
  it{ should be_respond_to :money_in_account_in_cents= }

  context 'from string' do
    it 'should convert to cents' do
      subject.money_in_account = '15.31'
      subject.money_in_account_in_cents.should eq 1531
    end

    it 'should convert to cents' do
      subject.money_in_account_in_cents = '1531'
      subject.money_in_account.should eq '15.31'
    end
  end

  context 'from int' do
    it 'should convert to cents' do
      subject.money_in_account = 15.31
      subject.money_in_account_in_cents.should eq 1531
    end

    it 'should convert to cents' do
      subject.money_in_account_in_cents = 1531
      subject.money_in_account.should eq '15.31'
    end
  end
end