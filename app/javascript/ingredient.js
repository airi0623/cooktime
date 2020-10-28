if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
  document.addEventListener('DOMContentLoaded', function(){

    $('.form-box').click(function() {
      //クローンを変数に格納
      var clonecode = $('.box:last').clone(true);
  });
}