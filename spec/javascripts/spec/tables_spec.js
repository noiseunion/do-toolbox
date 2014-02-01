describe("tables", function() {
  describe('row click with [data-href]', function(){
    var table,
        focusObject = {focus: function(){}};

    beforeEach(function(){
      table = $('<table><tr data-href="http://google.com">item1</td></tr></table>');
      $('body').append(table);
    });

    afterEach(function(){
      table.remove();
    });

    it('should navigate to link location', function(){
      spyOn(window.digitalOpera.forTestingPurposes, 'getWindowLocation');
      table.find('tr:first').click();
      expect(window.digitalOpera.forTestingPurposes.getWindowLocation).toHaveBeenCalled();
    });

    it('should open new window if has data-does="open-window"', function(){
      spyOn(window, 'open').and.returnValue(focusObject);
      table.find('tr:first').attr('data-does', 'open-window');
      table.find('tr:first').click();
      expect(window.open).toHaveBeenCalled();
    });

    it('should not follow link if click is within the anchor', function(){
      var anchor = $('<a href="http://bing.com">my link</a>')
      table.find('tr:first td:first').append(anchor);
      spyOn(window, 'open').and.returnValue(focusObject);
      spyOn(window.digitalOpera.forTestingPurposes, 'getWindowLocation');
      anchor.click();
      expect(window.open).not.toHaveBeenCalled();
      expect(window.digitalOpera.forTestingPurposes.getWindowLocation).not.toHaveBeenCalled();
    });

    it('should not follow link if click is within a span within the anchor', function(){
      var anchor = $('<a href="http://bing.com"><span>my link</span></a>')
      table.find('tr:first td:first').append(anchor);
      spyOn(window, 'open').and.returnValue(focusObject);
      spyOn(window.digitalOpera.forTestingPurposes, 'getWindowLocation');
      anchor.find('span').click();
      expect(window.open).not.toHaveBeenCalled();
      expect(window.digitalOpera.forTestingPurposes.getWindowLocation).not.toHaveBeenCalled();
    });
  });
});