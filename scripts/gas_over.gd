extends Node

func _on_yes_pressed():
	get_tree().reload_current_scene();
	get_tree().set_pause(false)
