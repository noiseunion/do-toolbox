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

        first.on('click', function(e){
          loggedEvent = e;
        });

        first.click();

        jasmine.clock().tick(1000);

        expect(window.digitalOpera.isClickOutsideElement(loggedEvent, second)).toBe(true);
      });
    });

    describe('when click is inside of element', function(){
      it("should return false if click is on element inside", function() {
        var loggedEvent;

        second.on('click', function(e){
          loggedEvent = e;
        });
        second.click();

        jasmine.clock().tick(1000);

        expect(window.digitalOpera.isClickOutsideElement(loggedEvent, first)).toBe(false);
      });

      it("should return false if click was on element", function() {
        var loggedEvent;

        second.on('click', function(e){
          loggedEvent = e;
        });
        second.click();

        expect(window.digitalOpera.isClickOutsideElement(loggedEvent, second)).toBe(false);
      });
    });
  });
});