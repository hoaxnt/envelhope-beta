extends Area2D

@onready var player = get_node("/root/Chapter2/Player")
var is_player_near: bool

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_near = true
		$Label.show()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_near = false
		$Label.hide()
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_player_near:
		if player:
			GlobalData.save_player_position(player.global_position)
			print(player.global_position)
		Hud.hide()
		Transition.transition_to_scene("res://scenes/minigames/city/junk_collector.tscn")
