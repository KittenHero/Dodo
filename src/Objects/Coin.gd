extends Area2D


export var score: = 100
onready var anim_player: AnimationPlayer = $AnimationPlayer


func _on_body_entered(_body: Node) -> void:
	picked()
	

func picked() -> void:
	PlayerData.score += score
	anim_player.play("Fading")
