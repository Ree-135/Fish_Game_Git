extends Control

#if Input.is_action_just_pressed("Book_open")

var Native = GameController.fish_listNATIVE
var Invasive: Array =[
	preload("res://Fish/Snakehead.tres"),
	preload("res://Fish/Carp.tres"),
	preload("res://Fish/Mosquitofish.tres"),
	preload("res://Fish/PeacockBass.tres"),
	preload("res://Fish/JaguarCichlid.tres"),
	preload("res://Fish/Oscar.tres"),
	preload("res://Fish/RainbowTrout.tres"),
	preload("res://Fish/ClownKnifefish.tres"),
	preload("res://Fish/Snakehead.tres"),
	preload("res://Fish/Carp.tres"),
	preload("res://Fish/Mosquitofish.tres"),
	preload("res://Fish/PeacockBass.tres"),
	]

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

@onready var timer: Timer = $Timer


var i: int = 0
var page: int


func load_list():
	left_sprite = $Left_Page/Left_sprite
	l_name_label = $"Left_Page/L_Name label"
	l_type = $Left_Page/L_Type
	l_weight = $Left_Page/L_weight
	l_caught = $Left_Page/L_caught
	
	
	right_sprite = $Right_Page/Right_sprite
	r_name_label = $"Right_Page/R_Name label"
	r_type = $Right_Page/R_Type
	r_weight = $Right_Page/R_weight
	r_caught = $Right_Page/R_caught
	
	timer = $Timer
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	i = 0
	page = 0
	
	GameController.can_move = false
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	load_list()
	
	
	for i in 12:
		
		i = page
	
		left_sprite.texture = Native[i].FishTexture
		l_name_label.text = str(Native[i].Name)
		l_type.text = "Type: Native"
		l_weight.text = "Weight: " + str(Native[i].Weight) + " Pancakes"


		if Native[i].Caught == true:
			l_caught.text = "Caught: Ye :)"


		if Native[i].Caught == false:
			l_caught.text = "Caught: Nar :("

		if Input.is_action_pressed("Action_left") and i >= 1 and timer.is_stopped():
			page -= 1
			timer.start()

		if Input.is_action_pressed("Action_right") and i <= Native.size() - 2 and timer.is_stopped():
			page += 1
			timer.start()
		
		right_sprite.texture = Invasive[i].FishTexture
		r_name_label.text = str(Invasive[i].Name)
		r_type.text = "Type: Invasive"
		r_weight.text = "Weight: " + str(Invasive[i].Weight) + " Pancakes"
		
		if Invasive[i].Caught == true:
			r_caught.text = "Caught: Ye >:("
			
		if Invasive[i].Caught == false:
			r_caught.text = "Caught: Nar :)"
		
		if Input.is_action_pressed("Action_left") and i >= 1 and timer.is_stopped():
			page -= 1
			timer.start()

		if Input.is_action_pressed("Action_right") and i <= 6 and timer.is_stopped():
			page += 1
			timer.start()
			
		if Input.is_action_pressed("Close_book"):
			queue_free()
			GameController.can_move = true
