extends CanvasLayer
# Preload the scenes you want to add
var fishapedia_main_instance = preload("res://Utilities/GUI/Scenes/Fishipedia.tscn")
# there are lots more nodes we can use to add extra polish, like a saftey animation that plays when the mouse hovers over the bookicon
func _on_book_icon_pressed() -> void:
	print("book opened")
	# We want to use the fishipedia when this is pressed
	# Create an instance of the scene
	var new_scene_instance = fishapedia_main_instance.instantiate()
	
	# Find the instance of the gui path to 
	var gui_node = get_tree().root.get_node("GamePrototype/Gui")
	# Add the new scene instance to the CanvasLayer or Control node
	gui_node.add_child(new_scene_instance)
	
	#update controll variables
	GameController.can_move = false
	
	
	# The next step is to add a X button to the book pages to that the book can be closed.
	
	# The book will also have many pages wich are really just menu screens that aren't made yet but for now, lets focus on being able to close the book
