extends RigidBody2D


var go_home = false
var scared = false
var walk_path = Vector2()
var pos

func _ready():
	pos = get_pos()
	set_process(true)

func _process(delta):
	if(go_home):
		if(not scared):
			set_pos(Vector2(get_pos().x-1,get_pos().y))
		else:
			set_pos(Vector2(get_pos().x-4,get_pos().y))
	else:
		if get_pos().distance_to(walk_path):
			var dir = (get_pos() - walk_path).normalized()
			pos += dir * 1
			print(pos)
			set_pos(pos)
	
func go_home(scared = false):
	self.scared = scared
	go_home = true
	global.score += 50

func die():
	global.score += 100
	queue_free()