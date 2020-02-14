extends KinematicBody
 
const JUMP_FORCE = 5
const GRAVITY = 9.8
const MAX_FALL_SPEED = 30
const MOVE_SPEED = 5
const UP = Vector3(0,1,0)
var vy = 0
var facing_right = false
 
onready var anim_player = $Model/AnimationPlayer
 
func _physics_process(delta):
	var dx
	if Input.is_action_pressed("move_right"):
		dx = 1
	elif Input.is_action_pressed("move_left"):
		dx = -1
	else:
		dx = 0
   
# warning-ignore:return_value_discarded
	move_and_slide(Vector3(dx * MOVE_SPEED, vy, 0), UP)
	vy -= GRAVITY * delta
	if vy < -MAX_FALL_SPEED:
		vy = -MAX_FALL_SPEED
	if is_on_floor():
		vy = -0.1
		if Input.is_action_pressed("jump"):
			vy = JUMP_FORCE
   
	if dx < 0 and facing_right:
		flip()
	if dx > 0 and !facing_right:
		flip()
 
func flip():
	$Model.rotation_degrees.y *= -1
	facing_right = !facing_right
