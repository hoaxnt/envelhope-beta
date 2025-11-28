extends Area2D

@onready var junk_sprite: Sprite2D = $Sprite2D
@onready var spawn_timer: Timer = $SpawnTimer

signal junk_picked_up

var is_active: bool = true

func _ready() -> void:
	spawn_timer.wait_time = 2.0
	spawn_timer.one_shot = true

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and is_active:
		collect_junk()

func collect_junk() -> void:
	is_active = false
	emit_signal("junk_picked_up")
	junk_sprite.hide()
	set_monitoring(false)
	spawn_timer.start()


func _on_spawn_timer_timeout() -> void:
	is_active = true
	junk_sprite.show()
	set_monitoring(true)
