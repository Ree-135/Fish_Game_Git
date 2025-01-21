extends ProgressBar

@export var Fill_percentage: int = 5 ##how much each press of the space bar fills up the bar
@export var pull_force: int = 1 ##how much the "fish" reels against the user
@export var Hurt_percentage: int = 7 ## how much pressing during the "no reeling time" hurts the player

@onready var PlayTimer: Timer = $Timer
@onready var ReelTimer: Timer = $Timer2
@onready var label: Label = $Label

var playing = 1


func _ready() -> void:
	PlayTimer.start()
	ReelTimer.start()
	label.text = "REEL!!"
	
func _process(delta: float) -> void:
	if playing == -1:
		label.text = "WAIT!!"
	if playing == 1:
		label.text = "REEL!!"

	if Input.is_action_just_pressed("ui_accept") and playing == 1:
		value += Fill_percentage
	if Input.is_action_just_pressed("ui_accept") and playing == -1:
		value -= Hurt_percentage
	
	if value == 100:
		print("you win!!!")
	if value == 0:
		print("you lose")


func _on_timer_timeout() -> void:
	playing *= -1


func _on_timer_2_timeout() -> void:
	value -= pull_force
