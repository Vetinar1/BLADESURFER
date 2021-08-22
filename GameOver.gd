extends Control


func _ready():
	$PanelContainer/HBoxContainer/VBoxContainer/ScoreLabel.set_text( str(floor(Global.score)))
	


func _on_RetryButton_pressed():
	get_tree().change_scene("res://Level.tscn")


func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://GoodMainMenu.tscn")
