extends "res://src/Actors/Actor.gd"


export var score: = 100


func _ready() -> void:
	set_physics_process(false)
	_velocity.x = _speed.x
	
	
func _on_StompDetector_area_entered(area: Area2D) -> void:
	
	# if PlayerData.player.current_state.name == 'DIVE':
		# $CollisionShape2D.set_deferred("disabled", true)
		# die()
	
	if area.global_position.y > get_node("StompDetector").global_position.y:
		return
	
	if area.get_name() == 'EnemySensor':
		return
	
	$CollisionShape2D.set_deferred("disabled", true)
	die()
	
# func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	# if body.global_position.y > get_node("StompDetector").global_position.y:
		# return
	# if body.motion.y > 0 and body.is_on_floor() == false:
		# $CollisionShape2D.set_deferred("disabled", true)
		# die()
	# Godot waits till its safe to disable
	# $CollisionShape2D.set_deferred("disabled", true)
	# die()


func _physics_process(delta: float) -> void:
	_velocity.y += _gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y


func die() -> void:
	queue_free()
	PlayerData.score += score


func _on_EnemySensor_body_entered(_body: Node) -> void:
	_velocity.x *= -1.0



