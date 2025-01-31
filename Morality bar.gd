extends ProgressBar


@onready var world_environment: WorldEnvironment = $"../../WorldEnvironment"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = GameController.morality
	world_environment.environment.adjustment_saturation = value + 1
