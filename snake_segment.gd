extends Area2D

#Snake Segment:
#Segments Movement aka follow head
#Previous Segment
#Direction Position (Target Position)
#!!! Use Signals !!!

func _ready():
	connect("MoveSegment", OogaBoogaFunction)

func OogaBoogaFunction():
	print("Hello")
