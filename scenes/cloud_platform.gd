extends StaticBody2D

@export var jump_power = 1

var time = 1 

func _ready():
	set_process(false)

func _on_area_2d_body_entered(body):
	if body.name == 'player':
		set_process(true)
		$Timer.start(1.0)

func _process(_delta):
	time += 1
	$Sprite2D.position += Vector2(0, sin(time) * 1)

func _on_timer_timeout():
	queue_free()
