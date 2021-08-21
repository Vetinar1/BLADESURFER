extends Control

onready var level = preload("res://Level.tscn")

func _ready():
	pass


func _on_Quit_pressed():
	get_tree().quit()


func _on_Continue_pressed():
	pass


func _on_HSlider_value_changed(value):
	if value > -40:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)


func _on_Start_pressed():
	get_tree().change_scene("res://Level.tscn")
