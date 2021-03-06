extends KinematicBody2D
class_name Player

export var gravity = 3000
export var max_speed = 1000
export var time_to_max_speed = 20
onready var acc_per_frame = max_speed / time_to_max_speed
export var jump_height = 300
export var dive_multiplier = Vector2(2, 0.5)
export var tech_frames = 5

var frame_count = 0

var velocity = Vector2.ZERO

enum STATES {
	IDLE,
	RUNNING,
	JUMPING,
	FALLING,
	DIVE,
	TUMBLE,
}
onready var state_dict = {
	STATES.IDLE: $States/Idle,
	STATES.RUNNING: $States/Running,
	STATES.JUMPING: $States/Jumping,
	STATES.FALLING: $States/Falling,
	STATES.DIVE: $States/Dive,
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

func move_horizontal(_delta: float) -> Vector2:
	if Input.is_action_pressed("move_left"):
		velocity.x -= acc_per_frame
	elif Input.is_action_pressed("move_right"):
		velocity.x += acc_per_frame
	elif is_on_floor():
		velocity.x -= sign(velocity.x) * acc_per_frame
	if abs(velocity.x) > max_speed:
		velocity.x = max_speed * sign(velocity.x)
	return velocity

func modulate_sprite(color: Color) -> void:
	$player.modulate = color

func _on_EnemyDetector_area_entered(area: Area2D):
	if area.get_name() == 'StompDetector':
		set_state(STATES.JUMPING)
	
	if area.get_name() == 'DANGER':
		PlayerData.deaths += 1
		queue_free()

func _on_EnemyDetector_body_entered(_body: Node):
	PlayerData.deaths += 1
	queue_free()
