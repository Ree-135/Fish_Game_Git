extends CharacterBody2D
@export var max_speed := 300 #how fast we are moving
@export_range(0,10,0.001) var drag_factor := 0.1 #
@onready var motor: AudioStreamPlayer = $Motor
@onready var animation_player: AnimationPlayer = $Motor/AnimationPlayer
@onready var motor_start: AudioStreamPlayer = $MotorStart


var desired_velocity := Vector2.ZERO
var steering_velocity := Vector2.ZERO
var can_move := true
var sfx_playing = false
var can_fade = true

func _physics_process(_delta: float) -> void:
	if GameController.can_move:
		var direction = Input.get_vector('move_left',"move_right","move_up","move_down")
		desired_velocity = direction * max_speed # set desired velocity to direction * max speed
		steering_velocity = desired_velocity - velocity #set steering velocity to desired velocity - velocity
		velocity += steering_velocity * drag_factor #increment velocity by steering velocity
		rotation = velocity.angle()
		move_and_slide()
		
		# Check if the player is moving
		if direction.length() > 0:
			# Play the sound effect if it's not already playing
			if sfx_playing == false:
				
				motor.volume_db = -10.0
				motor.play()
				sfx_playing = true
				motor_start.play()
				print("starting motor")
		else:
			# Stop the sound effect if the player is not moving
			if sfx_playing == true:
				animation_player._fade()
				#sfx_playing = false
		


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("stoping audio")
	
	sfx_playing = false
