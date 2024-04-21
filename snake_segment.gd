extends Area2D


#Snake Segment:
#Segments Movement aka follow head
#Previous Segment
#Direction Position (Target Position)
#!!! Use Signals !!!

const SPEED = 290
var direction
var next_direction = Vector2.RIGHT
var curr_pos
var target_pos
var next_pos
var direction_pos


func _ready():
	position = Vector2(100, 150)


func _get_position_from_grid(col : int, row : int) -> Vector2:
	return Vector2(col * 10, row * 10)

func move(data : Dictionary) -> Dictionary:
	var delta = data.delta
	var target_pos = data.target_pos
	var direction = data.direction
	var direction_pos = data.direction_pos
	var next_pos = data.next_pos
	position = position.move_toward(target_pos, SPEED * delta)
	if position == target_pos:
		#If we have reached the target
		#Set next position to target position and the direction by the grid square size
		next_pos = target_pos + next_direction * 40
		target_pos = next_pos
		curr_pos = _get_position_from_grid(target_pos.x/10, target_pos.y/10) - next_direction * 10
		direction = next_direction
	var new_data = {
		"delta" : delta,
		"target_pos" : target_pos,
		"direction" : direction,
		"direction_pos" : direction_pos,
		"next_pos" : next_pos
	}
	print(new_data)
	return new_data
