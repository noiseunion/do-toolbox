describe("events", function() {
  describe("#isClickOutsideElement", function(){
    var first, second;

    beforeEach(function(){
      first = $('<div id="first-element"></div>');
      second = $('<div id="second-element"></div>');
      $('body').append(first);
      first.append(second);
    });

    afterEach(function(){
      first.remove();
      second.remove();
    });

    describe('when click is outside of element', function(){
      it("should return true", function() {
        var loggedEvent;

        runs(function(){
          first.on('click', function(e){
            loggedEvent = e;
          });
          setTimeout(function(){
            first.click();
          });
        });

        waitsFor(function(){
          return typeof loggedEvent !== 'undefined';
        }, 'waiting for click', 1000)

        runs(function(){
          expect(window.digitalOpera.isClickOutsideElement(loggedEvent, second)).toBe(true);
        });
      });
    });

    describe('when click is inside of element', function(){
      it("should return false if click is on element inside", function() {
        var loggedEvent;

        runs(function(){
          second.on('click', function(e){
            loggedEvent = e;
          });
          setTimeout(function(){
            second.click();
          });
        });

        waitsFor(function(){
          return typeof loggedEvent !== 'undefined';
        }, 'waiting for click', 1000)

        runs(function(){
          expect(window.digitalOpera.isClickOutsideElement(loggedEvent, first)).toBe(false);
        });
      });

      it("should return false if click was on element", function() {
        var loggedEvent;

        runs(function(){
          second.on('click', function(e){
            loggedEvent = e;
          });
          setTimeout(function(){
            second.click();
          });
        });

        waitsFor(function(){
          return typeof loggedEvent !== 'undefined';
        }, 'waiting for click', 1000)

        runs(function(){
          expect(window.digitalOpera.isClickOutsideElement(loggedEvent, second)).toBe(false);
        });
      });
    });
  });
});