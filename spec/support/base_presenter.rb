class BasePresenter < DigitalOpera::Presenter::Base
  def first_name
    'Jane'
  end

  def role
    'administrator'
  end

  def last_name
    "#{source.last_name} family"
  end
end