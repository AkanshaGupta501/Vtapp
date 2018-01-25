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
  var childCheckboxes = document.getElementsByName(parent.value);
  if(parent.checked){
    this.showHideChildren("block", true, listElement, childCheckboxes);
    listElement.scrollIntoView(false);
  }
  else{
    this.showHideChildren("none", false, listElement, childCheckboxes);
  }
}

CheckBoxManager.prototype.showHideChildren = function(displayCss, isChecked, listElement, childCheckboxes){
  for(var index = 0; index < childCheckboxes.length; index++){
    childCheckboxes[index].checked = isChecked;
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
