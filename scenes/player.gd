extends CharacterBody2D



var gravity = 7
var jump_force = 400
var speed = 100
var velocityy = Vector2.ZERO


func movement(_delta):
	velocityy.y += gravity
	var collision = move_and_collide(velocityy * _delta)
	if collision:
		velocityy.y = -jump_force * collision.get_collider().jump_power
		if collision.get_collider().has_method("response"):
			collision.get_collider().response()
			 
	if velocityy.y > 0:
		$AnimatedSprite2D.play("fall")
	else:
		$AnimatedSprite2D.play("default") 
		
	
	var dir = 0
	if Input.is_action_pressed("ui_right"):
		dir += 1 
		$AnimatedSprite2D.flip_h = true
	elif Input.is_action_pressed("ui_left"):
		dir -= 1 
		$AnimatedSprite2D.flip_h = false
		
	if dir != 0:
		velocityy.x = dir * speed
	else:
		velocityy.x = 0 
		
	if position.x < 0 :
		position.x = get_viewport_rect().size.x
	elif position.x > get_viewport_rect().size.x:
		position.x = 0

func die():
	velocityy = Vector2.ZERO
	set_collision_mask_value(1, false)


func _physics_process(_delta):
	movement(_delta)


