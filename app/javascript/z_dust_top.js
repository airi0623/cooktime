// とまと参考

$(function() {
// document.addEventListener('DOMContentLoaded', function(){
  $.getJSON("/play/asobu.json?v=" + Math.random(), getFunc);
  
  function topInit(){
    var topSlideID = 0;
    var zindex = 0;
      topSlideLeng = $('.mv-main-img > span').length;
    for(var i = 0; i < topSlideLeng; i++) {
      $('.img__scroll--circle').append('<li></li>');
    }
    topInterval = setInterval(topSlide,5000);
    topImgSlide();
    
    function topSlide(){
      if(topSlideID >= topSlideLeng - 1) {
        topSlideID = 0;
      } else {
        topSlideID++;
      }
      topImgSlide();
    }
    function topImgSlide(){
      var $elm = $('.mv-main-img > span').eq(topSlideID);
      zindex++;
      $elm.show().css({'z-index' : zindex});
      TweenMax.fromTo($elm, 1, { opacity: 0}, { opacity: 1, ease: Power2.easeInOut,onComplete: function(){ 
      }});
      $('.img__scroll--circle li').removeClass('selected');
      $('.img__scroll--circle li').eq(topSlideID).addClass('selected');
    }
  }
  setTimeout(function() {
    topInit();
  },900);
});

