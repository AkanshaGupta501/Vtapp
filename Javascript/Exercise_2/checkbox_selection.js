//This function will be called when either of the day's checkbox will be clicked. 
//As and when called the "Select None" checkbox will be unchecked

function validateSelection(day) {
  var days = document.getElementsByName("day");
  var none = document.getElementById("none");
  none.checked = false;
  var countOfMarkedDays = 0, MaxLimit = 3;

  //Array to store the name of days that are already selected
  var nameOfSelectedDays = new Array();
  for (var i = 0; i < days.length; i++) {
    //Count the number of days selected 
    if (days[i].checked == true && i != day) {
      console.log(days[i]);
      countOfMarkedDays++;
      nameOfSelectedDays.push(days[i]);
    }
    //If count goes above limit, uncheck selected day and alert already selected days
    if (countOfMarkedDays >= MaxLimit) {
      days[day].checked = false;
      alert("Only 3 days can be selected. You have already selected " + nameOfSelectedDays[2].value + ", " + nameOfSelectedDays[1].value + " and " + nameOfSelectedDays[0].value);
      return false;
    }
  }
  return true;
}

//This function will be called when user selects "Select None" checkbox

function selectNone() {
  var days = document.getElementsByName("day");
  for (var j = 0; j < days.length; j++) {
    days[j].checked = false;
  }
}