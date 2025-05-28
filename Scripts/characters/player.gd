extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var player = self
var last_direction = "down" 
var speed = 1 

func _ready() -> void:
	anim.play("walk_right")
	

func _process(delta: float) -> void:
		var moving = false

		# Movement Up
		if Input.is_key_pressed(KEY_W):
				player.position.y -= speed
				anim.play("walk_up")
				last_direction = "up"
				moving = true

		# Movement Down
		elif Input.is_key_pressed(KEY_S):
				player.position.y += speed
				anim.play("walk_down")
				last_direction = "down"
				moving = true

		# Movement Left
		elif Input.is_key_pressed(KEY_A):
				player.position.x -= speed
				anim.play("walk_side")
				anim.flip_h = true
				last_direction = "left"
				moving = true

		# Movement Right
		elif Input.is_key_pressed(KEY_D):
				player.position.x += speed
				anim.play("walk_side")
				anim.flip_h = false
				last_direction = "right"
				moving = true

		# If not moving, play idle animation based on last direction
		if not moving:
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
