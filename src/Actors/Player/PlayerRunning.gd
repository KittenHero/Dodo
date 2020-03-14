extends State

func physics_process(parent: KinematicBody2D, delta: float):
	var move_input: bool;
	var velocity = parent.velocity
	if Input.is_action_pressed("move_left"):
		velocity.x -= parent.acc_per_frame;
		move_input = true;
	elif Input.is_action_pressed("move_right"):
		velocity.x += parent.acc_per_frame;
		move_input = true;
	else:
		velocity.x -= velocity.sign().x * parent.acc_per_frame;
		move_input = false;
	
	if velocity.x > parent.max_speed:
		velocity.x = parent.max_speed
	parent.velocity = parent.move_and_slide_with_snap(
		velocity, Vector2(0, 2 * velocity.abs().x * delta), Vector2.UP
	)
	
	if not parent.is_on_floor():
		parent.set_state(parent.STATES.FALLING)
	elif Input.is_action_just_pressed("jump"):
		parent.set_state(parent.STATES.JUMPING)
	elif parent.velocity.length_squared() < parent.acc_per_frame and not move_input:
		parent.set_state(parent.STATES.IDLE)


func enter(_parent: KinematicBody2D):
	pass


func exit(_parent: KinematicBody2D):
	pass
