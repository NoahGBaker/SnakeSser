extends Area2D
class_name snake_head

const SPEED = 400.0

var direction_pos
var direction = Vector2.RIGHT
var curr_pos
var target_pos
var next_pos


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
	position = GRID[5][5]
	curr_pos = GRID[5][5]
	target_pos = GRID[10][5]
	#print(GRID)


func _unhandled_input(event):
	if position != target_pos:
		if event.is_action_pressed("ui_left"):
			direction = Vector2.LEFT
		if event.is_action_pressed("ui_right"):
			direction = Vector2.RIGHT
		if event.is_action_pressed("ui_up"):
			direction = Vector2.UP
		if event.is_action_pressed("ui_down"):
			direction = Vector2.DOWN
		if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
			position = curr_pos
		if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_up"):
			position = curr_pos
		direction_pos = curr_pos
#Use direction_pos to get the position of where we turn and get the turn direction. 
#Then use that to have a snake segment turn there


#Get place for snake to go along a certain sort of grid then set that goal to the previous snake body segment
func _physics_process(delta):
	# move towards target position
	position = position.move_toward(target_pos, SPEED * delta)
	if position == target_pos:
		# if we have reached the target
		next_pos = target_pos + direction * 50
		target_pos = next_pos
		curr_pos = _get_position_from_grid(target_pos.x/10, target_pos.y/10) - direction * 50


func _get_position_from_grid(col : int, row : int) -> Vector2:
	return Vector2(col * 10, row * 10)

func move_segment(segment : Area2D):
	
	pass
