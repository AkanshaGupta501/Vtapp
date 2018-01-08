//This event is called when body is loaded and asks user to enter the values
window.onload = function(){
  var user_details = new User();
  user_details.getUserName();
}

//User Class initialization with firstname and lastname as its attribute
function User(){
  this.firstName, this.lastName;
}

User.prototype.validNameRegex = new RegExp(/^[a-zA-Z\s]+$/);

User.prototype.messageBox = document.getElementById("message");

User.prototype.getUserName = function(){
  do {
    this.firstName = prompt("Please enter the first name");
    this.lastName = prompt("Please enter the last name");
    } while(!this.validateUserName());
    this.displayUserName();
}

User.prototype.validateUserName = function(){
  var isValid = true;
  if(!(this.validateNameIsNotEmpty(this.firstName, 'firstname') && this.validateNameIsNotEmpty(this.lastName, 'lastname'))){
    isValid = false;
  }
  else if(!(this.validateNameHasLetters(this.firstName, 'firstname') && this.validateNameHasLetters(this.lastName, 'lastname'))){
    isValid = false;
  }
  return isValid;
}

User.prototype.validateNameIsNotEmpty = function(name, nameType){
  var isValid = isNaN(name) ? true : false;
  if(!isValid){
    alert("You must specify " + nameType);
  }
  return isValid;
}

User.prototype.validateNameHasLetters = function(name, nameType){
  var isValidName = this.validNameRegex.test(name) ? true : false;
  if(!isValidName){
    alert("Your " + nameType + " must consist of letters only");
  }
  return isValidName;
}

//If name is valid display it as alert and inside the div
User.prototype.displayUserName = function(){
  var messageText = "Hello " + this.firstName.trim() + " " + this.lastName.trim();
  alert(messageText)
  this.messageBox.innerHTML = messageText;
}