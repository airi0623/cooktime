$(function() {
  console.log("OK")
  $('#slide').slick({
    dots: true,
    infinite: true,
    speed: 500,
    fade: true,
    cssEase: 'linear',

    arrows: false
  });
});

