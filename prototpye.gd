extends Node2D

@onready var day_night_shader = $CanvasModulate
@onready var time_ui = $Gui/DayNightCycleUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	day_night_shader.time_tick.connect(time_ui.set_daytime)
