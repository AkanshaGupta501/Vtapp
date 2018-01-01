//this is a user class that has name and age as its attributes
function User(name, age) {
  this.name = name;
  this.age = parseInt(age);
}

//this function validate the ages
User.prototype.isValidAge = function(user2){
  return Number(this.age > 0) && Number(user2.age > 0) ? true : false
}

//this function validates if name is not an empty field
User.prototype.isValidName = function(user2){
  return this.name.length != 0 && user2.name.length != 0 ? true : false
}

//this function compare ages
User.prototype.compare_age = function(user2) {
  var older = 0;
  var younger = 0;
  if(!this.isValidAge(user2)){
    alert("Please enter valid ages for the users");
  }
  else if(!this.isValidName(user2)){
    alert("Please enter valid user name");
  }
  else if(this.age == user2.age){
    alert(this.name + " and " + user2.name + " are of the same age");
  }
  else{
    older = this.age > user2.age ? this.name : user2.name;
    younger = this.age > user2.age ? user2.name : this.name;
    alert(older + " is older than " + younger);
  }
}


//this code initiates as and when user clicks on compare button
var button = document.querySelector("[data-action = 'compare_age']");
button.addEventListener('click', function () {

//this query selector fetches data attributes and DOM values
  var user1_name = document.querySelector("[data-name = 'user1_name']").value;
  var user1_age = document.querySelector("[data-name = 'user1_age']").value;
  var user2_name = document.querySelector("[data-name = 'user2_name']").value;
  var user2_age = document.querySelector("[data-name = 'user2_age']").value;

//Initialization of two user objects and a function to compare the ages
  user1 = new User(user1_name, user1_age);
  user2 = new User(user2_name, user2_age);
  user1.compare_age(user2);
});