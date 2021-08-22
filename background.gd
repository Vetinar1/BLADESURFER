extends Node2D

onready var speed = 100
onready var tween = get_node("Tween")
var tween_values = [0.3, 1]

func _ready():
	_start_tween()


func _process(delta):
	pass
	

func _start_tween():
	tween.interpolate_property($Light2D, "energy", tween_values[0], tween_values[1], 10, Tween.TRANS_SINE)
	tween.start()

func _on_Tween_tween_completed(object, key):
	tween_values.invert()
	_start_tween()
