//Initialise the checkbox list class and call the expand function
function CheckBoxList(parentLabel) {
  this.parentbox = parentLabel;
  this.expandChildCheckboxes(this);
}

CheckBoxList.prototype.expandChildCheckboxes = function(parentLabel){
  debugger;
  var parentCheckbox = parentLabel.parentbox.firstChild;
  var subCheckboxesDiv = parentLabel.parentbox.nextSibling.nextSibling;
  var subChildrenArray = subCheckboxesDiv.children;
  
  //this condition checks whether parent checkbox is selected or not
  if(parentCheckbox.checked) {
    //if parent is selected then all its children are set to true
    subCheckboxesDiv.style.display="block";
    parentCheckbox.scrollIntoView();
    for(position in subChildrenArray) {
      subChildrenArray[position].firstChild.checked=true;
    } 
  } 
  else {
    //this COL hides the children checkboxes and turns their checked value to false
    subCheckboxesDiv.style.display="none";
    for(position in subChildrenArray) {
      subChildrenArray[position].firstChild.checked=false;
    }
  }
}

var colors = document.querySelector("[data-name = 'colors']");
colors.addEventListener('click', function(){
  new CheckBoxList(this);
});

var movies = document.querySelector("[data-name = 'movies']");
movies.addEventListener('click', function(){
  new CheckBoxList(this);
});

var drinks = document.querySelector("[data-name = 'drinks']");
drinks.addEventListener('click', function(){
  new CheckBoxList(this);
});

var bikes = document.querySelector("[data-name = 'bikes']");
bikes.addEventListener('click', function(){
  new CheckBoxList(this);
});