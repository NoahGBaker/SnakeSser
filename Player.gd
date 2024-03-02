extends Area2D
class_name snake_head


#Snake Head:
#Movement
#Collision (Walls/Self/Apple)
#Adding Segments: How? Adding the segment as a child of the Tail
#First Snake Segment: Why?
#                     In order to give it the first Direction Position
#Last Snake Segment (Tail): Why?
#                     To add segments after that segment
#Score

signal MoveSegment 

const SPEED = 300.0

var direction_pos = Vector2(190, 150)
var direction = Vector2.RIGHT
var next_direction = Vector2.RIGHT
var curr_pos = Vector2(150, 150)
var target_pos = Vector2(200, 150)
var next_pos
var move_time = .05



func _unhandled_input(event):
	if position != target_pos:
		if event.is_action_pressed("ui_left") and direction != Vector2.RIGHT and move_time <= 0:
			move_time = .1
			direction = Vector2.LEFT
		if event.is_action_pressed("ui_right") and direction != Vector2.LEFT and move_time <= 0:
			move_time = .1
			direction = Vector2.RIGHT
		if event.is_action_pressed("ui_up") and direction != Vector2.DOWN and move_time <= 0:
			move_time = .1
			direction = Vector2.UP
		if event.is_action_pressed("ui_down") and direction != Vector2.UP and move_time <= 0:
			move_time = .1
			direction = Vector2.DOWN
		#If a directional input happens set the position to nearest grid spot
		if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_up"):
			#No clue why this needs to be here but just dont delete this.
			if $move_timer.is_stopped():
				position = curr_pos
			else:
				next_direction = direction
		direction_pos = curr_pos
		emit_signal("MoveSegment")
#Use direction_pos to get the position of where we turn and get the turn direction. 
#Then use that to have a snake segment turn there


#Get place for snake to go along a certain sort of grid then set that goal to the previous snake body segment
func _physics_process(delta):
	# move towards target position
	move_time -= delta
	position = position.move_toward(target_pos, SPEED * delta)
	if position == target_pos:
		if next_direction != direction:
			direction = next_direction
		# if we have reached the target
		#Set next position to target position and the direction by the grid square size
		next_pos = target_pos + direction * 40
		target_pos = next_pos
		curr_pos = _get_position_from_grid(target_pos.x/10, target_pos.y/10) - direction * 10


func _get_position_from_grid(col : int, row : int) -> Vector2:
	return Vector2(col * 10, row * 10)
