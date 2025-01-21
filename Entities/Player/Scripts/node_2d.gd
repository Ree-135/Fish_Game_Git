extends Node2D

func _process(_delta):
	# Get the global mouse position
	look_at(get_global_mouse_position())
