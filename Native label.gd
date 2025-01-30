extends Label


# Called when the node enters the scene tree for the first time.
var Jam = GameController.currency


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Jam = GameController.currency
	text = "Jam: " + str(Jam)
