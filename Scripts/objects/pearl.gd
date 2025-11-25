extends Area2D

@onready var pearl_sprite: Sprite2D = $Sprite2D
@onready var spawn_timer: Timer = $SpawnTimer

signal pearl_picked_up

var is_active: bool = true

func _ready() -> void:
	spawn_timer.wait_time = 2.0
	spawn_timer.one_shot = true

	var game_manager = get_parent()
	if game_manager and game_manager.has_method("_on_pearl_collected"):
		if not pearl_picked_up.is_connected(game_manager._on_pearl_collected):
			pearl_picked_up.connect(game_manager._on_pearl_collected)
	else:
		push_error("Pearl could not find the Game Manager or the '_on_pearl_collected' method for scoring.")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and is_active:
		collect_pearl()


func collect_pearl() -> void:
	is_active = false

	emit_signal("pearl_picked_up")

	pearl_sprite.hide()

	set_monitoring(false)
	spawn_timer.start()


func _on_spawn_timer_timeout() -> void:
	is_active = true

	pearl_sprite.show()

	set_monitoring(true)
