extends Node2D

var segments = []
var i = 1

func _ready():
	for child in get_children():
		segments.append(i)
		i = i + 1
		print(i)
	print(segments)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#target_pos: Where the snake segment wants to move
#direction: What direction the segment is going
#direction_pos: Where the last direction change is on the grid.
func _physics_process(delta):
	var data_from_previous_segment = {
		"delta" : delta,
		"target_pos" : Vector2.ZERO,
		"direction" : Vector2.ZERO,
		"next_direction" : Vector2.ZERO,
		"direction_pos" : Vector2.ZERO,
		"next_pos" : Vector2.ZERO,
		"position_number" : int(1),
		"position_list" : segments
		}
		
	for child in get_children():
		data_from_previous_segment = child.move(delta, data_from_previous_segment)
