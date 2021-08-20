extends KinematicBody2D

onready var velocity : Vector2
export var maxspeed : int = 800
export var maxacc : int = 2000
export var rotspeed : float = 3
export var acc : float = 0
export var jerkup : float = 1000
export var jerkdown : float = 4000
export var friction : float = 0.5
export var sidefriction : float = 0.2

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	
func _physics_process(delta):
	#acc = 500 - velocity.length()
	#acc = 200 + exp(-velocity.length() / 100 + 10)
	$Camera2D/CanvasLayer/Panel/Label.set_text(str(velocity.length(), 2) + "\n" + str(acc))
	
	if Input.is_action_pressed("up"):
		acc += jerkup * delta + 10
		acc = min(acc, maxacc)
		
		if not Input.is_action_pressed("drift"):
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
			
		
	velocity += delta * Vector2.UP.rotated(rotation) * acc
	#if Input.is_action_pressed("down"):
	#	velocity += delta * Vector2.DOWN.rotated(rotation) * acc
		
	if Input.is_action_pressed("left"):
		rotation -= rotspeed * delta
		
		#if Input.is_action_pressed("drift"):
			
	if Input.is_action_pressed("right"):
		rotation += rotspeed * delta
		
	velocity = velocity.clamped(maxspeed)
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		if collision.collider.is_in_group("rails"):
			velocity = velocity.slide(collision.normal)
		else:
			acc = 0
			velocity = velocity.bounce(collision.normal) * 0.3

