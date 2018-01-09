function CountryNames() {
  this.selectbox1 = document.getElementById("countrylist1");
  this.selectbox2 = document.getElementById("countrylist2");
  this.add = document.getElementById("add");
  this.remove = document.getElementById("remove");

  // method for onclick event
  this.addOrRemoveEvent = function() {
    var that = this;
    this.add.onclick = function() { 
      that.moveCountries(that.selectbox1, that.selectbox2); 
    };
    this.remove.onclick = function() { 
      that.moveCountries(that.selectbox2, that.selectbox1); 
    };
  }

  // method to move countries form one list to other
  this.moveCountries = function(choice1, choice2) {
    for (var i = 0; i < choice1.options.length; i++) {
      if (choice1.options[i].selected) {
        choice2.appendChild(choice1.options[i--]);
      }
    }
  }
}

var countryList = new CountryNames();
countryList.addOrRemoveEvent();
