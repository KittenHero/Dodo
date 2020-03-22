extends State


func physics_process(parent: KinematicBody2D, delta: float):
	var velocity = parent.velocity
	velocity.y += parent.gravity * delta
	if velocity.x != 0:
		velocity.x -= velocity.sign().x * parent.acc_per_frame
	parent.velocity = parent.move_and_slide(velocity, Vector2.UP)
	
	if (
		parent.frame_count < parent.tech_frames and Input.is_action_pressed("jump")
		or parent.frame_count > 180
	):
		parent.set_state(parent.STATES.RUNNING)
	elif parent.velocity.length_squared() < parent.acc_per_frame * parent.acc_per_frame * 2:
		parent.set_state(parent.STATES.IDLE)


func enter(parent: KinematicBody2D):
	parent.modulate_sprite(Color.red)


func exit(parent: KinematicBody2D):
	parent.modulate_sprite(Color.white)
