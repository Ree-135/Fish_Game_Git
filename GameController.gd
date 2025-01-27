extends Node

# Set state variables
enum State {
	OVERWORLD, # Player can move freely, click on book to open menu, and interact with fishing spots / other environmental things
	MINIGAME, # Player cannot move, click on book, or interact with fishing spots / other environmental things
	MENU # Player cannot move, click on book, or interact with fishing spots / other environmental things this is similar to MINIGAME but will have specific ui things later
}


# Current state variable
var current_state: State = State.OVERWORLD
# Preload the scenes you want to add
var MyScene2 = preload("res://Utilities/GUI/Scenes/Fishipedia.tscn")
# Preload all minigames
var BarMini = preload("res://MiniGames/BarMiniGame/Bar Minigame.tscn")
var PunchMini = preload("res://MiniGames/PunchMiniGame/Punch Minigame.tscn")
var SpamMini = preload("res://MiniGames/SpamMiniGame/progress_bar.tscn")
var player_scene = preload("res://Entities/Player/Scenes/boat.tscn")

var can_move = true
#var player_script = player_node.get_script()

# array of all the native fish 
var fish_listNATIVE: Array = [
	preload("res://Fish/AtlanticSturgeon.tres"),
	preload("res://Fish/Bowfin.tres"),
	preload("res://Fish/Buffalo.tres"),
	preload("res://Fish/ChannelCatfish.tres"),
	preload("res://Fish/FloridaGar.tres"),
	preload("res://Fish/GreatBarracuda.tres"),
	preload("res://Fish/LargemouthBass.tres"),
	preload("res://Fish/PencilEEL.tres"),
	preload("res://Fish/Pupfish.tres"),
	preload("res://Fish/Sheepshead.tres"),
	preload("res://Fish/SailfinMolly.tres"),
	preload("res://Fish/SwampDarter.tres")]

# array of all the invasive fish 
var fish_listINVASIVE: Array = [
	preload("res://Fish/Snakehead.tres"),
	preload("res://Fish/Carp.tres"),
	preload("res://Fish/Mosquitofish.tres"),
	preload("res://Fish/PeacockBass.tres"),
	preload("res://Fish/JaguarCichlid.tres"),
	preload("res://Fish/Oscar.tres"),
	preload("res://Fish/RainbowTrout.tres"),
	preload("res://Fish/ClownKnifefish.tres"),]

var Native_Counter = 0
var Invasive_counter = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initialize randomize
	randomize()
	var player_node = get_node("Boat")
	
	
	# Spawn fishing spots
	spawn_fishing_spots(15)  # Spawn 5 fishing spots
	#here we can set a timer to spawn more fishingspots later
	# or if fishingspots is < 5 or whatever the max is, create another random one
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var player_node = get_node("Boat")
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
			can_move = true
		State.MINIGAME:
			print("Entering MiniGame")
			# Initialize MiniGame here
			can_move = false
		State.MENU:
			print("Entering Menu")
			# Initialize Menu here
			can_move = false

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

# will select a fish at random (for minigames)
func fish_selector():
	var fish
	var random_list = RandomNumberGenerator.new().randi_range(0,1)
	
	if random_list == 0:
		fish = fish_listNATIVE
	if random_list == 1:
		fish = fish_listINVASIVE
	
	var random_fish = RandomNumberGenerator.new().randi_range(0,(fish.size() - 1))
	return fish[random_fish]

func fish_winner(the_fish):
	
	if the_fish.Type == 0:
		Native_Counter += 1
		
	if the_fish.Type == 1:
		Invasive_counter += 1
		
	the_fish.Caught = true
	print(Native_Counter)
	print(Invasive_counter)


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
		var map_node = get_tree().root.get_node("GamePrototype/ProtoMap")
		map_node.add_child(fishing_spot_instance)

# Function to handle fishing spot interaction
func _on_fishing_spot_pressed() -> void:
	if current_state == State.OVERWORLD:
		print("You are fishing!")
		
		# Start fishing logic
		start_fishing()
		
	else:
		print("You are already fishing")

#process to end fishing
func stop_fishing() -> void:
	if current_state == State.MINIGAME:
		exit_state(State.MINIGAME)
		change_state(State.OVERWORLD)
		enter_state(State.OVERWORLD)
	
# process to start fishing
func start_fishing() -> void:
	
	var game_selector = RandomNumberGenerator.new().randi_range(0,2)
	var new_scene_instance
	
	# Create a new, random instance of the fishing minigame
	if game_selector == 0:
		new_scene_instance = BarMini.instantiate()
	if game_selector == 1:
		new_scene_instance = PunchMini.instantiate()
	if game_selector == 2:
		new_scene_instance = SpamMini.instantiate()
	
	# Find the instance of the GUI path
	var gui_node = get_tree().root.get_node("GamePrototype/Gui")
	
	# Add the new scene instance to the CanvasLayer or Control node
	gui_node.add_child(new_scene_instance)
	
	change_state(GameController.State.MINIGAME)

# there are lots more nodes we can use to add extra polish, like a saftey animation that plays when the mouse hovers over the bookicon
func _on_book_icon_pressed() -> void:
	# Print("use this item")
	# We want to use the fishipedia when this is pressed
	# Create an instance of the scene
	var new_scene_instance = MyScene2.instantiate()
	
	# Find the instance of the gui path to 
	var gui_node = get_tree().root.get_node("GamePrototype/Gui")
	# Add the new scene instance to the CanvasLayer or Control node
	gui_node.add_child(new_scene_instance)
	
	change_state(GameController.State.MENU)
	
	
	# The next step is to add a X button to the book pages to that the book can be closed.
	
	# The book will also have many pages wich are really just menu screens that aren't made yet but for now, lets focus on being able to close the book
