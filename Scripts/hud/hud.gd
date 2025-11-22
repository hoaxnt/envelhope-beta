extends CanvasLayer

@onready var obj = Hud.get_node("Control5/MarginContainer/ObjectiveLabel/ObjectiveTextAnimation")
@onready var inventory_panel = Hud.get_node("Control4")

func _ready() -> void:
	inventory_panel.hide()
	hide()
	
func _on_bag_button_pressed() -> void:
	inventory_panel.visible = not inventory_panel.visible

func _on_view_quest_button_pressed() -> void:
	obj.play("show_objective")
