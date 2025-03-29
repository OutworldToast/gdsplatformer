extends Airborne
class_name Jump

func enter() -> void:
    player.sprite.play("jump")

func physics_update(delta) -> void:

    move(get_input_direction())
    player.velocity += player.get_gravity() * delta

    if player.is_on_wall():
        request_state.emit("cling")

    check_landing("walk")