extends Node


@onready var fish_caught: AudioStreamPlayer = $FishCaught
@onready var fish_escape: AudioStreamPlayer = $FishEscape


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("SoundController Initilized")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _fish_caught() -> void:
	fish_caught.play()
	
func _fish_escape() -> void:
	fish_escape.play()
