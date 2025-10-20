extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var camera = $Camera2D
@onready var head_text = $HeadText
@export var base_speed = 100 
@export var sprint_speed = 1000

var last_direction = "down"
var current_speed = base_speed
var current_npc = null

func _ready() -> void:
	var screen_size = get_viewport_rect().size
	camera.limit_right = screen_size.x
	camera.limit_bottom = screen_size.y
	anim.play("idle_down")
func _physics_process(_delta: float) -> void:
	get_input_and_animate()
	move_and_slide()
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

func _on_interaction_zone_body_entered(body):
	if body.name == 'npc_diving':
		current_npc = body.name
		head_text.show()
		
func _on_interaction_zone_body_exited(body):
	if body.name == current_npc:
		current_npc = null
		head_text.hide()

func _unhandled_input(event):
	if event.is_action_pressed("interact") and current_npc:
		print('Interacting with NPC')
