extends Area2D

@export var tree_hp: int = 5
@onready var chop_button = Hud.get_node("ActionButton")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		chop_button.show()

		if not Hud.action_button_pressed_signal.is_connected(_cut_tree):
			Hud.action_button_pressed_signal.connect(_cut_tree)


func _on_body_exited(body: Node2D) -> void:
		if body.is_in_group("player"):
				chop_button.hide()
				
				if Hud.action_button_pressed_signal.is_connected(_cut_tree):
						Hud.action_button_pressed_signal.disconnect(_cut_tree)

func _cut_tree():
		
		tree_hp -= 1
		print("Tree cut! HP remaining: ", tree_hp)
		
		if tree_hp <= 0:
				print("TREE FELL!")
				queue_free()
