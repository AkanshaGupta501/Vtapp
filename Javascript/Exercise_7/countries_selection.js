function countryListManager(options){
  this.selectBoxFirst = options.selectBox1;
  this.selectBoxSecond = options.selectBox2;
  this.addButton = options.addButton;
  this.removeButton = options.removeButton;
}

countryListManager.prototype.bindEvents = function() {
  var _this = this;
  this.addButton.onclick = function() { 
    _this.moveCountries(_this.selectBoxFirst, _this.selectBoxSecond); 
  };
  this.removeButton.onclick = function() { 
    _this.moveCountries(_this.selectBoxSecond, _this.selectBoxFirst); 
  };
}

 // method to move countries form one select box to another select box
countryListManager.prototype.moveCountries = function(firstSelectBox, secondSelectBox) {
  var selectedItems = firstSelectBox.selectedOptions;
  var numberOfItemsSelected = selectedItems.length;
  for (var index = 0; index < numberOfItemsSelected; index++) {
        secondSelectBox.appendChild(selectedItems[index]);
        secondSelectBox.selectedOptions[index].selected = false;
        index = index - 1;
    }
}

window.onload = function(){
  var options = {
    selectBox1 : document.querySelector("[data-id = 'countrylist1']"),
    selectBox2 : document.querySelector("[data-id = 'countrylist2']"),
    addButton : document.querySelector("[data-id = 'add']"),
    removeButton : document.querySelector("[data-id = 'remove']"),
  };

  var countriesSelection = new countryListManager(options);
  countriesSelection.bindEvents();
}

