extends RigidBody2D

func _on_canister_body_enter( body ):
	if body.get_name() == "floor":
		set_mode(MODE_STATIC)
		set_rot(0)
		get_node("AnimationPlayer").play("explosion")

func destroy():
	queue_free()