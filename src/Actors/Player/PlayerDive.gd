extends State

func physics_process(parent: KinematicBody2D, delta: float):
	parent.velocity.y += parent.gravity * delta
	parent.velocity = parent.move_and_slide(parent.velocity, Vector2.UP)

	if parent.is_on_floor():
		parent.set_state(parent.STATES.TUMBLE)


func enter(parent: KinematicBody2D):
	parent.velocity = Vector2(
		parent.velocity.sign().x * parent.max_speed * parent.dive_multiplier.x,
		-sqrt(2 * parent.jump_height * parent.gravity * parent.dive_multiplier.y)
	)


func exit(_parent: KinematicBody2D):
	pass
