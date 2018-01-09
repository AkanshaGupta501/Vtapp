function Form(options){
  this.daysCheckboxes = options.daysCheckBoxes;
  this.noneCheckbox = options.noneCheckBox;
  this.selectedDays = new Array();
}

Form.prototype.bindEventCheckboxClick = function(){
  debugger;
  for(var day = 0; day < this.daysCheckboxes.length; day++){
    this.daysCheckboxes[day].onclick = function() { this.eventHandler(this.daysCheckboxes[day]); }
  }

  function eventHandler(checkBoxId){
    this.validateCheckboxSelection(checkBoxId);
  }
} 

Form.prototype.validateCheckboxSelection = function(checkBoxID){
  //debugger;
  if(this.checked){
    this.noneCheckbox.selected = false;
    this.selectedDays.push(checkBoxID.value);
  }
}










// Form.prototype.checkboxClickEvent = function(){
//     var current_reference = this;
//     for(var day = 0; day < this.daysCheckboxes.length; day++){
//       this.daysCheckboxes[day].onclick = function(){ 
//         this.daysCheckboxes[day].checked ? this.selectedDays.pop() : this.selectedDays.push(this.daysCheckboxes[day].value);
//         current_reference.checkMaximumThreeCheckBoxes();
//       }
//     }
    
//     this.noneCheckbox.onclick = function(){ current_reference.checkNone();}
//   }

// Form.prototype.checkMaximumThreeCheckBoxes = function(){
//       if(this.selectedDays.length > 3){
//         // this.daysCheckboxes[selectedDay].checked = false;
//         alert("You can Maximum select 3 days at a time. You have already selected " + this.selectedDays[2] + ", " + this.selectedDays[1] + ", " + this.selectedDays[0]);
//         return false;
//       }
//     }

// Form.prototype.checkNone = function(){
//     for(var selectedDay = 0; selectedDay < this.daysCheckboxes.length; selectedDay++){
//       this.daysCheckboxes[selectedDay].checked = false;
//     }
//   }

window.onload = function(){
  var options = {
    daysCheckBoxes : document.querySelectorAll("[data-name = 'daysCheckbox']"),
    noneCheckBox : document.querySelector("[data-name = 'checkNone']")
  };
  console.log(options);
  var newForm = new Form(options)
  newForm.bindEventCheckboxClick();
}
