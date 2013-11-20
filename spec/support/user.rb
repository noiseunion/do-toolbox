class User
  # simulate fields
  attr_accessor :money_in_account, :money_in_account_in_cents

  include DigitalOpera::Banker
  currency_fields :money_in_account

  def first_name
    'John'
  end

  def last_name
    'Doe'
  end

  def family_name
    'Dido'
  end
end