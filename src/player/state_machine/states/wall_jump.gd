extends Airborne
class_name WallJump

var movement_allowed := false

func enter() -> void:
    player.sprite.play("jump")

    movement_allowed = false
    player.wall_jump_hang_timer.timeout.connect(_on_wall_jump_hang_timer_timeout)
    player.wall_jump_hang_timer.start()

func exit() -> void:
    player.wall_jump_hang_timer.timeout.disconnect(_on_wall_jump_hang_timer_timeout)

func physics_update(delta) -> void:

    var direction := get_input_direction()
    if direction:
        flip(direction)

    player.velocity += player.get_gravity() * delta

    if player.is_on_wall():
        state_machine.change_state("cling")

    check_landing("walk")

    # if hang time has ended and player is holding direction, exit state
    if movement_allowed and get_input_direction():
        state_machine.change_state("jump")

func _on_wall_jump_hang_timer_timeout() -> void:
    # allow movement after hang period has ended
    movement_allowed = true