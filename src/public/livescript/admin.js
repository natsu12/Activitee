$(function(){
	var accept_buttons = $("td button");
	var length = accept_buttons.length;
	for (var i = 0; i < length; i++)
	{
		(function(i) {
			accept_buttons[i].onclick = function()
			{
				$.post("/admin",
				{
					index : i
				},
				function(data,status){
					alert("Data: " + data + "\nStatus: " + status);
				});
			}
		})(i);
	}
});
