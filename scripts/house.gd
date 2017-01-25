extends RigidBody2D

var last_pos
var new_pos
var target = Vector2()
var damage_message = preload("res://scenes/damage_message.tscn")
var destroyed = false

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var pos = get_pos()
	pos -= (pos - target).normalized() * global.house_speed
	set_pos(pos)

func _on_VisibilityNotifier2D_exit_screen():
	queue_free()

func destroy():
	if not destroyed:
		var dm = damage_message.instance()
		dm.get_node("Label").set_text("+50")
		get_tree().get_root().add_child(dm)
		dm.get_node("Label").set_pos(get_node("message_position").get_global_pos() - Vector2(dm.get_node("Label").get_size().x/2, dm.get_node("Label").get_size().y/2))
		
		global.score += 50
		get_node("Sprite").set_frame(2)
		destroyed = true
		