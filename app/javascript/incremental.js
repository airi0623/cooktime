if (location.pathname.match("recipes/new") ) {
  console.log("incremental")
  document.addEventListener('DOMContentLoaded', function(){

  // 追加フォームを区別するために数字を与える
  let index = 1;
  $('.inserted-item') 
    .on('cocoon:after-insert', function(e, insertedItem) {
      $(insertedItem).find('.select').attr('data-select', index);
      $(insertedItem).find('.box-thing').attr('data-thing', index);
      $(insertedItem).find('.box-spoon').attr('data-spoon', index);
      $(insertedItem).find('.box-unit').attr('data-unit', index);
      $(insertedItem).find('.box-result').attr('data-result', index);
      index = index+1
    });

  // clickイベントが起きる前のイベントを動かす
    const inputElement = document.querySelector(`#thing-select[data-select="0"]`);
    inputElement.addEventListener("keyup",function(){
      const keyword = document.querySelector(`#thing-select[data-select="0"]`).value;
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `search_thing/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        const searchResult = document.querySelector(`#search-result[data-result="0"]`);
        searchResult.innerHTML = "";

        if (XHR.response) {
          const tagName = XHR.response.keyword;
          console.log("1つ目"+tagName)
          tagName.forEach((tag) => {
            const childElement = document.createElement("div");
            childElement.setAttribute("class", "result");
            childElement.setAttribute("id", tag.id);
            childElement.innerHTML = tag.thing_name;
            searchResult.appendChild(childElement);
            
            const clickElement = document.getElementById(tag.id);
            clickElement.addEventListener("click", () => {
              document.querySelector(`#thing-select[data-select="0"]`).value = clickElement.textContent;
              document.querySelector(`#id-thing[data-thing="0"]`).value = tag.id;
              document.querySelector(`#spoon-auto[data-spoon="0"]`).innerHTML = tag.spoon;
              document.querySelector(`#unit-auto[data-unit="0"]`).innerHTML = tag.unit;
              clickElement.remove();
              searchResult.innerHTML = "";
            });
          });
        };
      };
    });

    // ２つ目以降 **JqueryとJavascriptのあたいの取得方法が違うのか、混同するとうまくいかなかった
    $('.inserted-item') 
    .on('cocoon:after-insert', function() {
      $('.select').on('keyup', function(){
        const dataSelectNum = $(this).attr('data-select')
        console.log("data属性は"+dataSelectNum)

        const keyword = document.querySelector(`#thing-select[data-select="${dataSelectNum}"]`).value;
        const XHR = new XMLHttpRequest();
        XHR.open("GET", `search_thing/?keyword=${keyword}`, true);
        XHR.responseType = "json";
        XHR.send();
        XHR.onload = () => {
          const searchResult2 = document.querySelector(`#search-result[data-result="${dataSelectNum}"]`);
          // うまくいかない記述 const searchResult2 = $(`[data-result="${dataSelectNum}"]`);
          searchResult2.innerHTML = "";
          
          if (XHR.response) {
            const tagName2 = XHR.response.keyword;
            console.log(tagName2)
            tagName2.forEach((tag) => {
              const childElement2 = document.createElement("div");
              childElement2.setAttribute("class", "result");
              childElement2.setAttribute("id", tag.id);
              childElement2.setAttribute("value", tag.id);
              childElement2.innerHTML = tag.thing_name;
              searchResult2.appendChild(childElement2);
            
              const clickElement2 = document.getElementById(tag.id);
              clickElement2.addEventListener("click", () => {
                document.querySelector(`#thing-select[data-select="${dataSelectNum}"]`).value = clickElement2.textContent;
                document.querySelector(`#id-thing[data-thing="${dataSelectNum}"]`).value = tag.id;
                document.querySelector(`#spoon-auto[data-spoon="${dataSelectNum}"]`).innerHTML = tag.spoon;
                document.querySelector(`#unit-auto[data-unit="${dataSelectNum}"]`).innerHTML = tag.unit;

                clickElement2.remove();
                searchResult2.innerHTML = "";
              });
            });
          };
        };
      });
    });
  });
};