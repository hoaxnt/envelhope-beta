extends Area2D

# --- 1. Use Enums for Robust State Management ---
enum State { NO_PEARL, HAS_PEARL }
var current_state: State = State.HAS_PEARL # Start with a pearl for the first pickup

# --- Signals for Decoupled Communication ---
# The parent node (Game Manager/Player) listens to this signal.
signal pearl_picked_up

# --- Class Variables ---
# Cache the player reference instead of a generic boolean
var player_body: CharacterBody2D = null 

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var spawn_timer: Timer = $SpawnTimer


func _ready() -> void:
	# Ensure the timer is set up to run only once when started
	spawn_timer.one_shot = true
	# Set the initial state based on the assumption above
	_set_state(current_state)


func _process(_delta: float) -> void:
	# --- 2. Simplified State Animation and Input Check ---
	# We only need to check input when the item HAS_PEARL and the player is present.
	if current_state == State.HAS_PEARL and player_body != null:
		if Input.is_action_just_pressed("e"):
			# 3. Emit Signal (Decoupled Communication)
			_pick_up_pearl()
			

# --- State Management Function ---
func _set_state(new_state: State) -> void:
	current_state = new_state
	match current_state:
		State.HAS_PEARL:
			animated_sprite.play("pearl")
			# Make the area detectable by the player
			monitorable = true 
			collision_mask = 2 # Assuming your player is on physics layer 2
		State.NO_PEARL:
			animated_sprite.play("no_pearl")
			# Stop interaction and start the timer
			monitorable = false 
			spawn_timer.start()


# --- Interaction Logic (New Signal Method) ---

func _pick_up_pearl() -> void:
	# 4. Notify the game/player that the item was picked up
	emit_signal("pearl_picked_up")
	
	# Transition to the NO_PEARL state
	_set_state(State.NO_PEARL)


# --- Area Signals (Better than checking body.has_method) ---

func _on_body_entered(body: Node2D) -> void:
	# Check for a specific player group or class name for reliability
	if body.is_in_group("player"): 
		player_body = body as CharacterBody2D


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_body = null


# --- Timer Signal ---

func _on_spawn_timer_timeout() -> void:
	# When the timer runs out, the pearl respawns
	_set_state(State.HAS_PEARL)
