extends Control

onready var level = preload("res://Level.tscn")

var temp_seed

func _ready():
	randomize()
	temp_seed = randi()%999999
	$PanelContainer/VBoxContainer/HBoxContainer5/Seed.text = str(temp_seed)
	
	$PanelContainer/VBoxContainer/HBoxContainer/HSlider.value = Global.volume
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), Global.volume)
	


func _on_Quit_pressed():
	get_tree().quit()



func _on_HSlider_value_changed(value):
	if value > -40:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
		
	Global.volume = value
	


func _on_Start_pressed():
	seed(int($PanelContainer/VBoxContainer/HBoxContainer5/Seed.text))
	get_tree().change_scene("res://Level.tscn")


func _on_HowToPlay_pressed():
	$PopupPanel.popup()


func _on_Close_pressed():
	$PopupPanel.hide()
