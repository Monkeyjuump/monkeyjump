extends Node2D

@export var scene_platform : Array = []

@onready var player = $player
@onready var camera = $Camera2D
@onready var score_label = $Camera2D/score
@onready var camera_initial_position = $Camera2D.position.y

@onready var platform_container = $platform_container
@onready var initial_platform_y_position = $platform_container/platform.position.y

var score = 0
var last_platform_is_cloud = false
var last_platform_is_enemy = false


func level_generator(amount):
	for i in (amount):
		var new_type = randi() % 4
		initial_platform_y_position -= randi_range(30, 50)
		var new_platform
		
		if new_type == 0:
			new_platform = scene_platform[0].instantiate() as StaticBody2D
		elif new_type == 1:
			new_platform = scene_platform[1].instantiate() as StaticBody2D
		elif new_type == 2:
			if last_platform_is_enemy == false:
				new_platform = scene_platform[2].instantiate() as Path2D
				last_platform_is_enemy = true
			else :
				new_platform = scene_platform[0].instantiate() as StaticBody2D
				last_platform_is_enemy = false
		elif new_type == 3: 
			if last_platform_is_cloud == false:
				new_platform = scene_platform[3].instantiate() as StaticBody2D
				last_platform_is_cloud = true
			else :
				new_platform = scene_platform[0].instantiate() as StaticBody2D
				last_platform_is_cloud = false
				
		if new_platform != null:
			new_platform.position = Vector2(randi_range(20, 160), initial_platform_y_position)
			platform_container.call_deferred("add_child", new_platform)
			
func _ready():
	randomize()
	level_generator(100)
	

func _physics_process(_delta):
	if  player.position.y < camera.position.y:
		camera.position.y = player.position.y
	print($platform_container.get_child_count())
	score_update()
	
		
func score_update():
	score = int(camera_initial_position - camera.position.y)
	score_label.text = str(score)

func _on_platform_eraser_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://scenes/title_menu.tscn")
		if score > Global.highscore:
			Global.highscore = score 
	elif body.is_in_group("platform"):
		body.queue_free()
		level_generator(20)
	elif body.is_in_group("enemy"):
		body.queue_free()


	
