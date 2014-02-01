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
      jasmine.clock().install()

      window.digitalOpera.ellipsis(element);

      jasmine.clock().tick(751);

      expect(element.text().length).toBe(1);

      jasmine.clock().tick(751);

      expect(element.text().length).toBe(2);

      jasmine.clock().tick(751);

      expect(element.text().length).toBe(3);

      jasmine.clock().tick(751);

      expect(element.text().length).toBe(0);

    });
  });
});