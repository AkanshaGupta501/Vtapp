function CountryNameSelection(options){
  this.selectBoxFirst = options.selectBox1;
  this.selectBoxSecond = options.selectBox2;
  this.addButton = options.addButton;
  this.removeButton = options.removeButton;
}

CountryNameSelection.prototype.bindEvent = function() {
  var _this = this;
  this.addButton.onclick = function() { 
    _this.moveCountries(_this.selectBoxFirst, _this.selectBoxSecond); 
  };
  this.removeButton.onclick = function() { 
    _this.moveCountries(_this.selectBoxSecond, _this.selectBoxFirst); 
  };
}

 // method to move countries form one select box to another select box
CountryNameSelection.prototype.moveCountries = function(firstSelectBox, secondSelectBox) {
  var selectedItems = firstSelectBox.selectedOptions;
    while(selectedItems[0]) {
      secondSelectBox.appendChild(selectedItems[0]);
      secondSelectBox.selectedOptions[0].selected = false;
    }
}

window.onload = function(){
  var options = {
    selectBox1 : document.querySelector("[data-id = 'countrylist1']"),
    selectBox2 : document.querySelector("[data-id = 'countrylist2']"),
    addButton : document.querySelector("[data-id = 'add']"),
    removeButton : document.querySelector("[data-id = 'remove']"),
  };

  var countriesSelection = new CountryNameSelection(options);
  countriesSelection.bindEvent();
}

