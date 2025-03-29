extends Airborne
class_name Cling

var buffered_direction: float

func enter() -> void:
	player.sprite.play("cling")
	player.detach_buffer_timer.timeout.connect(_on_detach_buffer_timer_timeout)

func exit() -> void:
	player.detach_buffer_timer.timeout.disconnect(_on_detach_buffer_timer_timeout)

func get_wall_direction() -> float:
	return player.get_wall_normal().x

func check_detach() -> void:
	var direction := get_input_direction()
	# checks if direction away from wall is held
	if direction and sign(direction) == sign(get_wall_direction()):
		# start detach timer if one is not going
		if player.detach_buffer_timer.is_stopped():
			player.detach_buffer_timer.start()
			buffered_direction = direction
	else:
		# stops timer if no direction is held or direction is facing wall
		player.detach_buffer_timer.stop()

func flip(direction: float) -> void:

	var steering: float = (sign(get_input_direction()) != 0)
	var countersteering: float = (sign(direction) == sign(get_input_direction()))
	var holding_run: float = Input.is_action_pressed("run")

	# do not flip in certain conditions
	if (not steering) or countersteering or holding_run:
		if direction < 0:
			player.sprite.flip_h = true
		else:
			player.sprite.flip_h = false

func physics_update(delta):

	player.velocity += player.CLING_MODIFIER * player.get_gravity() * delta

	if not player.is_on_wall():
		state_machine.change_state("airborne")

	if Input.is_action_just_pressed("jump"):
		# check if player is holding run input
		var holding_run = Input.is_action_pressed("run")

		# leap if true, else jump
		var next_state_name := "leap" if holding_run else "wall_jump"
		var modifier := player.RUN_MODIFIER if holding_run else 1.0
		state_machine.change_state(next_state_name)
		player.jump(holding_run)

		# move away from the wall
		move(get_wall_direction(), modifier)

	# checks if the player is trying to detach and handles the logic if so
	check_detach()

	check_landing("walk")

func _on_detach_buffer_timer_timeout() -> void:
	move(buffered_direction)
	state_machine.change_state("airborne")
