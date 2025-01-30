extends PathFollow2D

@onready var timer: Timer = $Timer
@onready var progress_bar: ProgressBar = $"../ProgressBar"
@onready var path_lr: Path2D = $".."
@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"


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
	#print(speed)
	#print(side)
	if side == false:
		progress = 308
	
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


	if Input.is_action_just_pressed("Action_both") and (in_fish == false):
		New_side()
		progress_bar.value -= 10
		animated_sprite_2d.play()
		
	if progress_bar.value >= 100:
		GameController.fish_winner(the_fish)
		GameController.stop_fishing()
		GameController.can_move = true
		GameController.is_fishing = false
		path_lr.queue_free()
		
	if progress_bar.value <= 0:
		GameController.stop_fishing()
		GameController.can_move = true
		GameController.is_fishing = false
		path_lr.queue_free()


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
	GameController.stop_fishing()
	GameController.can_move = true
	GameController.is_fishing = false
	
	if the_fish.Type == 0:
		GameController.morality += .1
		
	if the_fish.Type == 1:
		GameController.morality -= .1
	path_lr.queue_free()
