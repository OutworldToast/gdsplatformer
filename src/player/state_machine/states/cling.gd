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

func physics_update(delta):

	player.velocity += player.CLING_MODIFIER * player.get_gravity() * delta

	if not player.is_on_wall():
		state_machine.change_state("airborne")

	if Input.is_action_just_pressed("jump"):
		# check if player is holding run input
		var is_holding_run = Input.is_action_pressed("run")

		# leap if true, else jump
		var next_state_name = "leap" if is_holding_run else "jump"
		state_machine.change_state(next_state_name)
		player.jump(is_holding_run)

		# move away from the wall
		move(get_wall_direction())

	var direction := get_direction()
	# checks if direction away from wall is held
	if direction and sign(direction) == sign(get_wall_direction()):
		# start detach timer if one is not going
		if player.detach_buffer_timer.is_stopped():
			print("starting timer")
			player.detach_buffer_timer.start()
			buffered_direction = direction
	else:
		# stops timer if no direction is held or direction is facing wall
		player.detach_buffer_timer.stop()

	check_landing("walk")

func _on_detach_buffer_timer_timeout() -> void:
	move(buffered_direction)
	state_machine.change_state("airborne")
