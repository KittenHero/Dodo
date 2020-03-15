extends KinematicBody2D
class_name HammerBird

export var windup = 10
export var max_speed = 300
export var jump_height = 200
export var gravity = 3000
export var detection_range = 600
export var stagger = 50
export var life = 2

var velocity = Vector2.ZERO
var animation_playthrough = 3
var frame_count = 0

enum STATES {
	PATROLL,
	WINDUP,
	SLAM,
	STARTLED,
	FALLING,
	STAGGER,
	CHASING
}

onready var state_dict = {
	STATES.PATROLL: $States/Patroll,
	STATES.WINDUP: $States/Windup,
	STATES.SLAM: $States/Slam,
	STATES.STARTLED: $States/Startled,
	STATES.STAGGER: $States/Stagger,
	STATES.FALLING: $States/Falling,
	STATES.CHASING: $States/Chasing
}
onready var current_state = $States/Patroll
var previous_state: Node;

func _physics_process(delta: float) -> void:
	frame_count += 1
	current_state.physics_process(self, delta)
	
func set_state(state) -> void:
	frame_count = 0
	current_state.exit(self)
	previous_state = current_state
	current_state = state_dict[state]
	current_state.enter(self)

func _ready():
	$PlayerCast.add_exception($BlobCollision)
	$PlayerCast.add_exception($HammerSlap/HammerCollision)


