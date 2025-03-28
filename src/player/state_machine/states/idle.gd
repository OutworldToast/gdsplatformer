extends State
class_name Idle

func enter() -> void:
	player.sprite.play("idle")

func physics_update(_delta) -> void:

	super(_delta)

	if get_direction():
		if Input.is_key_pressed(KEY_SHIFT):
			state_machine.change_state("run")
		else:
			state_machine.change_state("walk")
