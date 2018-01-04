//This event is called when bosy is loaded and asks user to enter the values
window.onload = function(){
  var user_details;
  do{
    firstname = prompt("Please enter the first name");
    lastname = prompt("Please enter the last name");
    user_details = new User(firstname, lastname);
  }while(!user_details.validateName());
  user_details.displayUserName();
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
    if(!isNaN(this.firstName)){
    isValid = false;
    alert("You must specify the first name to continue");
  }
  else if(!isNaN(this.lastName)){
    isValid = false;
    alert("You must specify the last name to continue");
  }
  //Firstname and lastname must not consist of letters
  else if(!name_regex.test(this.firstName) || !name_regex.test(this.lastName)){
    isValid = false;
    alert("You must enter a valid name consisting of letters only");
  }
  return isValid;
}

//If name is valid display it as alert and inside the div
User.prototype.displayUserName = function(){
    //trim the additional white spaces
    var displayMessage = "Hello " + this.firstName.trim() + " " + this.lastName.trim();
    alert(displayMessage)
    document.getElementById("message").innerHTML = displayMessage;
}