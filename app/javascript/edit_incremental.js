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
    console.log(i)
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











  });
};