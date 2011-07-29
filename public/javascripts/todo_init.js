

$(document).ready(function(evt){
	// return;
	
	// manage new todo field
	var new_todo_form = $('#new_todo');
	new_todo_form.submit(function(){
		$.ajax({
			url: "/todos"
			, type: 'post'
			, data: new_todo_form.serialize()
			, dataType: "html"
			, error: function(jqXHR, textStatus, errorThrown) { alert(textStatus + "\n" + errorThrown) }
			, success: function(data, textStatus, jqXHR) {
				// clear the form
				new_todo_form.find("input[type=text]").val("").focus();
				// add new todo to the list
				todos.prepend(data);
			}
		});
		return false;
	});
	new_todo_form.find('input[type=submit]').hide();
	new_todo_form.find('input[type=text]').css("width", "96%");
	
	
	
	// enable checkboxes
	var todos = $("#todos");
	todos.find('input[type=checkbox]').each(function(index,ele){
		var checkbox = $(ele);
		checkbox.change(function(evt){
			// should mark the item on the server via ajax
			$.ajax({
				url: "todos/markdone"
				, type: 'post'
				, data: { "todos[]": checkbox.attr('value') }
				, error: function(jqXHR, textStatus, errorThrown) { alert('error'); } 
				, success: function(data, textStatus, jqXHR) {
					checkbox.parent().addClass("done");
				}
			});
		});
	});
	// remove submit button
	todos.find("input[type=submit]").hide();
	
	
	// enable inline editing
	todos.find('li span.input').click(function(evt){
		var content_span = $(this);
		var id = content_span.parent().find("input").val();
		var form = $(document.createElement("form"));
		var input = $(document.createElement("input")).attr("type","text").attr("name","todo[label]").attr("value", $(this).html());
		form.append(input);
		form.append($("input[name=authenticity_token]").first().clone());
		form.submit(function(evt){
			$.ajax({
				url: "todos/" + id
				, type: "put"
				, data: form.serialize()
				, dataType: "html"
				, error: function(jqXHR, textStatus, errorThrown) { alert(textStatus + "\n" + errorThrown) }
				, success: function(data, textStatus, jqXHR) {
					// clear the form
					content_span.parent().replaceWith(data);
				}
			});
			return false;
		});
		input.blur(function() {
			// cancel the input
			form.remove();
			content_span.show();
		});
		content_span.before(form);
		content_span.hide();
		
		input.focus();
		input.select();
	}).hover(function(){
		$(this).css("background-color","rgb(255,255,220)");
	},function(){
		$(this).css("background-color","transparent");
	});
	
	todos.find('.delete_link').click(function(){
		var link = $(this);
		$.ajax({
			url: link.attr("href")
			, type: "delete"
			, dataType: "html"
			, error: function(jqXHR, textStatus, errorThrown) { alert(textStatus + "\n" + errorThrown) }
			, success: function(data, textStatus, jqXHR) {
				link.parents("li").fadeOut();
			}
		});
		return false;
	});
	// Remove edit and delete actions
	todos.find('.edit_link').hide();
	
});

