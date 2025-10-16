extends Area2D

var dialog_box
var is_dialog_visible = false
var is_player_collided = false

func _ready() -> void:
	connect("body_entered", self._on_body_entered)
	
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if event.is_action_released("interact"):
		is_dialog_visible = !is_dialog_visible
		dialog_box = get_parent().get_child(6).get_child(0).get_child(1)
		dialog_box.get_child(0).text = "I'm the " + self.name + "."
		dialog_box.visible = not is_dialog_visible

func _on_body_entered(player: PhysicsBody2D) -> void:
	#if player.name == "Player":
		#while player:
			#is_player_collided = true
	pass # Replace with function body.
