extends Area2D

func _ready():
	pass


func _on_AudioStreamPlayer_finished():
	queue_free()


func _on_TimePickup_body_entered(body):
	$AudioStreamPlayer.play()
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	
	Global.timer.start(Global.timer.time_left + 1)
