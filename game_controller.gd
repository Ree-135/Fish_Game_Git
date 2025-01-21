extends Node2D
#preload all minigames

# NOTE this is just the first minigame, we can make diffrent spots diffrent games, with diffrent fish even, or we can load all games into this
# then randomly deciide as the scene instantaites witch one to load.
# The game controller already calls random to handle this.
var MyScene = preload("res://MiniGames/BarMiniGame/Bar Minigame.tscn")

func _ready() -> void:
	randomize()


func _on_fishing_spot_pressed() -> void:
	# The first thing we want to do is cast out our bobber, so we change the texture to pressed
	
	# Then we need to write the logic to set a timer that will go for a ranom duration between 0 - 3 Seconds, at the end of this timer we decide if there is a bite or not
	
	# if there is a Bite then we do the logic below
	 
	# Create an instance of the scene
	var new_scene_instance = MyScene.instantiate()
	
	# Find the instance of the gui path to 
	var gui_node = get_tree().root.get_node("GamePrototype/Gui")
	# Add the new scene instance to the CanvasLayer or Control node
	gui_node.add_child(new_scene_instance)
	
	# We probably need to make a game - state machine that handles this code instead, because having a bunch of fishing spots on the screen means each one has all of the minigames preloaded wich
	# could be a huge problem especially if they are dynamic.
	# We probably want to make a game state that prevents the player from moving/ clicking on more fishing spots / opening the UI.
	
	# So like MENU state
	# Overworld State
	# Minigame State
