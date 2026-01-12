extends CharacterBody2D

@export var sprint_speed: int = 100 #fortest
@onready var base_speed = 60
@onready var anim = $AnimatedSprite2D
@onready var camera = $Camera2D
@onready var head_text = $HeadText
@onready var hand_socket = $AnimatedSprite2D/HandSocket

@onready var inventory_panel = Hud.get_node("InventoryPanel")
@onready var objective_label_anim = Hud.get_node("ObjectivePanel/MarginContainer/ObjectiveLabel/ObjectiveTextAnimation")
@onready var dialogue_box = Hud.get_node("DialogueBox")
@onready var inventory = Hud.get_node("InventoryPanel")


var sfx = StreamAudio.get_node("Sfx")
var current_tool_instance: Node2D = null

var last_direction = "down"
var current_speed = base_speed
var current_npc: Node = null

const TOOL_SCENES = {
		"Axe": "res://objects/axe_equipped.tscn",
		"Log": "res://objects/log_equipped.tscn",
		"Banana": "res://objects/banana_equipped.tscn",
		"Water": "res://objects/water_equipped.tscn",
		"Chips": "res://objects/chips_equipped.tscn",
}

func _ready() -> void:
	var screen_size = get_viewport_rect().size
	if camera:
		camera.limit_right = screen_size.x
		camera.limit_bottom = screen_size.y
		
	anim.play("idle_down")
		
	if InventoryManager:
		InventoryManager.tool_selected.connect(equip_tool)
	else:
		push_error("InventoryManager Autoload not found!")
		
func _physics_process(_delta: float) -> void:
	get_input_and_animate()
	move_and_slide()
	
func unequip_tool():
	if current_tool_instance != null:
		current_tool_instance.queue_free()
		current_tool_instance = null
		GlobalData.player_data["equipped_tool"] = ""

func equip_tool(tool_name: String):
	if current_tool_instance != null:
		current_tool_instance.queue_free()
		current_tool_instance = null
			
	if TOOL_SCENES.has(tool_name):
		var tool_scene = load(TOOL_SCENES[tool_name])

		if tool_scene:
			current_tool_instance = tool_scene.instantiate()
			hand_socket.add_child(current_tool_instance)
			
func _on_inventory_selection_changed():
	var selected_item = InventoryManager.selected_item_name
	if selected_item != "":
		equip_tool(selected_item)
	else:
		equip_tool("")
# --- Movement and Animation Function ---
func get_input_and_animate():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if Input.is_key_pressed(KEY_SHIFT) and input_direction.length() > 0:
		current_speed = sprint_speed
	else:
		current_speed = base_speed
		
		
	velocity = input_direction * current_speed
		
	if input_direction.length() > 0:
			if abs(input_direction.x) > abs(input_direction.y):
					if input_direction.x < 0:
						dialogue_box.close_dialogue()
						if current_speed == sprint_speed:
							GlobalState.HUNGER_MODE = "run"
						else:
							GlobalState.HUNGER_MODE = "walk"
						anim.play("walk_side")
						anim.flip_h = true
						last_direction = "left"
						if inventory:
							inventory.hide()
						
						if current_tool_instance is Sprite2D:
							current_tool_instance.flip_h = true
							current_tool_instance.position.x = -15
							
					else:
						dialogue_box.close_dialogue()
						if current_speed == sprint_speed:
							GlobalState.HUNGER_MODE = "run"
						else:
							GlobalState.HUNGER_MODE = "walk"
						anim.play("walk_side")
						anim.flip_h = false
						last_direction = "right"
						if inventory:
							inventory.hide()
						
						if current_tool_instance is Sprite2D:
							current_tool_instance.flip_h = true
							current_tool_instance.position.x = 0
			else:
					if input_direction.y < 0:
						dialogue_box.close_dialogue()
						if current_speed == sprint_speed:
							GlobalState.HUNGER_MODE = "run"
						else:
							GlobalState.HUNGER_MODE = "walk"
						anim.play("walk_up")
						last_direction = "up"
						if inventory:
							inventory.hide()
					else:
						dialogue_box.close_dialogue()
						if current_speed == sprint_speed:
							GlobalState.HUNGER_MODE = "run"
						else:
							GlobalState.HUNGER_MODE = "walk"
						anim.play("walk_down")
						last_direction = "down"
						if inventory:
							inventory.hide()
	else:
			match last_direction:
					"up":
						GlobalState.HUNGER_MODE = "idle"
						anim.play("idle_up")
					"down":
						GlobalState.HUNGER_MODE = "idle"
						anim.play("idle_down")
					"left":
						GlobalState.HUNGER_MODE = "idle"
						anim.play("idle_side")
						anim.flip_h = true
					"right":
						GlobalState.HUNGER_MODE = "idle"
						anim.play("idle_side")
						anim.flip_h = false

func _on_interaction_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("cars"):
		sfx.stream = StreamAudio.hit
		sfx.play()
		print("hit : ", sfx.stream)
		
	if body.is_in_group("npcs"):
			current_npc = body
			head_text.show()
			
			var npc_label = body.get_node_or_null("HeadText")
			if is_instance_valid(npc_label):
					npc_label.show()
					npc_label.text = body.name
					
func _on_interaction_zone_body_exited(body: Node2D) -> void:
	sfx.stream = StreamAudio.interact
	
	if body == current_npc:
		current_npc = null
		head_text.hide()
		
		var npc_label = body.get_node_or_null("HeadText")
		if is_instance_valid(npc_label):
			npc_label.hide()

func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("use"):
		#unequip_tool()
	#	-- Show Inventory --
	if event.is_action_pressed("show_inventory"):
		if inventory_panel:
			inventory_panel.visible = not inventory_panel.visible
#	-- Show Objective --
	if event.is_action_pressed("show_objective"):
		if objective_label_anim:
			objective_label_anim.play("show_objective")
#	-- Interact NPC --
	if event.is_action_pressed("interact") and current_npc:
		sfx.stream = StreamAudio.interact
		sfx.play()
		if not IslandNpcInteraction.dialogue_finished.is_connected(self._on_dialogue_finished):
			IslandNpcInteraction.dialogue_finished.connect(self._on_dialogue_finished, CONNECT_ONE_SHOT)
		if current_npc.has_method("get_npc_id"):
			var npc_id = current_npc.get_npc_id()
			IslandNpcInteraction.handle_npc_interaction(npc_id)
		else:
				print("ERROR: NPC %s does not have the required 'get_npc_id' method." % current_npc.name)

func _on_dialogue_finished() -> void:
	set_process_unhandled_input(true)
