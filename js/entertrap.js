<!--
function whichButton() 
{
	if (event.keyCode == 13) 
	{
		event.keyCode=0;
		var currId = event.srcElement.id
		if ( currId < f1.length)
		{
			var nextId = currId*1 + 1
			var followingInput = document.getElementById(nextId);
			if (followingInput.name != null)
			{
				followingInput.focus();
			}	
		}
		return event.keyCode=0;
		//return !(window.event && window.event.keyCode == 13); 
	}


}
-->