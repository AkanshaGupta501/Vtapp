//this is a user class that has name and age as its attributes
function User(name, age) {
  this.name = name;
  this.age = age;
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
  debugger;
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
    alert(older + "is older than" + younger);
  }
}



var button = document.getElementById("compare_age");
var names = document.getElementsByName("user_name");
var ages = document.getElementsByName("age");
button.addEventListener('click', function () {
  var user1 = new User(names[0].value, parseInt(ages[0].value));
  var user2 = new User(names[1].value, parseInt(ages[1].value));
  user1.compare_age(user2);
});