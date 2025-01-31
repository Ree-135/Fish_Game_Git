extends CanvasModulate

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY

signal time_tick(day:int, hour:int, minute:int)

@export var gradient:GradientTexture1D
@export var INGAME_SPEED = 8.0 # 8 min per sec
@export var INITIAL_HOUR = 6

var time:float = 0.0
var past_minute:float = -1.0

var end_screen_load = preload("res://Utilities/GUI/End screen.tscn")
@onready var end_screen: Control = $"../Gui/End screen"
@onready var caught_: Label = $"../Gui/CAUGHT!"
@onready var quota_label: Label = $"../Gui/Quota Label"
var quota:int = 0

var day:int
var next_day = 1


func _ready() -> void:
	time = INGAME_TO_REAL_MINUTE_DURATION * INITIAL_HOUR * MINUTES_PER_HOUR
	
	end_screen_load = preload("res://Utilities/GUI/End screen.tscn")
	
	day = 0
	Quota_system()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta * INGAME_TO_REAL_MINUTE_DURATION * INGAME_SPEED
	var value = (sin(time -PI / 2) + 1.0) / 2.0
	self.color = gradient.gradient.sample(value)
	
	_recalculate_time()
	
	
	
			
	if day == next_day:
		
		GameController.Fish_Amount *= 1.5 
		
		if GameController.currency < quota and day > 0:
			GameController.can_move = false
			GameController.is_fishing = true
			end_screen.visible = true
			
			
		
		if GameController.currency >= quota:
			GameController.currency -= quota
		
			Quota_system()
			next_day += 1



func _recalculate_time() -> void:
	var total_minutes = int(time / INGAME_TO_REAL_MINUTE_DURATION)
	
	day = int(total_minutes / MINUTES_PER_DAY)
	
	var current_day_minutes = total_minutes % MINUTES_PER_DAY
	
	var hour = int(current_day_minutes / MINUTES_PER_HOUR)
	var minute = int(current_day_minutes % MINUTES_PER_HOUR)
	
	if past_minute != minute:
		past_minute = minute
		time_tick.emit(day, hour, minute)


func Quota_system() -> void:
	
	
	quota
	var random_quota_value = RandomNumberGenerator.new().randi_range(25,50)
	randomize()
	
	quota += day * random_quota_value
	
	if day == 0:
		quota += random_quota_value
	
	quota_label.text = "Day quota: " + str(quota) + " Jams"
	randomize()
