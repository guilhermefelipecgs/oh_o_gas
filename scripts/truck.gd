extends RigidBody2D

export(ColorRamp) var color_ramp

const LEFT = Vector2(-1,-1)
const RIGHT = Vector2(1,-1)
const MAX_THROW = 235.0
const MIN_THROW = 110.0
const MAX_TIME = 1000.0

var force = 0
var canister = preload("res://scenes/canister.tscn")
var left_time_press = 0
var right_time_press = 0
var pressbar_delta_left
var pressbar_delta_right
var pressbar_max_scale
var left_pressbar
var right_pressbar


func _ready():
	left_pressbar = get_parent().get_node("HUD/left_pressbar")
	right_pressbar = get_parent().get_node("HUD/right_pressbar")
	pressbar_max_scale = left_pressbar.get_scale()
	set_process_input(true)
	set_process(true)
	
func _process(delta):
	pressbar_delta_left = 0
	pressbar_delta_right = 0
	if left_time_press > 0:
		pressbar_delta_left = OS.get_ticks_msec() - left_time_press
		if(pressbar_delta_left >= MAX_TIME):
			throw(LEFT, pressbar_delta_left)
	
	if right_time_press > 0:
		pressbar_delta_right = OS.get_ticks_msec() - right_time_press
		if(pressbar_delta_right >= MAX_TIME):
			throw(RIGHT, pressbar_delta_right)

	if pressbar_delta_left:
		left_pressbar.set_scale(Vector2(min(pressbar_delta_left * pressbar_max_scale.x / MAX_TIME, pressbar_max_scale.x), pressbar_max_scale.y))
		left_pressbar.set_modulate(color_ramp.interpolate(min(pressbar_delta_left/MAX_TIME,1)))
	else:
		left_pressbar.set_scale(Vector2(0, pressbar_max_scale.y))
		
	if pressbar_delta_right:
		right_pressbar.set_scale(Vector2(min(pressbar_delta_right * pressbar_max_scale.x / MAX_TIME, pressbar_max_scale.x), pressbar_max_scale.y))
		right_pressbar.set_modulate(color_ramp.interpolate(min(pressbar_delta_right/MAX_TIME,1)))
	else:
		right_pressbar.set_scale(Vector2(0, pressbar_max_scale.y))

var action_index = {}

func _input(event):
	# Touch
	if event.type == InputEvent.SCREEN_TOUCH:
		if event.pressed:
			var action = "ui_right" if event.pos.x/get_pos().x > 1 else "ui_left"
			action_index[event.index] = action
			event.set_as_action(action, true)
		else:
			event.set_as_action(action_index[event.index], false)
#
	# Action
	if event.is_action_pressed("ui_left"):
		left_time_press = OS.get_ticks_msec()
	elif event.is_action_released("ui_left"):
		throw(LEFT, OS.get_ticks_msec() - left_time_press)

	if event.is_action_pressed("ui_right"):
		right_time_press = OS.get_ticks_msec()
	elif event.is_action_released("ui_right"):
		throw(RIGHT, OS.get_ticks_msec() - right_time_press)

func throw(direction, delta_time_press):
	if(direction == LEFT):
		if left_time_press == 0: return
	elif right_time_press == 0: return
	
	var spawn_canister = canister.instance()
	force = min(delta_time_press * (MAX_THROW - MIN_THROW) / MAX_TIME + MIN_THROW, MAX_THROW)
	
	spawn_canister.set_pos(get_pos())
	if(direction == LEFT):
		spawn_canister.set_angular_velocity(5)
		spawn_canister.apply_impulse(Vector2(), LEFT * force)
		left_time_press = 0
	else:
		spawn_canister.set_angular_velocity(-5)
		spawn_canister.apply_impulse(Vector2(), RIGHT * force)
		right_time_press = 0
		
	get_parent().add_child(spawn_canister)
