describe("preload_images", function() {
  describe("#preload_images", function(){
    var google = 'https://www.google.com/images/srpr/logo11w.png',
        yahoo = 'http://hsrd.yahoo.com/_ylt=Aik.d0d_wDz.Tgk8eZ3.fQebvZx4/RV=1/RE=1386289411/RH=aHNyZC55YWhvby5jb20-/RO=2/RU=aHR0cDovL3d3dy55YWhvby5jb20v/RS=%5EADApJ47g2yGOT5vjkk0x6iSuoumc_w-',
        bad = 'http://www.digitalopera.com/bad.png';

    it('should take a string', function(){
      expect(function(){window.digitalOpera.preloadImages(google)}).not.toThrow();
    });

    it('should take an array', function(){
      expect(function(){window.digitalOpera.preloadImages([google])}).not.toThrow();
    });

    it('should callback once a single image loaded', function(){
      var images,
          callbackCalled = false;

      runs(function(){
        images = window.digitalOpera.preloadImages(google, function(){
          callbackCalled = true;
        });
      });

      waitsFor(function(){
        return callbackCalled == true;
      }, 'callback should have been called', 5000);

      runs(function(){
        expect(images[0].complete).toBe(true);
      });

    });

    it('should callback once all images are loaded', function(){
      var images,
          callbackCalled = false;

      runs(function(){
        images = window.digitalOpera.preloadImages([google, yahoo], function(){
          callbackCalled = true;
        });
      });

      waitsFor(function(){
        return callbackCalled == true;
      }, 'callback should have been called', 5000);

      runs(function(){
        expect(images[0].complete).toBe(true);
        expect(images[1].complete).toBe(true);
      });

    });

    it('should callback if there was an error', function(){
      var images,
          callbackCalled = false;

      runs(function(){
        images = window.digitalOpera.preloadImages(bad, function(){
          callbackCalled = true;
        });
      });

      waitsFor(function(){
        return callbackCalled == true;
      }, 'callback should have been called', 5000);

      runs(function(){
        expect(images[0].complete).toBe(true);
      });
    });

  });
});