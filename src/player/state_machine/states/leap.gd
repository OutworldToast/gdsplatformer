extends Airborne
class_name Leap

func enter() -> void:
    player.sprite.play("leap")

func physics_update(delta) -> void:

    player.velocity += player.get_gravity() * delta

    if Input.is_action_just_released("run"):
        request_state.emit("jump")

    if player.is_on_wall():
        request_state.emit("cling")

    check_landing("run")