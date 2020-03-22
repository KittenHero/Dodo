extends State

# right = 1
var direction = 1
export var FOV = 90

func physics_process(parent: KinematicBody2D, _delta: float):
	var node = get_node("../../LedgeCast")
	if parent.is_on_wall():
		print("Wall detected")
		direction*=-1
		node.position.x*=-1
		
	# Not colliding with the ground for some reason; discover why	
	# if node.is_colliding() == false:
		# print("Ledge detected")
		# direction*=-1
		# node.position.x*=-1
	
	parent.velocity.x += direction*parent.max_speed
	if get_player_detected(parent):
		parent.set_state(parent.STATES.STARTLED)
		
	
func get_player_detected(parent: KinematicBody2D):
	var node = get_node("../../PlayerCast")
	var player = PlayerData.player
	if player == null:
		return false
	# Get distance to player
	var enemyToPlayer = player.position - parent.position
	if enemyToPlayer.length() < parent.detection_range:
		# If distance is within field of view
		# print(rad2deg(acos(enemyToPlayer.normalized().dot(Vector2(direction, 0)))),
		#	"\nDirection: ", direction, "\nenemyToPlayer: ", enemyToPlayer)
		if rad2deg(acos(enemyToPlayer.normalized().dot(Vector2(direction, 0)))) < FOV:
			# Transform raycast to align to player
			node.cast_to = enemyToPlayer
			if node.is_colliding():
				if(node.get_collider() == player):
					return true
				else:
					pass
	return false 
	

func enter(parent: KinematicBody2D):
	pass


func exit(_parent: KinematicBody2D):
	pass

