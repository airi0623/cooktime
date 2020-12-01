if (location.pathname.match("/edit") ) {
  document.addEventListener('DOMContentLoaded', function(){
  //既に存在する材料にカスタムデータ属性を与える
    const selectClass = document.querySelectorAll('.select')
      selectClass.forEach(function(select, index){
        select.dataset.select = "edit-"+index
      });
    const inputHidden = document.querySelectorAll('.box-thing')
      inputHidden.forEach(function(hidden, index){
        hidden.dataset.thing = "edit-"+index
    });
    const boxResult = document.querySelectorAll('.box-result')
    boxResult.forEach(function(result, index){
      result.dataset.result = "edit-"+index
    });
    const boxSpoon = document.querySelectorAll('.box-spoon')
      boxSpoon.forEach(function(spoon, index){
        spoon.dataset.spoon = "edit-"+index
    });
    const boxUnit = document.querySelectorAll('.box-unit')
    boxUnit.forEach(function(unit, index){
      unit.dataset.unit = "edit-"+index
    });
    //既に存在する材料に単位を表示させる
    const times = document.querySelectorAll('.select').length
    for ( let i = 0; i < times; i++ ) {
      const keyValue = document.querySelector(`#id-thing[data-thing="edit-${i}"]`).value
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `search_record/?keyword=${keyValue}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        const thingRecord = XHR.response.keyword;
        document.querySelector(`#spoon-auto[data-spoon="edit-${i}"]`).innerHTML = thingRecord[0].spoon;
        document.querySelector(`#unit-auto[data-unit="edit-${i}"]`).innerHTML = thingRecord[0].unit;
      };
    }

    $('.select').on('keyup', function(){
      const dataSelectNum = $(this).attr('data-select')
      const keyword = document.querySelector(`#thing-select[data-select="${dataSelectNum}"]`).value;
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `search_thing_edit/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        const searchResult = document.querySelector(`#search-result[data-result="${dataSelectNum}"]`);
        searchResult.innerHTML = "";
        
        if (XHR.response) {
          const tagName = XHR.response.keyword;
          console.log(tagName)
          tagName.forEach((tag) => {
            const childElement = document.createElement("div");
            childElement.setAttribute("class", "result");
            childElement.setAttribute("id", tag.id);
            childElement.setAttribute("value", tag.id);
            childElement.innerHTML = tag.thing_name;
            searchResult.appendChild(childElement);
          
            const clickElement = document.getElementById(tag.id);
            clickElement.addEventListener("click", () => {
              document.querySelector(`#thing-select[data-select="${dataSelectNum}"]`).value = clickElement.textContent;
              document.querySelector(`#id-thing[data-thing="${dataSelectNum}"]`).value = tag.id;
              document.querySelector(`#spoon-auto[data-spoon="${dataSelectNum}"]`).innerHTML = tag.spoon;
              document.querySelector(`#unit-auto[data-unit="${dataSelectNum}"]`).innerHTML = tag.unit;

              clickElement.remove();
              searchResult.innerHTML = "";
            });
          });
        };
      };
    });
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
    // ２つ目以降 **JqueryとJavascriptのあたいの取得方法が違うのか、混同するとうまくいかなかった
    $('.inserted-item') 
    .on('cocoon:after-insert', function() {
      $('.select').on('keyup', function(){
        const dataSelectNum = $(this).attr('data-select')
        const keyword = document.querySelector(`#thing-select[data-select="${dataSelectNum}"]`).value;
        const XHR = new XMLHttpRequest();
        XHR.open("GET", `search_thing_edit/?keyword=${keyword}`, true);
        XHR.responseType = "json";
        XHR.send();
        XHR.onload = () => {
          const searchResult2 = document.querySelector(`#search-result[data-result="${dataSelectNum}"]`);
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