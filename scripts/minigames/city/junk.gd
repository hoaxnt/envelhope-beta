extends Area2D

@onready var spawn_timer: Timer = $SpawnTimer
@onready var junk_sprite: Sprite2D = $Sprite2D
@onready var earnings_label = get_node("/root/JunkDiving/CanvasLayer/EarningsLabel")

var is_active: bool = true

func _ready() -> void:
	spawn_timer.one_shot = true

func collect_junk() -> void:
	is_active = false
	get_parent().earnings += 20
	earnings_label.text = "Junks: %s" % str(get_parent().earnings)
	junk_sprite.hide()
	spawn_timer.start()
	set_deferred("monitoring", false)
	
func _on_spawn_timer_timeout() -> void:
	is_active = true
	junk_sprite.show()
	set_deferred("monitoring", true)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and is_active:
		collect_junk()
