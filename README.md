[![Gem Version](https://badge.fury.io/rb/digital_opera.png)](http://badge.fury.io/rb/digital_opera)
[![Coverage Status](https://coveralls.io/repos/noiseunion/do-toolbox/badge.png)](https://coveralls.io/r/noiseunion/do-toolbox)

# DigitalOpera

## Presenter/Decorator

Presenters allow a nice way to 'present' model data without adding methods directly to the model.

To create a presenter:

```ruby
class UserPresenter < DigitalOpera::Presenter::Base
  def name
    if self.first_name.present? && self.last_name.present?
      "#{self.first_name} #{self.last_name}"
    else
      self.email
    end
  end
end
```

Instantiation:
```ruby
UserPresenter.new(User.first)
```

Use:

```ruby
presenter = UserPresenter.new(User.first)

presenter.name # John Doe or john.doe@example.com
presenter.first_name # John
```

### Methods

#### .source
If you need to get the source object, you can call `source` on the presenter instance.

```ruby
presenter # instance of UserPresenter
presenter.source # instance of User
```

#### ._h
User `_h` to get the view_context

This project rocks and uses MIT-LICENSE.
