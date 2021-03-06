extends Control

var active = false

func _ready():
	$PanelContainer/VBoxContainer/HBoxContainer/HSlider.value = Global.volume


func _on_Quit_pressed():
	get_tree().quit()


func _on_Continue_pressed():
	active = false
	hide()
	get_tree().paused = false
	$AudioStreamPlayer.stream_paused = true


func _on_HSlider_value_changed(value):
	if value > -40:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
		
	Global.volume = value


func _process(delta):
	if not active and Input.is_action_just_pressed("pausebutton"):
		set_rotation(-get_parent().get_parent().rotation)
		active = true
		show()
		get_tree().paused = true
		$AudioStreamPlayer.stream_paused = false
		
	else:
		if Input.is_action_just_pressed("pausebutton"):
			_on_Continue_pressed()


func _on_Back_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://GoodMainMenu.tscn")
