extends Control


func _ready():
	$PanelContainer/VBoxContainer/ScoreLabel.set_text("Score: " + str(floor(Global.score)))
	


func _on_RetryButton_pressed():
	get_tree().change_scene("res://TestLevel.tscn")


func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://MainMenu.tscn")
