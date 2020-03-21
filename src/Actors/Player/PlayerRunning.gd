extends State

func physics_process(parent: KinematicBody2D, delta: float):
	var velocity = parent.move_horizontal(delta)
	parent.velocity = parent.move_and_slide_with_snap(
		velocity, Vector2(0, 2 * velocity.abs().x * delta), Vector2.UP
	)
	
	if not parent.is_on_floor():
		parent.set_state(parent.STATES.FALLING)
	elif Input.is_action_just_pressed("jump"):
		parent.set_state(parent.STATES.JUMPING)
	elif parent.velocity.length_squared() < parent.acc_per_frame:
		parent.set_state(parent.STATES.IDLE)


func enter(_parent: KinematicBody2D):
	pass


func exit(_parent: KinematicBody2D):
	pass
