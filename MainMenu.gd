extends Control

var level

func _ready():
	level = preload("res://TestLevel.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()


func _on_StartButton_pressed():
	get_tree().change_scene("res://TestLevel.tscn")
