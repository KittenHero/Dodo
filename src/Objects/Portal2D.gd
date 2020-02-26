tool
extends Area2D


onready var anim_player: AnimationPlayer = $AnimationPlayer


export var next_scene: PackedScene


func _on_body_entered(_body: Node) -> void:
	teleport()


func _get_configuration_warning() -> String:
	return "The next scene property cannot be empty" if not next_scene else ""


func teleport() -> void:
	anim_player.play("FADE_IN")
	# yield waits until node/func mentioned to emit a kind of signal
	yield(anim_player, "animation_finished")
	get_tree().change_scene_to(next_scene)



