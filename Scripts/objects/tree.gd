#extends Area2D
#
#@export var tree_hp: int = 5
#@onready var chop_button = Hud.get_node("ActionButton")
#
#func _on_body_entered(body: Node2D) -> void:
	#if body.is_in_group("player"):
		#chop_button.show()
#
		#if not Hud.action_button_pressed_signal.is_connected(_cut_tree):
			#Hud.action_button_pressed_signal.connect(_cut_tree)
#
#
#func _on_body_exited(body: Node2D) -> void:
		#if body.is_in_group("player"):
				#chop_button.hide()
				#
				#if Hud.action_button_pressed_signal.is_connected(_cut_tree):
						#Hud.action_button_pressed_signal.disconnect(_cut_tree)
#
#func _cut_tree():
		#
		#tree_hp -= 1
		#print("Tree cut! HP remaining: ", tree_hp)
		#
		#if tree_hp <= 0:
				#print("TREE FELL!")
				#queue_free()

# Tree Script (The Area2D)
extends Area2D

# --- Configuration ---
@export var tree_max_hp: int = 5
@export var respawn_time: float = 10.0 # Tree regrows after 10 seconds
@export var log_scene: PackedScene = preload("res://objects/log.tscn") # 🚨 Set this path!

var tree_hp: int
var is_felled: bool = false
var original_sprite_texture: Texture2D # Store the original healthy texture

@onready var sprite_visuals = $Sprite2D # Assuming you have a Sprite2D child
@onready var tree_collider = $CollisionShape2D # Assuming you have a collider child
@onready var respawn_timer = $RespawnTimer # 🚨 Add a Timer node as a child and name it "RespawnTimer"

@onready var chop_button = Hud.get_node("ActionButton")

func _ready() -> void:
		tree_hp = tree_max_hp
		original_sprite_texture = sprite_visuals.texture
		# Ensure the Timer connects to the function that makes the tree reappear
		respawn_timer.timeout.connect(_regrow) 

# ... (Existing _on_body_entered and _on_body_exited functions remain the same) ...

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		chop_button.show()

		if not Hud.action_button_pressed_signal.is_connected(_cut_tree):
			Hud.action_button_pressed_signal.connect(_cut_tree)


func _on_body_exited(body: Node2D) -> void:
		if body.is_in_group("player"):
				chop_button.hide()
				
				if Hud.action_button_pressed_signal.is_connected(_cut_tree):
						Hud.action_button_pressed_signal.disconnect(_cut_tree)

# 🔪 The cutting logic function called by the HUD signal
func _cut_tree():
		# 1. Add Inventory/Equip Check (Recommended)
		if not InventoryManager.is_axe_selected():
				print("Need an axe to chop!")
				return
				
		# 2. Reduce health
		tree_hp -= 1
		print("Tree cut! HP remaining: ", tree_hp)
		
		# 3. Check for felling
		if tree_hp <= 0 and not is_felled:
				_fell_tree()

## --- New Functionality ---

func _fell_tree():
		is_felled = true
		chop_button.hide()
		
		# 1. Drop the Log item
		_drop_log_item()
		
		# 2. Hide visuals and collision for respawn
		sprite_visuals.texture = null # Set to a stump texture or hide it entirely
		tree_collider.disabled = true
		
		# 3. Start the respawn timer
		respawn_timer.start(respawn_time)
		
		# 4. Disconnect the chopping signal to prevent errors while the tree is gone
		if Hud.action_button_pressed_signal.is_connected(_cut_tree):
				Hud.action_button_pressed_signal.disconnect(_cut_tree)
				
		print("Tree felled. Respawning in %s seconds." % respawn_time)


func _drop_log_item():
		# Instantiate the Log pickup scene
		var log_instance = log_scene.instantiate()
		
		# Place the log item at the tree's position
		get_tree().root.add_child(log_instance)
		log_instance.global_position = global_position
		
		# Note: The Log_Pickup.tscn needs a pickup.gd script similar to the axe, 
		# but it will call InventoryManager.add_item("Log")
		print("Dropped Log item.")


func _regrow():
		# This runs when the timer finishes
		
		# 1. Reset state
		tree_hp = tree_max_hp
		is_felled = false
		
		# 2. Restore visuals and collision
		sprite_visuals.texture = original_sprite_texture
		tree_collider.disabled = false
		
		print("Tree regrown and ready to chop!")
		
		# NOTE: The chopping signal will be reconnected the next time the player enters the area.
