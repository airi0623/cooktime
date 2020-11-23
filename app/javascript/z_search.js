if (location.pathname.match("recipes/new")){
  document.addEventListener('DOMContentLoaded', function(){
    
    const inputElement = document.querySelector(`#thing-select[data-select="0"]`);
    inputElement.addEventListener("keyup",function(e){
      console.log("OK")
      const keyword = document.querySelector(`#thing-select[data-select="0"]`).value;
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `search_thing/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        const searchResult = document.querySelector(`#search-result[data-result="0"]`);
        console.log(searchResult)
        searchResult.innerHTML = "";

        if (XHR.response) {
          const tagName = XHR.response.keyword;
          tagName.forEach((tag) => {
            const childElement = document.createElement("div");
            childElement.setAttribute("class", "result");
            childElement.setAttribute("id", tag.id);
            childElement.innerHTML = tag.thing_name;
            searchResult.appendChild(childElement);
            
            const clickElement = document.getElementById(tag.id);
            clickElement.addEventListener("click", () => {
              document.querySelector(`#thing-select[data-select="0"]`).value = clickElement.textContent;
              
              const dataSpoon = document.querySelector(`#spoon-auto[data-spoon="0"]`);
              const dataUnit = document.querySelector(`#unit-auto[data-unit="0"]`);
              dataUnit.innerHTML = tag.unit;
              dataSpoon.innerHTML = tag.spoon;

              clickElement.remove();
              searchResult.innerHTML = "";
            });
          });
        };
      };
    });

    let index = 1;
    $('.inserted-item') 
      .on('cocoon:after-insert', function(e, insertedItem) {
        $(insertedItem).find('.select').attr('data-select', index);
        $(insertedItem).find('.box-spoon').attr('data-spoon', index);
        $(insertedItem).find('.box-unit').attr('data-unit', index);
        $(insertedItem).find('.box-search').attr('data-result', index);
        index = index+1

        $('.select').on('keyup', function(e){
          const keyword = $(`[data-select="${e.target.dataset.select}"]`).val();
          const XHR = new XMLHttpRequest();
          XHR.open("GET", `search_thing/?keyword=${keyword}`, true);
          XHR.responseType = "json";
          XHR.send();
          XHR.onload = () => {
            const secondResult = $(`#search-result[data-result="${e.target.dataset.select}"]`);
            console.log(secondResult)
            secondResult.innerHTML = "";
            
            if (XHR.response) {
              const tagName = XHR.response.keyword;
              tagName.forEach((tag) => {
                const childElement2 = document.createElement("div");
                childElement2.setAttribute("class", "result");
                childElement2.setAttribute("id", tag.id);
                childElement2.innerHTML = tag.thing_name;
                secondResult.appendChild(childElement2);
                
                const clickElement = $(tag.id);
                clickElement.on('click', function(e){
                  console.log(e)
                  $(`#thing-select[data-select="0"]`).value = clickElement.textContent;
                  
                  const dataSpoon = document.querySelector(`#spoon-auto[data-spoon="${e.target.dataset.select}"]`);
                  const dataUnit = document.querySelector(`#unit-auto[data-unit="${e.target.dataset.select}"]`);
                  dataUnit.innerHTML = tag.unit;
                  dataSpoon.innerHTML = tag.spoon;
    
                  clickElement.remove();
                  searchResult.innerHTML = "";
                });
              });
            };

          };
        });
      })
  });
};