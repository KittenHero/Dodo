extends State

func physics_process(parent: KinematicBody2D, delta: float):
	parent.velocity.y += parent.gravity * delta
	parent.velocity = parent.move_and_slide(parent.velocity, Vector2.UP)
	
	if parent.is_on_floor():
		parent.set_state(parent.STATES.CHASING)
	
func enter(parent: KinematicBody2D):
	pass
	
func exit(parent: KinematicBody2D):
	pass
