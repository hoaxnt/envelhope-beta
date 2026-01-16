extends CharacterBody2D

@export var npc_id: String = "diver"
@export var axe: Area2D

func get_npc_id() -> String: 
	return npc_id

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		axe.show()
