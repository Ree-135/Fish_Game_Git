extends PathFollow2D

@onready var timer: Timer = $Timer
@onready var progress_bar: ProgressBar = $"../ProgressBar"
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var control: Control = $"../.."


@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var audio_stream_player: AudioStreamPlayer = $"../../AudioStreamPlayer"

@onready var label: Label = $"../../Label"


var the_fish = GameController.fish_selector()

# random fish speed
var ran_speed = RandomNumberGenerator.new()
var speed: float = float(ran_speed.randi_range(2, 10)) / 10

#chooses random side
var ran_side = RandomNumberGenerator.new()
var side:bool = ran_side.randi_range(0,1)

var in_fish:bool = false
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if side == false:
		progress = 308
	
	in_fish = true
	randomize()
	the_fish = GameController.fish_selector()
	
	sprite_2d.texture = the_fish.FishTexture
	
	progress_bar.value = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if side == true:
		progress_ratio += speed * delta
	if side == false:
		progress_ratio -= speed * delta


	if Input.is_action_just_pressed("Action_both") and in_fish == true:
		progress_bar.value += 30
		animated_sprite_2d.play()
		in_fish = false
		New_side()
		audio_stream_player.play()


	if Input.is_action_just_pressed("Action_both") and (in_fish == false):
		New_side()
		progress_bar.value -= 10
		animated_sprite_2d.play()
		audio_stream_player.play()
		
	if the_fish.Type == 0:
		label.text = "Type: Native"
	if the_fish.Type == 1:
		label.text = "Type: Invasive"
		
	if progress_bar.value >= 100:
		GameController.fish_winner(the_fish)
		GameController.stop_fishing()
		GameController.can_move = true
		GameController.is_fishing = false
		control.queue_free()
		
	if progress_bar.value <= 0:
		GameController.stop_fishing()
		GameController.can_move = true
		GameController.is_fishing = false
		control.queue_free()
		


func New_side():
	in_fish = false
	
	ran_side.randomize()
	side = ran_side.randi_range(0,1)
	
	ran_speed.randomize()
	speed = float(ran_speed.randi_range(2, 10)) / 10
	
	if side:
		progress = 0
	if side == false:
		progress = 634
	
	timer.start()
	


func _on_timer_timeout() -> void:
	New_side()


func _on_area_2d_2_area_entered(area: Area2D) -> void:
	in_fish = true

func _on_area_2d_2_area_exited(area: Area2D) -> void:
	in_fish = false
	



func _on_button_pressed() -> void:
	if the_fish.Type == 0:
		GameController.morality += .05
		
	if the_fish.Type == 1:
		GameController.morality -= .05
		
	GameController.can_move = true
	GameController.is_fishing = false
	GameController.stop_fishing()
	control.queue_free()
