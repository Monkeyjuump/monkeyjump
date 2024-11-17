extends Control

@onready var highscore_label = $main_container/highscore
@onready var start_button = $main_container/menu/start
func _ready():
	start_button.grab_focus()
	highscore_label.text = "highscore\n" + str(Global.highscore)

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/doodle_jump.tscn")


func _on_exit_pressed():
	get_tree().quit()
