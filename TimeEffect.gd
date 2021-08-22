extends Node2D

var tween

func _ready():
	tween = get_node("Tween")
	tween.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	

func start():
	tween.start()

func _on_Tween_tween_all_completed():
	queue_free()
	
