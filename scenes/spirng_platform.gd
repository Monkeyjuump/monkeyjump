extends StaticBody2D

@export var jump_power = 1.5

func response():
	$AnimatedSprite2D.play("default")
	
func _on_animated_sprite_2d_animation_finished():
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.frame = 0
