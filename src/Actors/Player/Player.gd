extends KinematicBody2D
class_name Player

export var gravity = 3000
export var max_speed = 500
export var time_to_max_speed = 20
onready var acc_per_frame = max_speed / time_to_max_speed
export var jump_height = 500
var frame_count = 0

var velocity = Vector2.ZERO

enum STATES {
	IDLE,
	RUNNING,
	JUMPING,
	FALLING,
	TUMBLE,
}
onready var state_dict = {
	STATES.IDLE: $States/Idle,
	STATES.RUNNING: $States/Running,
	STATES.JUMPING: $States/Jumping,
	STATES.FALLING: $States/Falling,
	STATES.TUMBLE: $States/Tumble,
}
onready var current_state = $States/Idle
var previous_state: Node;

func _physics_process(delta: float) -> void:
	PlayerData.set("player", self)
	frame_count += 1
	current_state.physics_process(self, delta)

func set_state(state) -> void:
	frame_count = 0
	current_state.exit(self)
	previous_state = current_state
	current_state = state_dict[state]
	current_state.enter(self)

func _on_EnemyDetector_area_entered(_area: Area2D):
	set_state(STATES.JUMPING)
	
func _on_EnemyDetector_body_entered(_body: Node):
	PlayerData.deaths += 1
	queue_free()
