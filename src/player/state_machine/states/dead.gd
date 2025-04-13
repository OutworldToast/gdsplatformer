extends State
class_name Dead

func enter() -> void:
    player.sprite.play("die")


func physics_update(_delta) -> void:

    player.velocity = Vector2.ZERO
