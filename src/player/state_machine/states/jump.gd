extends Airborne
class_name Jump

func enter() -> void:
    player.sprite.play("jump")

func physics_update(delta) -> void:

    move(get_direction())
    player.velocity += player.get_gravity() * delta

    check_landing("walk")