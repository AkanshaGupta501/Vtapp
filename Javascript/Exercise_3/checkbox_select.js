function CheckBoxManager(options){
  this.parentElements = options.parentElements;
}

CheckBoxManager.prototype.bindEvent = function() {
  var _this = this;
  for(var index = 0; index < this.parentElements.length; index++){
    this.parentElements[index].addEventListener("click", function(){
      _this.toggleChildCheckboxes(this);
    });
  }
}

CheckBoxManager.prototype.toggleChildCheckboxes = function(parent) {
  var listElement = document.getElementById(parent.value);
  var childrenCheckboxes = document.getElementsByName(parent.value);
  if(parent.checked){
    this.showHideChildren("block", true, listElement, childrenCheckboxes);
    listElement.scrollIntoView(false);
  }
  else{
    this.showHideChildren("none", false, listElement, childrenCheckboxes);
  }
}

CheckBoxManager.prototype.showHideChildren = function(displayCss, checkValue, listElement, childrenCheckboxes){
  for(var index = 0; index < childrenCheckboxes.length; index++){
    childrenCheckboxes[index].checked = checkValue;
  }
  listElement.setAttribute("style", "display :" + displayCss);
}

window.onload = function() {
  var options = {
    parentElements : document.querySelectorAll("[data-name = 'parent']")
  }
  var checkBox = new CheckBoxManager(options);
  checkBox.bindEvent();
}
