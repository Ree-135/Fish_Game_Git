extends Node2D

func _process(delta):
	# Get the global mouse position
	look_at(get_global_mouse_position())
