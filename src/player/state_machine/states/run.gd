extends State
class_name Run

func enter() -> void:
    player.sprite.play("run")


func physics_update(_delta):

    ## kind of sloppy, should prob use super() somehow
    move(get_direction(), true)

    if not Input.is_key_pressed(KEY_SHIFT):
        state_machine.change_state("walk")

    if not get_direction():
        state_machine.change_state("idle")

    if Input.is_action_just_pressed("jump"):
        player.jump(true)
        state_machine.change_state("leap")

    if not player.is_on_floor():
        state_machine.change_state("airborne")
