extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameController.in_menu = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("Close_book"):
		GameController.in_menu = false
		GameController.can_move = true
		queue_free()
