extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initialize randomize
	randomize()
	# Spawn fishing spots
	spawn_fishing_spots(5)  # Spawn 5 fishing spots
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	pass    

# Set state variables
var gameState1 = true  # Player can move freely, click on book to open menu, and interact with fishing spots / other environmental things
var gameState2 = false # Player cannot move, click on book, or interact with fishing spots / other environmental things
# Preload all minigames
var MyScene = preload("res://MiniGames/BarMiniGame/Bar Minigame.tscn")




# Function to spawn fishing spots
func spawn_fishing_spots(count: int) -> void:
	for i in range(count):
		var fishing_spot_scene = preload("res://Entities/FishingSpots/FishingSpot.tscn")  # Preload your fishing spot scene
		var fishing_spot_instance = fishing_spot_scene.instantiate()
		
		# Set a random position for the fishing spot
		fishing_spot_instance.position = Vector2(randf_range(0, 800), randf_range(0, 600))  # Adjust the range as needed
		
		# Add the fishing spot to the current scene
		add_child(fishing_spot_instance)

# Function to handle fishing spot interaction
func _on_fishing_spot_pressed() -> void:
	if gameState1:
		print("You are fishing!")
		
		# Start fishing logic
		start_fishing()
	else:
		print("You are already fishing")

# Function to start the fishing process
func start_fishing() -> void:
	# Create a new instance of the fishing minigame
	var new_scene_instance = MyScene.instantiate()
	
	# Find the instance of the GUI path
	var gui_node = get_tree().root.get_node("GamePrototype/Gui")
	
	# Add the new scene instance to the CanvasLayer or Control node
	gui_node.add_child(new_scene_instance)
	
	# Set game states
	gameState1 = false
	gameState2 = true
