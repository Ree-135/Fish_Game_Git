extends CanvasLayer

# Preload the scene you want to add
var MyScene = preload("res://Utilities/GUI/Scenes/Fishipedia.tscn")

# there are lots more nodes we can use to add extra polish, like a saftey animation that plays when the mouse hovers over the bookicon
func _on_book_icon_pressed() -> void:
	# Print("use this item")
	# We want to use the fishipedia when this is pressed
	# Create an instance of the scene
	var new_scene_instance = MyScene.instantiate()
	
	# Find the instance of the gui path to 
	var gui_node = get_tree().root.get_node("Node2D/Gui")
	# Add the new scene instance to the CanvasLayer or Control node
	gui_node.add_child(new_scene_instance)
		
	# Optionally, you can set the position or any properties of the new scene
	#new_scene_instance.rect_position = Vector2(100, 100)  # Example position
	
