extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_canister_body_enter( body ):
	if body.get_name() == "floor":
		set_mode(MODE_STATIC)
		set_rot(0)
		get_node("AnimationPlayer").play("explosion")

func destroy():
	queue_free()