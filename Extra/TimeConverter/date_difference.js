<html>
<head>
<body>
<script type = "text/javascript">
var date1 = prompt("Enter first date in mm/dd/yyyy format in quotes");
var date2 =  prompt("Enter second date");

date1 = new Date(date1);
date2 = new Date(date2);
var timeDiff = Math.abs(date2.getTime() - date1.getTime());
var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));

alert(diffDays);
</script>
</body>
</html>