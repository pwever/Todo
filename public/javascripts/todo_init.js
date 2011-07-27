

$(document).ready(function(evt){
	// enable checkboxes
	var todos = $("#todos");
	todos.find('input[type=checkbox]').each(function(index,ele){
		var checkbox = $(ele);
		checkbox.change(function(evt){
			// should mark the item on the server via ajax
			$.ajax({
				url: "/markdone"
				, data: { "todos[]": checkbox.attr('value') }
				, error: function() { alert('error'); }
				, success: function() {
					checkbox.parent().fadeOut('slow');
				}
			});
		});
	});
	// remove submit button
	todos.find('input[type=submit]').hide();
	
	// manage new todo field
	var new_todo_form = $('#new_todo');
	new_todo_form.submit(function(){
		$.ajax({
			url: "/create"
			, data: new_todo_form.serialize()
			, error: function() { alert("error") }
			, success: function() { alert("addition accepted.") }
		});
		return false;
	});
	new_todo_form.find('label').hide();
	new_todo_form.find('input[type=submit]').hide();
});