extends Airborne
class_name Leap

func enter() -> void:
    player.sprite.play("leap")

func physics_update(delta) -> void:

    player.velocity += player.get_gravity() * delta

    if Input.is_action_just_released("run"):
        state_machine.change_state("jump")

    check_landing("run")