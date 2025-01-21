extends Resource

class_name Fish

@export var Name:String = "Fish!" ## Name of the fish... what did you expect??
@export var FishTexture:Texture2D ## This is what image you'll use for the fish
@export var Weight:int = 0 ## Use this IF the fish can only weigh one specific weight (in Pancakes)
@export var Max_Weight:int = 0 ## Max weight for the fish in Pancakes
@export var Min_Weight:int = 0 ## Min weight for the fish in Pancakes
@export var Type:Typing = 0 ## What typing the fish is
@export var Spawn_Location:Special = 0 ## Maybe we'll use this?? just allows different locations for fish
@export var Random_Weight:int = RandomNumberGenerator.new().randi_range(Min_Weight, Max_Weight) ##No clue if this acually works

enum Typing {Native, Invasive}
enum Special {Nothing, Deep, Shallow}
