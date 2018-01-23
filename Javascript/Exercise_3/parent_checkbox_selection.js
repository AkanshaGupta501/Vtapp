function CheckBoxList(options) {
  this.parentElements = options;
}

CheckBoxList.prototype.bindEvent = function(){
  var _this = this;
  for(var index = 0; index < this.parentElements.length; index++){
    this.parentElements[index].addEventListener("click", function(){
      _this.toggleChildCheckboxes(this);
    });
  }
}

//Show and hide children if parent is selected or not
CheckBoxList.prototype.toggleChildCheckboxes = function(parentLabels){
  var parentCheckbox = parentLabels.firstChild;
  var subCheckboxesDiv = parentLabels.nextSibling.nextSibling;
  var subChildrenArray = subCheckboxesDiv.children;
  if(parentCheckbox.checked) {
    this.showChildCheckboxes(parentCheckbox, subCheckboxesDiv, subChildrenArray);
  } 
  else {
    this.hideChildCheckboxes(parentCheckbox, subCheckboxesDiv, subChildrenArray);
  }
}

CheckBoxList.prototype.showChildCheckboxes = function(parentCheckbox, subCheckboxesDiv, subChildrenArray){
  subCheckboxesDiv.classList.add("showCheckboxes");
    parentCheckbox.scrollIntoView();
    for(position in subChildrenArray) {
      subChildrenArray[position].firstChild.checked = true;
    }
}

CheckBoxList.prototype.hideChildCheckboxes = function(parentCheckbox, subCheckboxesDiv, subChildrenArray){
  subCheckboxesDiv.classList.add("hideCheckboxes");
    for(position in subChildrenArray) {
      subChildrenArray[position].firstChild.checked = false;
    }
}

window.onload = function() {
  var parentElements = document.querySelectorAll("[data-name = 'parent']");
  var checkBox = new CheckBoxList(parentElements);
  checkBox.bindEvent();
}
