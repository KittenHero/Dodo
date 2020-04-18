extends State

func physics_process(parent: KinematicBody2D, delta: float):
	var velocity = parent.move_horizontal(delta)
	velocity.y += parent.gravity * delta
	parent.velocity = parent.move_and_slide(velocity, Vector2.UP)
	
	if parent.velocity.y >= 0:
		parent.set_state(parent.STATES.FALLING)
	elif Input.is_action_just_pressed("jump"):
		parent.set_state(parent.STATES.DIVE)

func enter(parent: KinematicBody2D):
	parent.velocity.y = - sqrt(2 * parent.jump_height * parent.gravity)

func exit(_parent: KinematicBody2D):
	pass
