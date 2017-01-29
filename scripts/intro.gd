extends Node



func _on_Button_pressed():
	get_tree().set_pause(false)
	get_parent().get_node("music").set_paused(false)
	queue_free()