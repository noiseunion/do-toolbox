describe("ellipsis", function() {
  describe("#ellipsis", function(){
    var element;

    beforeEach(function(){
      element = $('<div></div>');
      $('body').append(element);
    });

    afterEach(function(){
      element.remove();
    });

    it('should animate ellipsis', function(){
      len = element.text().length;

      runs(function(){
        window.digitalOpera.ellipsis(element);
      });

      waitsFor(function() {
        return element.text().length == (len + 1)
      }, "The text length should increment", 751);

      runs(function(){
        expect(element.text().length).toBe(1);
      });

      waitsFor(function() {
        return element.text().length == (len + 2)
      }, "The text length should increment", 751);

      runs(function(){
        expect(element.text().length).toBe(2);
      });

      waitsFor(function() {
        return element.text().length == (len + 3)
      }, "The text length should increment", 751);

      runs(function(){
        expect(element.text().length).toBe(3);
      });

      waitsFor(function() {
        return element.text().length == len
      }, "The text length should increment", 751);

      runs(function(){
        expect(element.text().length).toBe(0);
      });

    });
  });
});