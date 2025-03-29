extends Airborne
class_name WallJump

func enter() -> void:
    player.sprite.play("jump")
    player.wall_jump_hang_timer.timeout.connect(_on_wall_jump_hang_timer_timeout)
    player.wall_jump_hang_timer.start()

func exit() -> void:
    player.wall_jump_hang_timer.timeout.disconnect(_on_wall_jump_hang_timer_timeout)

# override move to only flip sprite
func move(direction: float, _modifier := 1.0) -> void:
    if direction:
        if direction < 0:
            player.sprite.flip_h = true
        else:
            player.sprite.flip_h = false

func physics_update(delta) -> void:

    move(get_direction())

    player.velocity += player.get_gravity() * delta

    if player.is_on_wall():
        state_machine.change_state("cling")

    check_landing("walk")

func _on_wall_jump_hang_timer_timeout() -> void:
    state_machine.change_state("jump")