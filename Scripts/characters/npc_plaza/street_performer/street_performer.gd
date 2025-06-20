extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", self._on_body_entered)



func _on_body_entered(player: PhysicsBody2D) -> void:
	print("Hello " + player.name)
	pass # Replace with function body.
