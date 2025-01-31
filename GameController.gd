extends Node


# Preload all minigames
var BarMini = preload("res://MiniGames/BarMiniGame/Bar Minigame.tscn")
var PunchMini = preload("res://MiniGames/PunchMiniGame/Punch Minigame.tscn")
var SpamMini = preload("res://MiniGames/SpamMiniGame/progress_bar.tscn")
var player_scene = preload("res://Entities/Player/Scenes/boat.tscn")
var sound_controller = preload("res://Common/Assets/Sound/SFX/Process/soundcontroller.tscn")
var fishepedia = preload("res://Utilities/GUI/Scenes/Fishipedia.tscn")
 

@onready var label: Label = $Gui/Label
@onready var sound_controller_instance = sound_controller.instantiate()



var can_move 
var is_fishing 
var fish_caught
var in_menu
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

#Starting Fish Values
@export var Fish_Amount := 20 # total number of starting fish
@export_range(0,1,0.1) var Percent_Native := 0.7 #starting perecnt of native fish
var Percent_Invasive = 1 - Percent_Native  #starting percent of invasive fish
var fish_distribution: Array #array to store amount of total fish

var currency = 0 #25 weight = 1 "Jam". Jam is currency

var Native_Counter = 0
var Invasive_counter = 0

var morality = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initialize randomize
	randomize()
	print("contoll variables set")
	can_move = true
	is_fishing = false
	
	
	# Set the fish Distribution
	set_fish_distribution()
	
	# Spawn fishing spots
	spawn_fishing_spots(Fish_Amount)  # Spawn fishing spots equal to the total fish amount
	
	add_child(sound_controller_instance)
	#here we can set a timer to spawn more fishingspots later
	# or if fishingspots is < 5 or whatever the max is, create another random one
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var player_node = get_node("Boat")
	pass
		
	
#set initial and sequential fish distributions



func set_fish_distribution():
	#set/reset temp arrays
	fish_distribution = [] #array to store amount of total fish
	var amount_Native_Fish = [] #array to store amount of Native fish
	var amount_Invasive_Fish = [] #array to store amount of Invasive fish
	
	var native_fish = roundf(Fish_Amount * Percent_Native) #amount of native fish based off a percent of the total fish rounded to the nearest int
	amount_Native_Fish.resize(native_fish) #sizes and fills a temp array of native fish
	amount_Native_Fish.fill(0)
	
	var invasive_fish = roundf(Fish_Amount * Percent_Invasive) #amount of Invasive fish based off a percent of the total fish rounded to the nearest int
	amount_Invasive_Fish.resize(invasive_fish) #sizes and fills a temp array of invasive fish
	amount_Invasive_Fish.fill(1)
	
	fish_distribution.append_array(amount_Native_Fish)
	fish_distribution.append_array(amount_Invasive_Fish)
	
	Fish_Amount = fish_distribution.size() #sets fish amount to match number of elements to account for rounding errors

#adjusts fish population percentage values due to player actions
func adjust_fish_perecent(fish_type: int, percent_change: float):
	if fish_type == 0:
		Percent_Native += percent_change
	if fish_type == 1:
		Percent_Invasive += percent_change
	
# will select a fish at random (for minigames) from a set distribution of fish
func fish_selector():
	var fish
	print("fish selected")
	
	var _instAmount = fish_distribution.size()  #gets the number of total available fish
	
	if fish_distribution.size() == 1:
		pass # basically dont allow the player to fish
	
	if fish_distribution.size() > 1:
		var _instRandom = RandomNumberGenerator.new().randi_range(0,_instAmount-1) #chooses fish type randomly from the distribution array
		var _instFish = fish_distribution[_instRandom] #sets the fish type (native/invasive)
	
		if _instAmount > 1:
			fish_distribution.remove_at(_instRandom) #removes previously selected fish from the distribution
		elif _instAmount == 1:
			fish_distribution.resize(0) #removes last element of the fish distribution array
	
		if _instFish == 0:
			fish = fish_listNATIVE
		if _instFish == 1:
			fish = fish_listINVASIVE
	
		var random_fish = RandomNumberGenerator.new().randi_range(0,(fish.size() - 1))
		return fish[random_fish]

func fish_winner(the_fish):
	fish_caught = true
	# rand weight maker for fish caught
	var Random_Weight = RandomNumberGenerator.new().randi_range(the_fish.Min_Weight, the_fish.Max_Weight)
	
	if the_fish.Type == 0: #caught native
		Native_Counter += 1
		adjust_fish_perecent(0, -0.05) #decrease native
		adjust_fish_perecent(1, 0.07) #increase invasive

		# making value for fish based off weight
		if Random_Weight <= 25: #if below 25 weight, just make currency +1 (cause it would round down to 0)
			currency += 2
		if Random_Weight > 25: #if its a normal case of weight
			currency += roundi(Random_Weight / 25) * 2 # multiplied by two so they're more valuable
		
	if the_fish.Type == 1: #caught invasive
		Invasive_counter += 1
		adjust_fish_perecent(1, -0.05) #decrease invasive
		adjust_fish_perecent(0, 0.07) #increase native


	if the_fish.Type == 0:
		morality -= .05
		
	if the_fish.Type == 1:
		morality += .05
		
		#duplicate of previous weight finder
		if Random_Weight <= 25:
			currency += 1
		if Random_Weight > 25:
			currency += roundi(Random_Weight / 25) # no * 2 multiplier because less valuable invasive fish

	the_fish.Caught = true
	print(Native_Counter)
	print(Invasive_counter)
	print("minigame ended, score updated")


# Function to spawn fishing spots
func spawn_fishing_spots(count: int) -> void:
	var map_node = get_tree().root.get_node("GamePrototype/ProtoMap")
	#map_node.add_child(sound_controller)
	print("fishingspots spawned")
	for i in range(count):
		var fishing_spot_scene = preload("res://Entities/FishingSpots/FishingSpot.tscn")  # Preload your fishing spot scene
		var fishing_spot_instance = fishing_spot_scene.instantiate()
		
		# Set a random position for the fishing spot
		#this is just a test range its completely random but -1000, 1200 is the range of x values and -1000, 1000 is range of y values
		fishing_spot_instance.position = Vector2(randf_range(-1000, 1200), randf_range(-1000, 1000))  # Adjust the range as needed
		fishing_spot_instance.connect("pressed",_on_fishing_spot_pressed)
		# Add the fishing spot to the current scene
		map_node.add_child(fishing_spot_instance)
		

# Function to handle fishing spot interaction
func _on_fishing_spot_pressed() -> void:
	print("fishingspot pressed")
	if is_fishing == false:
		
		# Start fishing logic
		start_fishing()
		#queue_free()
		
	else:
		#change_state(State.MINIGAME)
		print("you are already fishing")
		#do nothing?
#process to end fishing
func stop_fishing() -> void:
	
	if fish_caught == true:
		
		sound_controller_instance._fish_caught()
		fish_caught = false
	else:
		sound_controller_instance._fish_escape()
	print("you stopped fishing, controll variables reset")
	
	#set controll variables
	is_fishing = false
	can_move = true
	
# process to start fishing
func start_fishing() -> void:
	print("you are fishing, controll vars updated")
	
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
	
	#set controll variables
	is_fishing = true
	can_move = false
	
