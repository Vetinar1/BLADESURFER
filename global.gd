extends Node

var score : float = 0
var timer_default : float = 1000
var timer

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.connect("timeout", self, "_on_Timer_timeout")
	

func _on_Timer_timeout():
	get_tree().change_scene("res://GameOver.tscn")
