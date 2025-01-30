extends Label

var native = GameController.Native_Counter
var invasive = GameController.Invasive_counter
var Jam = GameController.currency
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	native = GameController.Native_Counter
	invasive = GameController.Invasive_counter
	Jam = GameController.currency
	text = "Native fish held: " + str(native) + "\nInvasive fish held: " + str(invasive) + "\nJam: " + str(Jam)
