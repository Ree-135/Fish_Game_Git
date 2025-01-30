extends Node2D

@onready var day_night_shader = $CanvasModulate
@onready var time_ui = $Gui/DayNightCycleUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	day_night_shader.time_tick.connect(time_ui.set_daytime)


func _on_texture_button_pressed() -> void:
	var gui_node = get_tree().root.get_node("GamePrototype/Gui")
	gui_node.add_child(GameController.fishepedia.instantiate())# Replace with function body.
