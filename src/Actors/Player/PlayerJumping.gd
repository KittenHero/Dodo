extends State

func physics_process(parent: KinematicBody2D, delta: float):
	var velocity = parent.move_horizontal(delta)
	velocity.y += parent.gravity * delta
	var collision = parent.move_and_collide(velocity * delta)
	
	if velocity.y >= 0 or collision:
		parent.set_state(parent.STATES.FALLING)
	elif Input.is_action_just_pressed("jump"):
		parent.set_state(parent.STATES.DIVE)
	elif parent.is_on_floor():
		parent.set_state(parent.STATES.RUNNING)


func enter(parent: KinematicBody2D):
	parent.velocity.y = - sqrt(2 * parent.jump_height * parent.gravity)


func exit(_parent: KinematicBody2D):
	pass
