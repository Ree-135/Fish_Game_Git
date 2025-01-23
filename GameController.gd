extends Node

# Set state variables
enum State {
	OVERWORLD, # Player can move freely, click on book to open menu, and interact with fishing spots / other environmental things
	MINIGAME, # Player cannot move, click on book, or interact with fishing spots / other environmental things
	MENU # Player cannot move, click on book, or interact with fishing spots / other environmental things this is similar to MINIGAME but will have specific ui things later
}

# Current state variable
var current_state: State = State.OVERWORLD

# Preload all minigames
var MyScene = preload("res://MiniGames/BarMiniGame/Bar Minigame.tscn")
@onready var player_node = get_node("Boat")
#var player_script = player_node.get_script()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initialize randomize
	randomize()
	
	# Spawn fishing spots
	spawn_fishing_spots(5)  # Spawn 5 fishing spots
	#here we can set a timer to spawn more fishingspots later
	# or if fishingspots is < 5 or whatever the max is, create another random one
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Function to change the state
func change_state(new_state: State):
	# Exit the current state
	exit_state(current_state)
	
	# Change to the new state
	current_state = new_state
	
	# Enter the new state
	enter_state(current_state)

# Function to handle entering a state
func enter_state(state: State):
	match state:
		State.OVERWORLD:
			print("Entering OverWorld")
			player_node.can_move = true
		State.MINIGAME:
			print("Entering MiniGame")
			# Initialize MiniGame here
			player_node.can_move = false
		State.MENU:
			print("Entering Menu")
			# Initialize Menu here
			player_node.can_move = false

# Function to handle exiting a state
func exit_state(state: State):
	match state:
		State.OVERWORLD:
			print("Exiting OverWorld")
			# Cleanup OverWorld here
		State.MINIGAME:
			print("Exiting MiniGame")
			# Cleanup MiniGame here
		State.MENU:
			print("Exiting Menu")
			# Cleanup Menu here


# Function to spawn fishing spots
func spawn_fishing_spots(count: int) -> void:
	for i in range(count):
		var fishing_spot_scene = preload("res://Entities/FishingSpots/FishingSpot.tscn")  # Preload your fishing spot scene
		var fishing_spot_instance = fishing_spot_scene.instantiate()
		
		# Set a random position for the fishing spot
		#this is just a test range its completely random but -1000, 1200 is the range of x values and -1000, 1000 is range of y values
		fishing_spot_instance.position = Vector2(randf_range(-1000, 1200), randf_range(-1000, 1000))  # Adjust the range as needed
		fishing_spot_instance.connect("pressed",_on_fishing_spot_pressed)
		# Add the fishing spot to the current scene
		add_child(fishing_spot_instance)

# Function to handle fishing spot interaction
func _on_fishing_spot_pressed() -> void:
	if current_state == State.OVERWORLD:
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
	
	change_state(GameController.State.MINIGAME)
	
	
	
