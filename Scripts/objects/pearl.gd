extends Area2D

# --- Node References ---
@onready var pearl_sprite: Sprite2D = $Sprite2D 
@onready var spawn_timer: Timer = $SpawnTimer

# --- Signal for Score/Points ---
signal pearl_picked_up

# --- State ---
var is_active: bool = true


func _ready() -> void:
	# Ensure the Timer only runs once per pickup
	spawn_timer.one_shot = true


func _on_body_entered(body: Node2D) -> void:
	# Check if it's the player and the pearl is currently available
	if body.is_in_group("player") and is_active:
		collect_pearl()


func collect_pearl() -> void:
	# 1. Update State
	is_active = false
	
	# 2. Add Points (Notify Game Manager/Player)
	emit_signal("pearl_picked_up")
	
	# 3. Disappear
	pearl_sprite.hide()
	
	# 4. Start Respawn Timer
	monitorable = false # Disable collision detection so the player can't trigger it again
	spawn_timer.start()


func _on_spawn_timer_timeout() -> void:
	# 1. Respawn
	is_active = true
	
	# 2. Reappear
	pearl_sprite.show()
	
	# 3. Re-enable collision
	monitorable = true
