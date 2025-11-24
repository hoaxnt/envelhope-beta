extends Area2D

var is_body_near: bool = false
@onready var collision = $CollisionShape2D

func _ready() -> void:
	#collision.hide()
	hide()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_body_near = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_body_near = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_body_near:
		print("WEWEW")
