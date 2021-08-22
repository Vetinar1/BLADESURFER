extends Area2D

var popup = preload("TimeEffect.tscn")

func _ready():
	pass


func _on_AudioStreamPlayer_finished():
	queue_free()


func _on_TimePickup_body_entered(body):
	var pop = popup.instance()
	pop.position = position
	get_parent().add_child(pop)
	pop.start()
	$AudioStreamPlayer.play()
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	
	Global.timer.start(Global.timer.time_left + 1)
