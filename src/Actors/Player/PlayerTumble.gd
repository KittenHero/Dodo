extends State

var aerial;

func physics_process(parent: KinematicBody2D, delta: float):
	var velocity = parent.velocity
	velocity.y += parent.gravity * delta
	if velocity.x != 0:
		velocity.x -= velocity.sign().x * parent.acc_per_frame
	parent.velocity = parent.move_and_slide(velocity, Vector2.UP)
	
	if (
		aerial and parent.is_on_floor() and parent.frame_count < 5
		or not aerial and parent.frame_count < 5 and Input.is_action_pressed("jump")
		or parent.frame_count > 180
	):
		parent.set_state(parent.STATES.RUNNING)
	elif parent.velocity.length_squared() < parent.acc_per_frame * parent.acc_per_frame * 2:
		parent.set_state(parent.STATES.IDLE)
	

func enter(parent: KinematicBody2D):
	aerial = not parent.is_on_floor()


func exit(_parent: KinematicBody2D):
	pass
