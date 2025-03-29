extends State
class_name Idle

func enter() -> void:
	player.sprite.play("idle")

func physics_update(_delta) -> void:

	super(_delta)

	if get_input_direction():
		if Input.is_action_pressed("run"):
			request_state.emit("run")
		else:
			request_state.emit("walk")

	if Input.is_action_just_pressed("jump"):
		player.jump(false)
		request_state.emit("jump")
