extends CharacterBody2D

@export var npc_id: String = "harvester"

func get_npc_id() -> String:
	return npc_id


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and GlobalData.config.get("talked_to_rambo") == false:
		InventoryManager.add_item("Log", 5)
		GlobalData.update_config_data("talked_to_rambo", true)
