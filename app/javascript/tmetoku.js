if (location.pathname.match("/edit") ) {
  document.addEventListener('DOMContentLoaded', function(){

  const selectClass = document.querySelectorAll('.select')
  //console.log(selectClass)
    selectClass.forEach(function(select, index){
      select.dataset.select = "edit-"+index
    });
  const inputHidden = document.querySelectorAll('.box-thing')
  //console.log(typeHidden)
    inputHidden.forEach(function(hidden, index){
      hidden.dataset.thing = "edit-"+index
  });
  const boxSpoon = document.querySelectorAll('.box-spoon')
    boxSpoon.forEach(function(spoon, index){
      spoon.dataset.thing = "edit-"+index
  });
  // const boxAmount = document.querySelectorAll('.ingredients-amount')
  // boxAmount.forEach(function(amount, index){
  //     amount.dataset.thing = "edit-"+index
  // });
  const boxUnit = document.querySelectorAll('.box-unit')
    boxUnit.forEach(function(unit, index){
      unit.dataset.thing = "edit-"+index

      
  });
  // clickイベントが起きる前のイベントを動かす
 
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
};