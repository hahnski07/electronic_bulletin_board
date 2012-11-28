$(function(){
	$("#advertisement_x_location, #advertisement_y_location, #advertisement_width, #advertisement_height").keyup(UpdateAdvertisement);
});

function UpdateAdvertisement()
{
	var x = parseInt($("#advertisement_x_location").val());
	var y = parseInt($("#advertisement_y_location").val());
	var width = parseInt($("#advertisement_width").val());
	var height = parseInt($("#advertisement_height").val());	
		
	if (x >= 0 && y >= 0 && width > 0 && height > 0)
	{
		$("#advertisement_preview").css({top: (y * 64) + "px", left: (x * 64) + "px"}).width(width * 64).height(height * 64);
	}
}