function Form(options){
  this.daysCheckboxes = options.daysCheckBoxes;
  this.noneCheckbox = options.noneCheckBox;
  this.selectedDays = new Array();
}

Form.prototype.bindEvent = function(){
  var _this = this;
  this.noneCheckbox.addEventListener("click", function() {
    _this.checkNone();
  });

  for(var day = 0; day < this.daysCheckboxes.length; day++){
    this.daysCheckboxes[day].addEventListener("click", function() {
    _this.validateCheckboxSelection(this);
    });
  }
} 

Form.prototype.validateCheckboxSelection = function(checkBoxID){
  if(checkBoxID.checked){
    this.noneCheckbox.checked = false;
    this.pushIfCheckboxLengthValidated(checkBoxID);
  }
  else{
    this.selectedDays.pop();
  }
}

Form.prototype.checkNone = function(){
  for(var day = 0; day < this.daysCheckboxes.length; day++){
    this.daysCheckboxes[day].checked = false;
  }
  this.selectedDays = [];
}

Form.prototype.pushIfCheckboxLengthValidated = function(checkBoxID){
  if(this.selectedDays.length >= 3){
    checkBoxID.checked = false;
    alert("You can Maximum select 3 days at a time. You have already selected " + this.selectedDays[2] + ", " + this.selectedDays[1] + ", " + this.selectedDays[0]);
  }
  else{
    this.selectedDays.push(checkBoxID.value);
  }
}

window.onload = function(){
  var options = {
    daysCheckBoxes : document.querySelectorAll("[data-name = 'daysCheckbox']"),
    noneCheckBox : document.querySelector("[data-name = 'checkNone']")
  },
    newForm = new Form(options);
  newForm.bindEvent();
}
