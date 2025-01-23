extends CharacterBody2D
@export var max_speed := 300 #how fast we are moving
@export_range(0,10,0.1) var drag_factor := 0.1 #

var desired_velocity := Vector2.ZERO
var steering_velocity := Vector2.ZERO
var can_move = true

func _physics_process(_delta: float) -> void:
	if can_move:
		var direction = Input.get_vector('move_left',"move_right","move_up","move_down")
		desired_velocity = direction * max_speed # set desired velocity to direction * max speed
		steering_velocity = desired_velocity - velocity #set steering velocity to desired velocity - velocity
		velocity += steering_velocity * drag_factor #increment velocity by steering velocity
		rotation = velocity.angle()
		move_and_slide()
		
	else:
		pass
