window.onload = function(){
  var newUrl, url;
  do{
  var url = prompt("Please enter a valid URL address");
  newUrl = new Url(url);
  }while(!newUrl.validateUrl());
  newUrl.navigateToUrl(url);
}


function Url(url_address){
  this.url = url_address;
}

Url.prototype.validateUrl = function(){
  debugger;
  var isValid = true;
  var url_regex = new RegExp(/(http(s)?:\/\/){1}([\da-z(\.|\-|\@|\:|\#|\_)?]+\.[a-z\.]{2,6}|[\d\.]+)([\/:?=&#%]{1}[[\da-z(\.|\-|\@|\:|\#|\_)?]+)*[\/\?]?/igm);
  if(!isNaN(this.url)){
    isValid = false;
    alert("Please enter a URL to continue");
  }
  else if(!url_regex.test(this.url)){
    isValid = false;
    alert("Please enter a valid URL address to continue");
  }
  return isValid;
}

Url.prototype.navigateToUrl = function(urlAddress){
  window.open(urlAddress, "_blank", "width=400, height=450, menubar=0, scrollbars=0, status=0");
}