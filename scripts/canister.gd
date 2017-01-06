extends RigidBody2D

var move
var local_direction
var do_not_explode_pls = false

func _process(delta):
	if move == null: move = get_pos()

	if(get_pos().x < get_viewport_rect().size.width / 2) :
		local_direction = global.house_direction
	else:
		local_direction = global.house_direction * Vector2(-1, 1)
		
	move += local_direction * global.house_speed
	set_pos(move)

func _on_canister_body_enter( body ):
	if body.get_name() == "human":
		do_not_explode_pls = true
		hide()
		body.go_home()
	elif body.get_name() == "floor" || body.is_in_group("house"):
		if not do_not_explode_pls:
			explode()

func explode():
	set_mode(MODE_STATIC)
	set_rot(0)
	get_node("AnimationPlayer").play("explosion")
	set_process(true)

func destroy():
	hide()

func _on_explosion_radius_body_enter( body ):
	if body.get_name() == "human":
		body.die()
	if body.is_in_group("house"):
		body.destroy()


func _on_VisibilityNotifier2D_exit_screen():
	queue_free()
