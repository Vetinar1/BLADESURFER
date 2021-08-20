extends StaticBody2D

export var is_rail : bool = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$tile_0049.scale = $CollisionShape2D.shape.extents / 8
	if is_rail:
		add_to_group("rails")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
