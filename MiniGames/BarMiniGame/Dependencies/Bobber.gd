extends CharacterBody2D



@export var JUMP_VELOCITY: float = -400.0 ## How HARD you jump, MUST be negative
@export var Grav_Multiplier:float = 1 ## It affects gravity, duh
@export var Down_toggle:bool = 1 ## togle the ability to use the down arrow key to "spike" the Bobber

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += Grav_Multiplier * get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("Action_left"):
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("Action_right") and Down_toggle:
		velocity.y = -1 * JUMP_VELOCITY

	move_and_slide()
