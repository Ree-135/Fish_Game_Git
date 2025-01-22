extends PathFollow2D

##         How this works at ALL works!
			#------------------------Prep-------------------------
# in the main scene give the fish a path to follow (make fish a child of path) (I recommend making it bottom up)
# also add a sprite to be a CHILD of fish
			#------------------------Use--------------------------
# this is a good, modifiable fish that can easily be changed per-case using the right side panel
#everything is commented out, so it should be legible, but I made all this code in a 4 hour spree



@export var speed:float = .1 ##How fast the fish can move
@export var nodes: int = 10 ##How many different points the fish should move to (equal distance apart) the top node and bottom node
@export var detection_range: float = .01 ##How close the fish has to get to the node (recommend .01 -> .5) to move to the next node
@export var Catch_Speed: float = .001 ##How fast the fish is cought while in the bar (VERY low numbers recommended)

var score = .10 # how "caught" the fish is in perchantage, this is a starting value
var in_fish:bool = false # testing value for if the bar is in the fish or not

var ran = RandomNumberGenerator.new() # random number generator
var progress_point: float = float(ran.randi_range(0, nodes)) / nodes 
#this makes a random point on a scale from 1 -> 0, the higher the node variable, the more points between

func _on_area_2d_body_entered(body: Node2D) -> void:
	in_fish = true
# tests if fish entered the bar (really the other way around but idc)

func _on_area_2d_body_exited(body: Node2D) -> void:
	in_fish = false
# tests if fish left the bar

# by not dirrectly affecting the score inside the entered and exit body 2D (next line)
	# it allows us to make the score happen every frame in _process, otherwise it would only happen once

func _process(delta: float) -> void:
	
	progress_ratio += speed * delta * (progress_point - progress_ratio)
	# moves the fish to the progress point along the line
	
	if (progress_ratio <= progress_point + detection_range) and (progress_ratio >= progress_point - detection_range):
		ran.randomize()
		progress_point = float(ran.randi_range(0, nodes)) / nodes
		#print(progress_point)
	#all this says if the fish gets close enough to the progress point, make a new point to move towards
	
	if in_fish == true and score < 1:
		score += Catch_Speed
	if (in_fish == false) and (score > 0):
		score -= Catch_Speed
	# both cases are just score counters, +up if bar is in the fish, -down if bar not in fish
	
	if score >= 1:
		print("you win! :D")
	if score <= 0:
		print("you lose :(")
