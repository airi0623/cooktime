if (location.pathname.match("recipes/about") ) {
  $(function() {
    $('#slick').slick({
      dots: true,
      infinite: true,
      speed: 300,
      fade: true,
      cssEase: 'linear',
      
      autoplay:true,
      arrows: false,
      infinite: true
    });
  });
};