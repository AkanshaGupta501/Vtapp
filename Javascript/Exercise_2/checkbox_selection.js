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
    this.selectedDays.push(checkBoxID.value);
  }
  else if(!checkBoxID.checked){
    this.selectedDays.pop();
  }
  this.checkMaximumThreeCheckBoxes(checkBoxID);
}

Form.prototype.checkNone = function(){
  for(var selectedDay = 0; selectedDay < this.daysCheckboxes.length; selectedDay++){
    this.daysCheckboxes[selectedDay].checked = false;
    this.selectedDays.pop();
  }
}

Form.prototype.checkMaximumThreeCheckBoxes = function(checkBoxID){
  if(this.selectedDays.length > 3){
    checkBoxID.checked = false;
    alert("You can Maximum select 3 days at a time. You have already selected " + this.selectedDays[2] + ", " + this.selectedDays[1] + ", " + this.selectedDays[0]);
  }
}

window.onload = function(){
  var options = {
    daysCheckBoxes : document.querySelectorAll("[data-name = 'daysCheckbox']"),
    noneCheckBox : document.querySelector("[data-name = 'checkNone']")
  };
  var newForm = new Form(options)
  newForm.bindEvent();
}
