extends Path2D

@export var loop = true
@export var speed = 1.0
@export var speed_scale = 1.0

@onready var path = $PathFollow2D
@onready var animation = $AnimationPlayer



func _ready():
	if loop:
		animation.play("move")
		$AnimatableBody2D/AnimatedSprite2D.play("default")
		set_process(false)
	
func _process(_delta):
	path.progress += speed
	

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		body.die()
