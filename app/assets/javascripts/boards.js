$(function(){
	if ($("#board_width").val() == "")
		$("#board_width").val("1");
	if ($("#board_height").val() == "")
		$("#board_height").val("1");

	UpdateBoard();

	$("#board_width, #board_height").keyup(UpdateBoard);
});

function UpdateBoard()
{
	var width = parseInt($("#board_width").val());
	var height = parseInt($("#board_height").val());
		
	if (width && height)
	{
		$("#board_preview").width(width * 64).height(height * 64)
		$("#board_cost").text("Estimated Cost: $" + (width * height) + ".00");
	}
}