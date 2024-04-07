extends Area2D


#Snake Segment:
#Segments Movement aka follow head
#Previous Segment
#Direction Position (Target Position)
#!!! Use Signals !!!

const SPEED = 290
var direction = Vector2.RIGHT
var next_direction = Vector2.RIGHT
var curr_pos = Vector2(150, 150)
var target_pos = Vector2(200, 150)
var next_pos

func _physics_process(delta):
	position = position.move_toward(target_pos, SPEED * delta)
	if position == target_pos:
		#If we have reached the target
		#Set next position to target position and the direction by the grid square size
		next_pos = target_pos + next_direction * 40
		target_pos = next_pos
		curr_pos = _get_position_from_grid(target_pos.x/10, target_pos.y/10) - next_direction * 10
		direction = next_direction

func MoveSegment():
	emit_signal("segment_moved")

func _get_position_from_grid(col : int, row : int) -> Vector2:
	return Vector2(col * 10, row * 10)


func segment_move(target_pos_2, direction_2, direction_pos_2):
	target_pos = target_pos_2
	direction = direction_2
	var direction_pos = direction_pos_2
