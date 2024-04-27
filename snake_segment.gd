extends Area2D


#Snake Segment:
#Segments Movement aka follow head
#Previous Segment
#Direction Position (Target Position)
#!!! Use Signals !!!
var target_pos_alt = Vector2(100, 140)
const SPEED = 290
var next_direction = Vector2.RIGHT
var curr_pos = Vector2(100, 150)
var direction_pos
var direction
var next_pos


func _ready():
	position = Vector2(100, 150)

func _get_position_from_grid(col : int, row : int) -> Vector2:
	return Vector2(col * 10, row * 10)

var new_data = {}
func move(delta, data : Dictionary) -> Dictionary:
		
	#If we have reached the target
	#Set next position to target position and the direction by the grid square size
	if data: 
		next_pos = data.next_pos
		direction_pos = data.direction_pos
		next_direction = data.next_direction
		next_pos = data.next_pos
		#If we have reached the target
		if position == direction_pos:
			next_direction = direction
		#Set next position to target position and the direction by the grid square size
		print(target_pos_alt)
		next_pos = target_pos_alt + next_direction * 40
		target_pos_alt = next_pos
		curr_pos = _get_position_from_grid(target_pos_alt.x/10, target_pos_alt.y/10) - next_direction * 10
		new_data = {
		"delta" : delta,
		"direction" : direction,
		"next_direction" : next_direction,
		"direction_pos" : direction_pos,
		"next_pos" : next_pos
		}
	position = position.move_toward(target_pos_alt, SPEED * delta)
	return new_data
