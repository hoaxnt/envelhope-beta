extends Area2D

var current_body: String
@export var dialogue_box: CanvasLayer

func _ready() -> void:
	get_child(2).hide()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_child(2).show()
		current_body = "player"

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_child(2).hide()
		current_body = ""

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and current_body == "player":
		var name_label : Label = dialogue_box.get_child(0).get_child(0).get_child(0).get_child(0)
		var message_label : Label = dialogue_box.get_child(0).get_child(0).get_child(0).get_child(1)
		if dialogue_box:
			name_label.text = name
			message_label.text = "Ohh Trece! Trece!"
			dialogue_box.show()
