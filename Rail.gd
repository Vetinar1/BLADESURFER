extends StaticBody2D

export var is_rail : bool = false
export var blue : bool = false

func _ready():
	var points = $Path2D.curve.tessellate()
	var polygon = Polygon2D.new()
	var collpol = CollisionPolygon2D.new()
	
	polygon.position += $Path2D.position
	collpol.position += $Path2D.position
	polygon.polygon = points
	collpol.polygon = points
	
	if is_rail:
		add_to_group("rails")
		
		if blue:
			polygon.color = Color(0, 0, 200)
		else:
			polygon.color = Color(200, 200, 0)
	
	add_child(polygon)
	add_child(collpol)
	
	


