require 'spec_helper'

describe DigitalOpera::Token do
  subject { DigitalOpera::Token.generate }
  its(:length){ should eq 40 }
  it{ should match /[0-9a-zA-Z]+/ }

  it 'should change length' do
    DigitalOpera::Token.generate(256).length.should eq 256
  end
end