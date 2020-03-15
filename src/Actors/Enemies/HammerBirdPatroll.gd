extends State

var direction = 1
export var FOV = 90

func physics_process(parent: KinematicBody2D, _delta: float):
	var node = get_node("../../LedgeCast")
	if parent.is_on_wall():
		direction*=-1
		node.position.x*=-1
		
	if node.is_colliding() == false:
		direction*=-1
		node.position.x*=-1
	
	parent.velocity.x += direction*parent.max_speed
	if get_player_detected(parent):
		parent.set_state(parent.STARTLED)
		
	
func get_player_detected(parent: KinematicBody2D):
	var node = get_node("../../PlayerCast")
	# Find better way to reference
	var player = PlayerData.player
	# Get distance to player
	var EnemyToPlayer = player.translation - parent.translation
	if EnemyToPlayer.length() < parent.detection_range:
		# If distance is within field of view
		if acos(EnemyToPlayer.normalized().dot(direction)) < FOV:
			# Transform raycast to align to player
			node.cast_to = EnemyToPlayer
			if node.is_colliding():
				if(node.get_collider() == $Player):
					return true
	return false 
	
	

func enter(parent: KinematicBody2D):
	pass


func exit(_parent: KinematicBody2D):
	pass

