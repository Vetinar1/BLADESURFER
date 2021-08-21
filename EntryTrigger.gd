extends Area2D


func _ready():
	pass


func _on_EntryTrigger_body_entered(body):
	get_parent().get_parent().load_new()
	get_parent().get_parent().unload_old()
	queue_free()
