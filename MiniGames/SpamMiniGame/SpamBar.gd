extends ProgressBar

@export var Fill_percentage: int = 5 ##how much each press of the space bar fills up the bar
@export var pull_force: int = 1 ##how much the "fish" reels against the user
@export var Hurt_percentage: int = 3 ## how much pressing during the "no reeling time" hurts the player

@onready var PlayTimer: Timer = $Timer
@onready var ReelTimer: Timer = $Timer2
@onready var label: Label = $Label
@onready var progress_bar: ProgressBar = $"."


@onready var release_button: Button = $"Release Button"
@onready var sprite_2d: Sprite2D = $Sprite2D



var playing = 1
var the_fish = GameController.fish_selector()

func _ready() -> void:
	PlayTimer.start()
	ReelTimer.start()
	label.text = "REEL!! \n(spam Mouse L and R)"
	
	sprite_2d.texture = the_fish.FishTexture
	
func _process(delta: float) -> void:
	if playing == -1:
		label.text = "WAIT!!"
	if playing == 1:
		label.text = "REEL!!\n (spam Mouse L and R)"

	if Input.is_action_just_pressed("Action_both") and playing == 1:
		value += Fill_percentage
	if Input.is_action_just_pressed("Action_both") and playing == -1:
		value -= Hurt_percentage
	
	if value >= 100:
		GameController.fish_winner(the_fish)
		GameController.stop_fishing()
		GameController.can_move = true
		GameController.is_fishing = false
		progress_bar.queue_free()

	if value <= 0:
		GameController.stop_fishing()
		GameController.can_move = true
		GameController.is_fishing = false
		progress_bar.queue_free()



func _on_timer_timeout() -> void:
	playing *= -1


func _on_timer_2_timeout() -> void:
	value -= pull_force
	


	


func _on_button_pressed() -> void:
	GameController.stop_fishing()
	GameController.can_move = true
	GameController.is_fishing = false
	
	if the_fish.Type == 0:
		GameController.morality += .1
		
	if the_fish.Type == 1:
		GameController.morality -= .1
		
	progress_bar.queue_free() 
