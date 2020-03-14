extends State

var can_jump;

func physics_process(parent: KinematicBody2D, delta: float):
	parent.velocity.y += parent.gravity * delta
	parent.velocity = parent.move_and_slide(parent.velocity, Vector2.UP)
	
	if parent.is_on_floor():
		parent.set_state(parent.STATES.TUMBLE)
	elif Input.is_action_just_pressed("jump"):
		if parent.frame_count < 5:
			parent.set_state(parent.STATES.JUMPING)
		else:
			parent.set_state(parent.STATES.TUMBLE)


func enter(parent: KinematicBody2D):
	can_jump = (
		parent.previous_state != parent.state_dict[parent.STATES.JUMPING]
		and parent.previous_state != parent.state_dict[parent.STATES.TUMBLE]
	)


func exit(_parent: KinematicBody2D):
	pass
