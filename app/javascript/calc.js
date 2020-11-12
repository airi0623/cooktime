$(function() {
  console.log("OK")
  $('.input-number').on('change',function(e){

    let klass = e.target.dataset.recipeId
    $(".amount." + klass).each(( index, element ) => {
      inputNum= e.target.value;

      let amount = element.innerHTML
      let klass = e.target.dataset.recipeId
      
      $(".output." + klass)[index].innerHTML = (inputNum * amount);
    });
  })
})