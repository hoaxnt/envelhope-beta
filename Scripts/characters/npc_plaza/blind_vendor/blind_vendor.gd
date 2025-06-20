extends Node

var dialog_box
var is_dialog_visible = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_released("interact"):
		is_dialog_visible = !is_dialog_visible
		dialog_box = get_parent().get_child(6).get_child(0).get_child(1)
		dialog_box.get_child(0).text = "I'm the " + self.name + "."
		dialog_box.visible = not is_dialog_visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
