function Form(){
  this.daysCheckboxes = document.querySelectorAll("[data-name = 'daysCheckbox']");
  this.noneCheckbox = document.querySelector("[data-name = 'checkNone']");
  
  this.checkboxClickEvent = function(){
    var current_reference = this;
    for(var i = 0; i < this.daysCheckboxes.length; i++){
      this.daysCheckboxes[i].onclick = function(){ current_reference.checkMaximumThreeCheckBoxes();}
    }
    
    this.noneCheckbox.onclick = function(){ current_reference.checkNone();}
  }

  this.checkMaximumThreeCheckBoxes = function(){
    var totalDaysSelected = 0;
    var nameOfSelectedDays = new Array();

    for(var selectedDay=0; selectedDay < this.daysCheckboxes.length; selectedDay++){
      if(this.daysCheckboxes[selectedDay].checked === true){
        this.noneCheckbox.checked = false;
        nameOfSelectedDays.push(this.daysCheckboxes[selectedDay].value);
        totalDaysSelected++;
      }
      
      if(totalDaysSelected > 3){
        this.daysCheckboxes[selectedDay].checked = false;
        alert("You can Maximum select 3 days at a time. You have already selected " + nameOfSelectedDays[2] + ", " + nameOfSelectedDays[1] + ", " + nameOfSelectedDays[0]);
        return false;
      }
    }
  }

  this.checkNone = function(){
    for(var selectedDay = 0; selectedDay < this.daysCheckboxes.length; selectedDay++){
      this.daysCheckboxes[selectedDay].checked = false;
    }
  }
}

Form.prototype.init = function(){
  this.checkboxClickEvent();
}

window.onload = function(){
  var form = new Form();
  form.init();
}
