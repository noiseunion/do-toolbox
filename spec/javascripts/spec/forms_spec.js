describe("forms", function() {
  describe('#parameterizeObject', function(){
    var obj = {
      foo: 'bar',
      test: {
        jasper: 'johns',
        jimmie: {
          car: 24,
          name: 'johnson'
        }
      }
    }

    it('should go one level deep', function(){
      expect(window.digitalOpera.parameterizeObject(obj)['foo']).toBe('bar');
    });

    it('should go 2+ levels deep', function(){
      expect(window.digitalOpera.parameterizeObject(obj)['test[jasper]']).toBe('johns');
      expect(window.digitalOpera.parameterizeObject(obj)['test[jimmie][car]']).toBe(24);
    });
  });

});