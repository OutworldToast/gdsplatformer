extends State
class_name Run

func enter() -> void:
    player.sprite.play("run")

func move(direction: float):
    if direction:
        player.velocity.x = direction * player.SPEED * 2
        if direction < 0:
            player.sprite.flip_h = true
        else:
            player.sprite.flip_h = false
    else:
        player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED * 2)

func physics_update(_delta):

    super(_delta)

    if not Input.is_key_pressed(KEY_SHIFT):
        state_machine.change_state("walk")

    if not get_direction():
        state_machine.change_state("idle")

    if Input.is_action_just_pressed("jump") and player.is_on_floor():
        player.velocity.y = player.JUMP_VELOCITY
        state_machine.change_state("jump")
