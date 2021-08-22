extends Node

var score : float = 0
var timer_default : float = 30
var timer

var ORANGE = Color(255.0/255.0, 150.0/255.0, 25.0/255.0)
var BLUE = Color(246.0/255, 1.0/255, 157.0/255)

func _ready():
	#randomize()
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.connect("timeout", self, "_on_Timer_timeout")
	

func _on_Timer_timeout():
	get_tree().change_scene("res://GameOver.tscn")

