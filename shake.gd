extends Node2D

var camera
var duration = 0
var active = false
export var magnitude = 10

func _ready():
	camera = get_parent().get_node("Camera2D")
	
func shake(time):
	active = true
	duration = time

func _process(delta):
	if active:
		duration -= delta
		
		if duration > 0:
			camera.offset = Vector2(randf() * magnitude, randf() * magnitude)
		else:
			camera.offset = Vector2()
			active = false
