extends CanvasLayer

@onready var anim_player = $AnimationPlayer
@onready var color_rect = $ColorRect

signal transition_finished

func _ready() -> void:
	hide()

func transition_to_scene(target_scene_path: String):
	show()

	anim_player.play("fade_to_black")
	await anim_player.animation_finished

	get_tree().current_scene.call_deferred("queue_free")
	get_tree().call_deferred("change_scene_to_file", target_scene_path)

	anim_player.play("fade_from_black")
	await anim_player.animation_finished
	hide()

	emit_signal("transition_finished")
