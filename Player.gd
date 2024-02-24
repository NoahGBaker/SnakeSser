extends Area2D
class_name snake_head

const SPEED = 300.0

var direction_pos
var direction = Vector2.RIGHT
var next_direction = Vector2.RIGHT
var curr_pos
var target_pos
var next_pos
var move_time = .5

const Row = 50
const Collumn = 50

var GRID :Array

@onready var snake_segment_resource = preload("res://snake_segment.tscn")

func _ready():
	
	var new_segment = snake_segment_resource.instantiate()
	add_child(new_segment)
	
	for i in range(Collumn):
		GRID.append([])
		for j in range(Row):
			GRID[i].append(Vector2(i * 10 + 100, j * 10 + 100))
	curr_pos = GRID[5][5]
	target_pos = GRID[10][5]
	#print(GRID)


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
			if $move_timer.is_stopped():
				position = curr_pos
			else:
				next_direction = direction
		direction_pos = curr_pos
#Use direction_pos to get the position of where we turn and get the turn direction. 
#Then use that to have a snake segment turn there


#Get place for snake to go along a certain sort of grid then set that goal to the previous snake body segment
func _physics_process(delta):
	# move towards target position
	move_time -= delta
	print(move_time)
	position = position.move_toward(target_pos, SPEED * delta)
	if position == target_pos:
		if next_direction != direction:
			direction = next_direction
		# if we have reached the target
		$move_timer.start(2)
		next_pos = target_pos + direction * 40
		target_pos = next_pos
		curr_pos = _get_position_from_grid(target_pos.x/10, target_pos.y/10) - direction * 10


func _get_position_from_grid(col : int, row : int) -> Vector2:
	return Vector2(col * 10, row * 10)

func move_segment(segment : Area2D):
	
	pass
