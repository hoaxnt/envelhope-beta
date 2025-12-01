extends Area2D

@onready var player = get_node("/root/Chapter2/Player")
@onready var hunger_timer : Timer = Hud.get_node("StatsPanel/MarginContainer/Panel/HBoxContainer/VBoxContainer/HBoxContainer/HungerBar/HungerTimer")
@onready var day_timer: Timer = Hud.get_node("DayPanel/DayTimer")

var is_player_near: bool
var bgm : AudioStreamPlayer2D = StreamAudio.get_node("Bgm")
var sfx : AudioStreamPlayer2D = StreamAudio.get_node("Sfx")


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
			GlobalData.save_player2_position(player.global_position)
		Hud.hide()
		
		bgm.stop()
		day_timer.stop()
		hunger_timer.stop()
		
		Transition.transition_to_scene("res://scenes/minigames/city/junk_collector.tscn")
