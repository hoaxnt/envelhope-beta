extends Area2D


@export var tree_max_hp: int = 5
@export var respawn_time: float = 10.0 #fortest
@export var log_scene: PackedScene = preload("res://objects/log.tscn") 
@onready var sfx = StreamAudio.get_node("Sfx")

var tree_hp: int
var is_felled: bool = false
var original_sprite_texture: Texture2D

@onready var sprite_visuals = $Sprite2D 
@onready var tree_collider = $CollisionShape2D 
@onready var respawn_timer = $RespawnTimer 

@onready var chop_button : Button = Hud.get_node("ActionButton")
@onready var axe_anim = AxeEquipped.get_node("AnimationPlayer")
@onready var objective_label : Label = Hud.get_node("ObjectivePanel/MarginContainer/ObjectiveLabel")

func _ready() -> void:
		tree_hp = tree_max_hp
		original_sprite_texture = sprite_visuals.texture
		respawn_timer.timeout.connect(_regrow) 


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		chop_button.text = "Chop [C]"
		chop_button.show()

		if not Hud.action_button_pressed_signal.is_connected(_cut_tree):
			Hud.action_button_pressed_signal.connect(_cut_tree)


func _on_body_exited(body: Node2D) -> void:
		if body.is_in_group("player"):
				chop_button.hide()
				
				if Hud.action_button_pressed_signal.is_connected(_cut_tree):
						Hud.action_button_pressed_signal.disconnect(_cut_tree)

func _cut_tree():
		var anim = get_parent().get_node("Player/AnimatedSprite2D/HandSocket/AxeEquipped/AnimationPlayer")
		if anim:
			anim.play("slash")
		
		if not InventoryManager.is_axe_selected():
			#if objective_label:
				#objective_label.text = "Need an axe to chop!"
				#objective_label.show()
				
			print("Need an axe to chop!")
			return
		
		axe_anim.play("slash")
		tree_hp -= 1
		print("Tree cut! HP remaining: ", tree_hp)
		
		if tree_hp <= 0 and not is_felled:
				_fell_tree()
				
func _fell_tree():
		is_felled = true
		chop_button.hide()
		
		_drop_log_item()
		
	
		sprite_visuals.texture = null 
		tree_collider.disabled = true
		

		respawn_timer.start(respawn_time)
		

		if Hud.action_button_pressed_signal.is_connected(_cut_tree):
				Hud.action_button_pressed_signal.disconnect(_cut_tree)
				
		print("Tree felled. Respawning in %s seconds." % respawn_time)


func _drop_log_item():
	sfx.stream = StreamAudio.drop
	sfx.play()
	var log_instance = log_scene.instantiate()
	

	get_tree().root.add_child(log_instance)
	log_instance.global_position = global_position
	
	print("Dropped Log item.")


func _regrow():
		tree_hp = tree_max_hp
		is_felled = false
		
		sprite_visuals.texture = original_sprite_texture
		tree_collider.disabled = false
		
		print("Tree regrown and ready to chop!")
		
