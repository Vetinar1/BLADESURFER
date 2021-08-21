extends Area2D

onready var alive = true

func _ready():
	pass


func _on_EntryTrigger_body_entered(body):
	if alive:
		alive = false
		$CollisionShape2D.set_deferred("disabled", true)
		get_parent().get_parent().load_new()
		get_parent().get_parent().unload_old()
		queue_free()
