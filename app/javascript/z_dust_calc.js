$(function() {
  $('.input-number').on('change',function(e){

    console.log(e) 
    //eの中にイベントが起こった時に取ってきた内容が入っている
    console.log(e.target.dataset.recipeId)
    // recipeId = data-recipe-id="ここ" *recipeId書き方注意
    // data属性は"dataset"という形で渡される

    let klass = e.target.dataset.recipeId
    $(".amount." + klass).each(( index, element ) => {
      // .amountでとるとページ内の全てのクラスが取ってこられる
      // indexに要素数が入る

      inputNum= e.target.value;
      //DOM要素 inputへ入力された値を取得
      let amount = element.innerHTML
      //DOM要素 配列がelementに入って、その中のHTML要素を取得してamountで定義する

      let klass = e.target.dataset.recipeId
      $(".output." + klass)[index].innerHTML = (inputNum * amount);
      // ２つのclass名が与えられているセレクタを取得。>> .output .番号 ** .output.が""で囲まれてるのがミソ
      // DOM要素(Jqueryじゃないから'.text'ではHTML内置き換えられない)
      // index必要** .outputで撮ってくると複数あるからどのoutputなのかわからなくなる
    });
  })
})

// .input-number .amount .output全て取得する
// >> 数字が全て足されてえらいことなる
// data属性付与 data-recipe-id="<%=choice.recipe.id%>" class="amount <%=choice.recipe.id%>"  class="output <%=choice.recipe.id%>" 
// e.targetからdata属性の番号を取得
// $(".amount." + klass) 複数あるから処理を1回ずつ行うためにeachで回す
// $(".output." + klass)[index] 同様に複数あるのでindexでamountの回数と同じにする
// 詳細>> 
// .amount5つ取得
// 1回目のamount処理
// => .output5つ取得(多分配列)=>その中のindex番号の要素を取得=>innerHTMLで置き換える