extends State

var aerial_tumble;

func physics_process(parent: KinematicBody2D, delta: float):
	var grounded = parent.is_on_floor()
	var velocity = parent.velocity
	velocity.y += parent.gravity * delta
	if grounded and velocity.x != 0:
		velocity.x -= velocity.sign().x * parent.acc_per_frame
	parent.velocity = parent.move_and_slide(velocity, Vector2.UP)
	
	if (
		aerial_tumble and grounded and parent.frame_count < 5
		or not aerial_tumble and parent.frame_count < 5 and Input.is_action_pressed("jump")
		or parent.frame_count > 180
	):
		parent.set_state(parent.STATES.RUNNING)
	elif parent.velocity.length_squared() < parent.acc_per_frame * parent.acc_per_frame * 2:
		parent.set_state(parent.STATES.IDLE)
	

func enter(parent: KinematicBody2D):
	aerial_tumble = not parent.is_on_floor()
	parent.modulate_sprite(Color.blue if aerial_tumble else Color.red)


func exit(parent: KinematicBody2D):
	parent.modulate_sprite(Color.white)
