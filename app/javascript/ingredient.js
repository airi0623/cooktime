$(function() {

  $('.select').on('change',function(e){
    //spoonとunitを定義
    const dataUnit = $("option:selected", this).data("unit");
    const dataSpoon = $("option:selected", this).data("spoon");
    //データを入れる
    $(`[data-unit="0"]`).text(dataUnit)
    $(`[data-spoon="0"]`).text(dataSpoon)
  });

  let index = 1;
  $('.inserted-item') 
    .on('cocoon:after-insert', function(e, insertedItem) {
      $(insertedItem).find('.select').attr('data-select', index);
      $(insertedItem).find('.box-spoon').attr('data-spoon', index);
      $(insertedItem).find('.box-unit').attr('data-unit', index);
      $(insertedItem).find('.box-result').attr('data-result', index);
      index = index+1

      $('.select').on('change',function(e){
        const dataSelect = $(this).attr('data-select')
        //spoonとunitを定義
        const dataUnit = $("option:selected", this).data("unit");
        const dataSpoon = $("option:selected", this).data("spoon");
        //データを入れる
        $(`[data-unit="${dataSelect}"]`).text(dataUnit)
        $(`[data-spoon="${dataSelect}"]`).text(dataSpoon)
      })
    })
})