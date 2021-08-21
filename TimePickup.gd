extends Area2D

func _ready():
	pass


func _on_AudioStreamPlayer_finished():
	queue_free()


func _on_TimePickup_body_entered(body):
	$AudioStreamPlayer.play()
	hide()
	$CollisionShape2D.disabled = true
	
	var timer = get_node("../Spaceship/Timer")
	
	timer.start(timer.time_left + 10)
