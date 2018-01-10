function CheckBoxList(options) {
  this.pageDom = options;
}

CheckBoxList.prototype.bindEvent = function(){
  var _this = this;
  for(var i = 0; i < this.pageDom.length; i++){
    this.pageDom[i].addEventListener("click", function(){
      _this.toggleChildCheckboxes(this);
    });
  }
}

CheckBoxList.prototype.toggleChildCheckboxes = function(parentLabel){
  var parentCheckbox = parentLabel.firstChild;
  var subCheckboxesDiv = parentLabel.nextSibling.nextSibling;
  var subChildrenArray = subCheckboxesDiv.children;
  
  //This condition checks whether parent checkbox is selected or not
  if(parentCheckbox.checked) {
    subCheckboxesDiv.classList.add("showCheckboxes");
    parentCheckbox.scrollIntoView();
    for(position in subChildrenArray) {
      subChildrenArray[position].firstChild.checked = true;
    } 
  } 
  else {
    subCheckboxesDiv.classList.add("hideCheckboxes");
    for(position in subChildrenArray) {
      subChildrenArray[position].firstChild.checked = false;
    }
  }
}

window.onload = function() {
  var nodeDOMS = document.querySelectorAll("[data-name = 'parent']");
  var checkBox = new CheckBoxList(nodeDOMS);
  checkBox.bindEvent();
}
