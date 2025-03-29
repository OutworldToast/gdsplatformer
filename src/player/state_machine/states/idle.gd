extends State
class_name Idle

func enter() -> void:
	player.sprite.play("idle")

func physics_update(_delta) -> void:

	super(_delta)

	if get_input_direction():
		if Input.is_action_pressed("run"):
			state_machine.change_state("run")
		else:
			state_machine.change_state("walk")

	if Input.is_action_just_pressed("jump"):
		player.jump(false)
		state_machine.change_state("jump")
