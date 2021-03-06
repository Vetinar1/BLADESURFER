extends KinematicBody2D

onready var velocity : Vector2
export var maxspeed : int = 800
export var launchvel : float = 500
export var maxacc : int = 1000
export var rotspeed : float = 2.5
export var acc : float = 0
export var jerkup : float = 1000
export var jerkdown : float = 4000
export var friction : float = 0.5
export var sidefriction : float = 0.1

var old_time
var new_time

var railmaxspeed_mult : float = 2

var right_magnet : bool = false
var left_magnet : bool = false
var magnet : bool = true
var boosted : bool = true

export var is_switching : bool = false
var inverted : bool = true

var lastnormal : Vector2


func _ready():
	$AudioStreamPlayer.stream_paused = false
	Global.timer.start(Global.timer_default)
	
func _process(delta):
	var idx = AudioServer.get_bus_index("Accel")
	var effect = AudioServer.get_bus_effect(idx, 0)
	effect.set_pitch_scale(velocity.length()/1200 + 1)
	
	
	new_time = Global.timer.time_left
	if new_time < 3 and old_time > 3:
		$warning.play()
	if new_time < 2 and old_time > 2:
		$warning.play()
	if new_time < 1 and old_time > 1:
		$warning.play()
	
		
	if magnet:
		$Particles2D.emitting = true
		$Particles2D.process_material.direction.y = (velocity.length() / 800) * 10
		if left_magnet:
			if inverted:
				$Particles2D.modulate = Global.BLUE
			else:
				$Particles2D.modulate = Global.ORANGE
			$Particles2D.process_material.direction.x = 10
		else:
			if inverted:
				$Particles2D.modulate = Global.ORANGE
			else:
				$Particles2D.modulate = Global.BLUE
			$Particles2D.process_material.direction.x = -10
	else:
		$Particles2D.emitting = false
	old_time = Global.timer.time_left
	

func _physics_process(delta):
		
	$ColorRect.set_rotation(-rotation)
	#$Camera2D/PauseMenu.set_rotation(-rotation)
	magnet = right_magnet or left_magnet
	
	var oldspeed = velocity.length()
	Global.score += pow(oldspeed / 1000, 2)
	
#	if Input.is_action_just_pressed("pausebutton"):
#		$Camera2D/PauseMenu.show()
#		$Camera2D/PauseMenu/AudioStreamPlayer.stream_paused = false
#		get_tree().paused = true
			
		
	var railmaxspeed = railmaxspeed_mult * maxspeed
	$Camera2D/CanvasLayer/HBoxContainer2/Time.set_text("%2.2f" % Global.timer.time_left)
	$Camera2D/CanvasLayer/HBoxContainer/Score.set_text("%5.1f" % Global.score)
	
	if Input.is_action_pressed("up"):
		$Exhaust.emitting = true
		acc += jerkup * delta + 10
		acc = min(acc, maxacc)
		
		velocity -= Vector2(velocity.rotated(-rotation).x * sidefriction * delta, 0).rotated(rotation)
	else:
		$Exhaust.emitting = false
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
		if $skate.playing:
			$skate.stop()
		# regular flight
		velocity += delta * Vector2.UP.rotated(rotation) * acc
		velocity = velocity.clamped(maxspeed)
	elif magnet:
		# on rail
#		if velocity.length() > 1400:
#			$SlideShake.shake(0.1)
		if not $skate.playing:
			$skate.play()
		velocity += delta * Vector2.UP.rotated(rotation) * acc
		velocity = velocity.clamped(railmaxspeed)
		if velocity.length() > maxspeed:
			boosted = true
		var idx = AudioServer.get_bus_index("Skate")
		var effect = AudioServer.get_bus_effect(idx, 0)
		effect.set_pitch_scale(velocity.length()/1600 * 0.3 + 1)
		
	else:
		if $skate.playing:
			$skate.stop()
		# boosted, not on rail
		velocity += delta * Vector2.UP.rotated(rotation) * acc
		velocity -= velocity * friction * delta
		velocity = velocity.clamped(oldspeed)
		
	
	if Input.is_action_pressed("down"):
		velocity += delta * Vector2.DOWN.rotated(rotation) * 500
	
	if not magnet:	
		if Input.is_action_pressed("left"):
			rotation -= rotspeed * delta
			
		if Input.is_action_pressed("right"):
			rotation += rotspeed * delta
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		lastnormal = collision.normal
	
	if not magnet:
		if collision:
			if collision.collider.is_in_group("rails") and magnet:
				velocity = velocity.slide(collision.normal)
			else:
				if not $Collision.playing and velocity.dot(lastnormal) < -400: #nqa
					$Collision.play()
					$CollisionShake.shake(0.2)
				acc = 0
				velocity = velocity.bounce(collision.normal) * 0.3
				
	elif collision:
		var count = 0
		while collision:
			count += 1
			if collision.remainder.length() < 1:
				break
				
			if left_magnet:
				velocity -= Vector2(velocity.rotated(-rotation).x, 0).rotated(rotation)
				rotation = collision.normal.rotated(- PI / 2).angle() + PI / 2
			if right_magnet:
				velocity -= Vector2(velocity.rotated(-rotation).x, 0).rotated(rotation)
				rotation = collision.normal.rotated(PI / 2).angle() + PI / 2
			
			collision = move_and_collide(velocity.normalized() * collision.remainder.length())
		move_and_collide(-300 * lastnormal * delta)
		
#		velocity -= Vector2(velocity.rotated(-rotation).x, 0).rotated(rotation)
		
		
	
	if Input.is_action_pressed("switch"):
		if not is_switching:
			if magnet:
				$launch.play()
				velocity += lastnormal * launchvel
			if not inverted:
				$AnimationPlayer.play("Rotation2")
			else:
				$AnimationPlayer.play("Rotation")
				
			inverted = not inverted


func _on_LeftWing_body_entered(body):
	if body.is_in_group("rails"):
		if body.blue == inverted:
			left_magnet = true
			Global.timer.paused = true


func _on_RightWing_body_entered(body):
	if body.is_in_group("rails"):
		if body.blue != inverted:
			right_magnet = true
			Global.timer.paused = true
		
		
func _on_LeftWing_body_exited(body):
	if body.is_in_group("rails"):
		left_magnet = false
		Global.timer.paused = false
		$skate.stop()


func _on_RightWing_body_exited(body):
	if body.is_in_group("rails"):
		right_magnet = false
		Global.timer.paused = false
		$skate.stop()

