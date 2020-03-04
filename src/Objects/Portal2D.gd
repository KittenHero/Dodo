tool
extends Area2D


onready var anim_player: AnimationPlayer = $AnimationPlayer


export var next_scene: PackedScene


func _on_body_entered(_body: Node) -> void:
	teleport()


func _get_configuration_warning() -> String:
	return "The next scene property cannot be empty" if not next_scene else ""


func teleport() -> void:
	var initial_pause_mode = pause_mode
	pause_mode = Node.PAUSE_MODE_PROCESS
	get_tree().paused = true
	anim_player.play("FADE_IN")
	# yield waits until node/func mentioned to emit a kind of signal
	yield(anim_player, "animation_finished")
	get_tree().paused = false
	pause_mode = initial_pause_mode
	get_tree().change_scene_to(next_scene)



