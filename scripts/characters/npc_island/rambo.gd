extends CharacterBody2D

@export var npc_id: String = "rambo"

func get_npc_id() -> String:
	return npc_id

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Current logs: ", GlobalData.inventory.get("Log"))
	if body.is_in_group("player") and GlobalData.config.get("talked_to_rambo") == false:
		InventoryManager.add_item("Log", 5)
		GlobalData.update_config_data("talked_to_rambo", true)
