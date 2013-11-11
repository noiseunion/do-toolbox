require 'spec_helper'
require 'support/user'
require 'support/base_presenter'
require 'action_controller'

describe DigitalOpera::Presenter::Base do
  let(:user) { User.new }

  describe 'delegating to base class' do
    subject{ DigitalOpera::Presenter::Base.new user }

    its(:first_name){ should eq 'John' }
    its(:last_name){ should eq 'Doe' }
    its(:source) { should eq user }
    its(:_h) { should be_respond_to :view_renderer }
  end

  describe 'overridden methods' do
    subject{ BasePresenter.new user }

    its(:first_name){ should eq 'Jane' }
    its(:last_name){ should eq 'Doe family' }
  end

  describe 'new methods' do
    subject{ BasePresenter.new user }

    its(:role) { should eq 'administrator' }
  end

end