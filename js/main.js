$(document).ready(function() {
	GCI.inlineDialog('webelieve-btn');
	GCI.inlineDialog('spol-play');
});


var GCI = {
	
	inlineDialog : function(contentId) {
		var contentEl = $("#" + contentId);
		if (contentEl) {
			contentEl.on('click', function() {
				var el = $(this);
				var source = $("#" + el.attr('data-source'));

				if (source) {
					var title = source.attr('title');
					var content = source.html();
					var dialog = bootbox.dialog({
					    title: title,
					    message: content,
					    className: "dialog-large"
					});	
				}			
			})
		}
	}
}