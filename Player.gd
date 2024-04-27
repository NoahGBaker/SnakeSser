extends Area2D
class_name SnakeHead

#Snake Head:
#Movement
#Collision (Walls/Self/Apple)
#Adding Segments: How? Adding the segment as a child of the Tail
#Be able to have an ARRAY of all of the snake segments:
#      Loop through each one and tell it where to go.
#      According to the next segment in the loop.
#      Do this in this if statement: if position == target_pos:
#      Loop through all segments head to tail and set their target position to the previous things current position.
#Score 

const SPEED = 290.0

@onready var segment = get_node("$../SnakeSegment")
var direction_pos = Vector2(190, 150)
var direction
var next_direction = Vector2.RIGHT
var curr_pos = Vector2(150, 150)
var target_pos = Vector2(200, 150)
var next_pos
var move_time = .05
var segments : Array[Area2D]


func _unhandled_input(event):
	if event.is_action_pressed("ui_left") and direction != Vector2.RIGHT:
		next_direction = Vector2.LEFT
	if event.is_action_pressed("ui_right") and direction != Vector2.LEFT:
		next_direction = Vector2.RIGHT
	if event.is_action_pressed("ui_up") and direction != Vector2.DOWN:
		next_direction = Vector2.UP
	if event.is_action_pressed("ui_down") and direction != Vector2.UP:
		next_direction = Vector2.DOWN
	#If a directional input happens set the position to nearest grid spot
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_up"):
		#No clue why this needs to be here but just dont delete this.
		if $move_timer.is_stopped():
			position = curr_pos
	
	direction_pos = curr_pos
	direction = next_direction
#Use direction_pos to get the position of where we turn and get the turn direction. 
#Then use that to have a snake segment turn there


#Get place for snake to go along a certain sort of grid then set that goal to the previous snake body segment

func _get_position_from_grid(col : int, row : int) -> Vector2:
	return Vector2(col * 10, row * 10)

var new_data = {}
func move(delta, data : Dictionary) -> Dictionary:
	move_time -= delta
	position = position.move_toward(target_pos, SPEED * delta)
	if position == target_pos:
		#If we have reached the target
		#Set next position to target position and the direction by the grid square size
		next_pos = target_pos + next_direction * 40
		target_pos = next_pos
		curr_pos = _get_position_from_grid(target_pos.x/10, target_pos.y/10) - next_direction * 10
		new_data = {
		"delta" : delta,
		"target_pos" : target_pos,
		"direction" : direction,
		"next_direction" : next_direction,
		"direction_pos" : direction_pos,
		"next_pos" : next_pos
		}
	return new_data
