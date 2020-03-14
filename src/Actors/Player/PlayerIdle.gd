extends State

func physics_process(parent: KinematicBody2D, _delta: float):
	if not parent.is_on_floor():
		parent.set_state(parent.STATES.FALLING)
	elif Input.is_action_just_pressed("jump"):
		parent.set_state(parent.STATES.JUMPING)
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		parent.set_state(parent.STATES.RUNNING)


func enter(parent: KinematicBody2D):
	parent.velocity = Vector2.ZERO


func exit(_parent: KinematicBody2D):
	pass
