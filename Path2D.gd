extends Path2D

export var is_rail : bool = false

func _ready():
	var points = curve.tessellate()
	var polygon = Polygon2D.new()
	var collpol = CollisionPolygon2D.new()
	
	polygon.polygon = points
	collpol.polygon = points
	
	get_parent().call_deferred("add_child", polygon)
	get_parent().call_deferred("add_child", collpol)
	
	if is_rail:
		get_parent().add_to_group("rails")
		polygon.color = Color(0, 0, 200)
	else:
		polygon.color = Color(200, 200, 0)

