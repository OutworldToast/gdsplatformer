extends State
class_name Victorious

func enter() -> void:
	player.sprite.play("win")


func physics_update(delta) -> void:

	player.velocity += player.get_gravity() * delta

	player.velocity.x = lerp(player.velocity.x, 0.0, 0.1)
