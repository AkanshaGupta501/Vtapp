//This event is called when bosy is loaded and asks user to enter the values
window.onload = function(){
  firstname = prompt("Please enter the first name");
  lastname = prompt("Please enter the last name");
  var user_details = new User(firstname, lastname);
  user_details.validateName();
}

//User Class initialization with firstname and lastname as its attribute
function User(firstname, lastname){
  this.firstName  = firstname;
  this.lastName = lastname;
}

//validates name
User.prototype.validateName = function(){
  var isValid = true;
  var name_regex = new RegExp(/^[a-zA-Z\s]+$/);
  //Firstname and lastname must not be empty
  if (this.firstName.length == 0 || this.firstName === ' '){
    isValid = false;
    alert("You must specify the first name to continue");
  }
  else if(this.lastName.length == 0 || this.lastName === ' '){
    isValid = false;
    alert("you must specify the last name to continue");
  }
  //Firstname and lastname must not consist of letters
  else if(!name_regex.test(this.firstName) || !name_regex.test(this.lastName)){
    isValid = false;
    alert("You must enter a valid name consisting of letters only");
  }

  //If name is valid display it, else display the error
  if(isValid){
    //trim the additional white spaces
    var displayMessage = "Hello " + this.firstName.trim() + " " + this.lastName.trim();
    alert(displayMessage)
    document.getElementById("message").innerHTML = displayMessage;
  }
  else{
    document.getElementById("message").innerHTML = "Please refresh to start again";
  }
}