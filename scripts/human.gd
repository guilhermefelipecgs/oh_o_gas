extends RigidBody2D

func _on_human_body_enter( body ):
	
	if body.get_name() == "human":
		return
