extends KinematicBody2D

onready var velocity : Vector2
export var maxspeed : int = 800
export var maxacc : int = 1000
export var rotspeed : float = 2.5
export var acc : float = 0
export var jerkup : float = 1000
export var jerkdown : float = 4000
export var friction : float = 0.5
export var sidefriction : float = 0.1

var railmaxspeed_mult : float = 2

var right_magnet : bool = false
var left_magnet : bool = false
var magnet : bool = true
var boosted : bool = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	
func _physics_process(delta):
	var railmaxspeed = railmaxspeed_mult * maxspeed
	
	magnet = right_magnet or left_magnet
	$Camera2D/CanvasLayer/Panel/Label.set_text(str(velocity.length(), 2) + "\n" + str(acc))
	
	if Input.is_action_pressed("up"):
		acc += jerkup * delta + 10
		acc = min(acc, maxacc)
		
		velocity -= Vector2(velocity.rotated(-rotation).x * sidefriction * delta, 0).rotated(rotation)
	else:
		acc -= jerkdown * delta
		acc = max(acc, 0)
		
		if acc == 0:
			if velocity.length() > 500:
				velocity -= velocity * friction * delta
			else:
				velocity -= 500 * delta * velocity.normalized()
				if velocity.length() < 10:
					velocity = Vector2()
			
		
	# check if still boosted
	if boosted and velocity.length() < maxspeed:
		boosted = false
		
	
	if not boosted and not magnet:
		# regular flight
		velocity += delta * Vector2.UP.rotated(rotation) * acc
		velocity = velocity.clamped(maxspeed)
	elif magnet:
		# on rail
		velocity += delta * Vector2.UP.rotated(rotation) * acc
		velocity = velocity.clamped(railmaxspeed)
		if velocity.length() > maxspeed:
			boosted = true
	else:
		# boosted, not on rail
		velocity += delta * Vector2.UP.rotated(rotation) * acc
		velocity = velocity.clamped(railmaxspeed)
		velocity -= velocity * friction * delta
		
		
	if Input.is_action_pressed("down"):
		velocity += delta * Vector2.DOWN.rotated(rotation) * 500
		
	if Input.is_action_pressed("left"):
		rotation -= rotspeed * delta
		
	if Input.is_action_pressed("right"):
		rotation += rotspeed * delta
	
	var collision = move_and_collide(velocity * delta)
	
	if not magnet:
		if collision:
			if collision.collider.is_in_group("rails") and magnet:
				velocity = velocity.slide(collision.normal)
			else:
				acc = 0
				velocity = velocity.bounce(collision.normal) * 0.3
				
	elif collision:
		if left_magnet:
			rotation = collision.normal.rotated(- PI / 2).angle() + PI / 2
		if right_magnet:
			rotation = collision.normal.rotated(PI / 2).angle() + PI / 2
		
		velocity -= Vector2(velocity.rotated(-rotation).x, 0).rotated(rotation)


func _on_LeftWing_body_entered(body):
	if body.is_in_group("rails"):
		if body.get_child(0).right:
			left_magnet = true


func _on_RightWing_body_entered(body):
	if body.is_in_group("rails"):
		if body.get_child(0).right:
			right_magnet = true
		
		
func _on_LeftWing_body_exited(body):
	if body.is_in_group("rails"):
		left_magnet = false


func _on_RightWing_body_exited(body):
	if body.is_in_group("rails"):
		right_magnet = false
