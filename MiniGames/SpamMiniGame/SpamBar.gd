extends ProgressBar

@export var Fill_percentage: int = 5 ##how much each press of the space bar fills up the bar
@export var pull_force: int = 1 ##how much the "fish" reels against the user
@export var Hurt_percentage: int = 7 ## how much pressing during the "no reeling time" hurts the player

@onready var PlayTimer: Timer = $Timer
@onready var ReelTimer: Timer = $Timer2
@onready var label: Label = $Label
@onready var progress_bar: ProgressBar = $"."


@onready var release_button: Button = $"Release Button"
@onready var fish_Label: Label = $"Fish Label"
@onready var sprite_2d: Sprite2D = $Sprite2D



var playing = 1
var the_fish = GameController.fish_selector()

func _ready() -> void:
	PlayTimer.start()
	ReelTimer.start()
	label.text = "REEL!!"
	
	sprite_2d.texture = the_fish.FishTexture
	
	if the_fish.Type == 0:
		fish_Label.text = "Fish type: Native"
	if the_fish.Type == 1:
		fish_Label.text = "Fish type: Invasive"
	
func _process(delta: float) -> void:
	if playing == -1:
		label.text = "WAIT!!"
	if playing == 1:
		label.text = "REEL!!"

	if Input.is_action_just_pressed("Action_Button") and playing == 1:
		value += Fill_percentage
	if Input.is_action_just_pressed("Action_Button") and playing == -1:
		value -= Hurt_percentage
	
	if value >= 100:
		GameController.fish_winner(the_fish)
		GameController.current_state = GameController.State.OVERWORLD
		GameController.enter_state( GameController.State.OVERWORLD)
		progress_bar.queue_free()

	if value <= 0:
		GameController.current_state = GameController.State.OVERWORLD
		GameController.enter_state( GameController.State.OVERWORLD)
		progress_bar.queue_free()



func _on_timer_timeout() -> void:
	playing *= -1


func _on_timer_2_timeout() -> void:
	value -= pull_force
	


	


func _on_button_pressed() -> void:
	GameController.stop_fishing()
	GameController.current_state = GameController.State.OVERWORLD
	GameController.enter_state( GameController.State.OVERWORLD)
	progress_bar.queue_free() 
