extends Control

func _ready():
	pass


func _on_Quit_pressed():
	get_tree().quit()


func _on_Continue_pressed():
	hide()
	get_tree().paused = false
	$AudioStreamPlayer.stream_paused = true


func _on_HSlider_value_changed(value):
	if value > -40:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)


func _on_Start_pressed():
	get_tree().change_scene("res://Level.tscn")


func _process(delta):
	if visible == true:
		if Input.is_action_just_pressed("pause"):
			_on_Continue_pressed()
