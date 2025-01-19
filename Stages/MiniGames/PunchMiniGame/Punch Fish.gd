extends PathFollow2D

@onready var timer: Timer = $Timer

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
	print(speed)
	print(side)
	if side == false:
		progress = 308

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if side == true:
		progress_ratio += speed * delta
	if side == false:
		progress_ratio -= speed * delta


	if Input.is_action_pressed("ui_accept") and in_fish:
		score += 1
		print(score)
		in_fish = false
		New_side()


	if Input.is_action_pressed("ui_accept") and (in_fish == false):
		New_side()


func New_side():
	in_fish = false
	
	ran_side.randomize()
	side = ran_side.randi_range(0,1)
	
	ran_speed.randomize()
	speed = float(ran_speed.randi_range(2, 10)) / 10
	
	if side:
		progress = 0
	if side == false:
		progress = 308
	
	timer.start()


func _on_timer_timeout() -> void:
	New_side()
	score -= 1


func _on_area_2d_2_area_entered(area: Area2D) -> void:
	in_fish = true
	print("In area")

func _on_area_2d_2_area_exited(area: Area2D) -> void:
	in_fish = false
