extends Area2D

var in_fish:bool = false
var score = 0

func _on_area_2d_area_entered(area: Area2D) -> void:
	in_fish = true
	print("in area!")
	if Input.is_action_pressed("ui_accept") and in_fish:
		score += 1
		print(score)


func _on_area_2d_area_exited(area: Area2D) -> void:
	in_fish = false
