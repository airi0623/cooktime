$(function() {
  $('#input-calc').on('change',function(e){
    console.log("OK")
    amount = $('#amount').text();
    console.log(amount)
    inputNun = $('#input-calc').val();
    $('#output').text(inputNun * amount);
  

  })
})