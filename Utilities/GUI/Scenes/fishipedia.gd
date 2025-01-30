extends Control

#if Input.is_action_just_pressed("Book_open")

var Native = GameController.fish_listNATIVE
var Invasive = GameController.fish_listINVASIVE

@onready var left_sprite: Sprite2D = $Left_Page/Left_sprite
@onready var l_name_label: Label = $"Left_Page/L_Name label"
@onready var l_type: Label = $Left_Page/L_Type
@onready var l_weight: Label = $Left_Page/L_weight
@onready var l_caught: Label = $Left_Page/L_caught


@onready var right_sprite: Sprite2D = $Right_Page/Right_sprite
@onready var r_name_label: Label = $"Right_Page/R_Name label"
@onready var r_type: Label = $Right_Page/R_Type
@onready var r_weight: Label = $Right_Page/R_weight
@onready var r_caught: Label = $Right_Page/R_caught


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in Native.size():
		pass
