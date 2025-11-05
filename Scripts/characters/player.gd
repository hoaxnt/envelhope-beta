extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var camera = $Camera2D
@onready var head_text = $HeadText # Assumes this is a UI prompt like "Press E"
@export var base_speed = 100
@export var sprint_speed = 1000

var last_direction = "down"
var current_speed = base_speed
var current_npc: Node = null # Type hint for clarity

func _ready() -> void:
		# Assuming the camera is meant to stay within the scene bounds
		var screen_size = get_viewport_rect().size
		camera.limit_right = screen_size.x
		camera.limit_bottom = screen_size.y
		anim.play("idle_down")

func _physics_process(_delta: float) -> void:
		get_input_and_animate()
		move_and_slide()

# --- Movement and Animation Function ---
func get_input_and_animate():
		var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

		if Input.is_key_pressed(KEY_SHIFT):
				current_speed = sprint_speed
		else:
				current_speed = base_speed
		velocity = input_direction * current_speed
				
		if input_direction.length() > 0:
				if abs(input_direction.x) > abs(input_direction.y):
						if input_direction.x < 0:
								anim.play("walk_side")
								anim.flip_h = true
								last_direction = "left"
						else:
								anim.play("walk_side")
								anim.flip_h = false
								last_direction = "right"
				else:
						if input_direction.y < 0:
								anim.play("walk_up")
								last_direction = "up"
						else:
								anim.play("walk_down")
								last_direction = "down"
		else:
				match last_direction:
						"up":
								anim.play("idle_up")
						"down":
								anim.play("idle_down")
						"left":
								anim.play("idle_side")
								anim.flip_h = true
						"right":
								anim.play("idle_side")
								anim.flip_h = false

# --- Interaction Zone Signal Handlers ---

func _on_interaction_zone_body_entered(body: Node2D) -> void:
		if body.is_in_group("npcs"):
				current_npc = body
				head_text.show()
				
				# Display the NPC's name above its head (if it has the node)
				var npc_label = body.get_node_or_null("HeadText")
				if is_instance_valid(npc_label):
						npc_label.show()
						npc_label.text = body.name
		
func _on_interaction_zone_body_exited(body: Node2D) -> void:
		if body == current_npc:
				current_npc = null
				head_text.hide() # Hide player's prompt
				
				# Hide the NPC's name label
				var npc_label = body.get_node_or_null("HeadText")
				if is_instance_valid(npc_label):
						npc_label.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and current_npc:
	
			if not IslandNpcInteraction.dialogue_finished.is_connected(self._on_dialogue_finished):
				IslandNpcInteraction.dialogue_finished.connect(self._on_dialogue_finished, CONNECT_ONE_SHOT)
			
			if current_npc.has_method("get_npc_id"):
				var npc_id = current_npc.get_npc_id()
				IslandNpcInteraction.handle_npc_interaction(npc_id)
					
			else:
					print("ERROR: NPC %s does not have the required 'get_npc_id' method." % current_npc.name)

func _on_dialogue_finished() -> void:
		set_process_unhandled_input(true)
		print("Player input resumed.")
