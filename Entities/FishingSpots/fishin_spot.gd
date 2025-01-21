extends Sprite2D

# Preload the scene you want to add
#var MyScene = preload("res://Utilities/GUI/Scenes/Fishipedia.tscn")

# there are lots more nodes we can use to add extra polish, like a saftey animation that plays when the mouse hovers over the bookicon
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			print("Clicked")
	


#func _on_fishing_spot_pressed() -> void:
		# Print("use this item")
	# We want to use the fishipedia when this is pressed
	# Create an instance of the scene
	#var new_scene_instance = MyScene.instantiate()
	
	# Find the instance of the gui path to 
	#var gui_node = get_tree().root.get_node("Node2D/Gui")
	# Add the new scene instance to the CanvasLayer or Control node
	#gui_node.add_child(new_scene_instance)
