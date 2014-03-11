![Digital Opera, LLC](http://digitalopera.com/wp-content/uploads/2014/03/logo-symbol-text-orange-gary.png)

[![Gem Version](https://badge.fury.io/rb/digital_opera.png)](http://badge.fury.io/rb/digital_opera)

This Gem was created to store all of the crazy tricks, hacks and practices used by Digital Opera in various Ruby
based projects.  We figured it was easier to throw them all in a Gem than to keep copying them into projects
independently, and then we thought...maybe someone else would find them useful too!

If you do find this Gem to be useful, please let us know.

### Version 0.0.13
- Added [DigitalOpera::States](https://github.com/noiseunion/do-toolbox/wiki/DigitalOpera::States). This file is not included by default. Be sure to add `require 'digital_opera/states'` in the application.rb

### Version 0.0.12
- Bug fix in Banker - was causing float multiplication rounding error

### Version 0.0.10
- Bug fix in [ellipsis.js.coffee](https://github.com/noiseunion/do-toolbox/wiki/ellipsis.js.coffee)

### Version 0.0.9
- [digital_opera.js](https://github.com/noiseunion/do-toolbox/wiki/digital_opera.js)
- [ellipsis.js.coffee](https://github.com/noiseunion/do-toolbox/wiki/ellipsis.js.coffee)
- [events.js.coffee](https://github.com/noiseunion/do-toolbox/wiki/events.js.coffee)
- [forms.js.coffee](https://github.com/noiseunion/do-toolbox/wiki/forms.js.coffee)
- [preload_images.js.coffee](https://github.com/noiseunion/do-toolbox/wiki/preload_images.js.coffee)
- [strings.js.coffee](https://github.com/noiseunion/do-toolbox/wiki/strings.js.coffee)
- [tables.js.coffee](https://github.com/noiseunion/do-toolbox/wiki/tables.js.coffee)

### Version 0.0.8
- [DigitalOpera::Presenter::Base](https://github.com/noiseunion/do-toolbox/wiki/DigitalOpera::Presenter::Base) now delegates method_missing to source

### Version 0.0.7

- [DigitalOpera::Presenter::Base](https://github.com/noiseunion/do-toolbox/wiki/DigitalOpera::Presenter::Base)
- [DigitalOpera::Token](https://github.com/noiseunion/do-toolbox/wiki/Token-Builder)
- [DigitalOpera::Banker](https://github.com/noiseunion/do-toolbox/wiki/DigitalOpera::Banker)
- nil_or_zero?

### Licensing

This project rocks and uses MIT-LICENSE.
