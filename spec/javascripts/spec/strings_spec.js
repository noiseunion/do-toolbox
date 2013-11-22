describe("strings", function() {
  describe("#capitalize", function(){
    it('should capitalize first character', function(){
      expect(window.digitalOpera.capitalize('foobar')).toBe('Foobar');
    });

    it('should capitalize first character of only first word', function(){
      expect(window.digitalOpera.capitalize('foo bar')).toBe('Foo bar');
    });

    it('should not change any character besides first', function(){
      expect(window.digitalOpera.capitalize('foObar')).toBe('FoObar');
    });
  });

  describe("#titleize", function(){
    it('should capitalize first character', function(){
      expect(window.digitalOpera.titleize('foobar')).toBe('Foobar');
    });

    it('should capitalize first character of each word', function(){
      expect(window.digitalOpera.titleize('foo bar')).toBe('Foo Bar');
    });

    it('should lowercase all characters beside the first char of each word', function(){
      expect(window.digitalOpera.titleize('foO bAr')).toBe('Foo Bar');
    });
  });

  describe("#formatJSONErrors", function(){
    var string = '{"email": ["must be at least 6 characters","must contain a number and a letter"], "name":["can not be blank"]}';
    var json = JSON.parse(string);

    it('should take a string', function(){
      expect(function(){window.digitalOpera.formatJSONErrors(string)}).not.toThrow();
    });

    it('should take JSON', function(){
      expect(function(){window.digitalOpera.formatJSONErrors(json)}).not.toThrow();
    });

    it('should make error sentences', function(){
      expect(window.digitalOpera.formatJSONErrors(string)[0]).toMatch('Email must be at least 6 characters and must contain a number and a letter');
      expect(window.digitalOpera.formatJSONErrors(string)[1]).toMatch('Name can not be blank');
    });

    it('should have 2 errors', function(){
      expect(window.digitalOpera.formatJSONErrors(string).length).toBe(2);
    });
  });
});