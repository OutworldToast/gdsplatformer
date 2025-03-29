extends State
class_name Airborne

func enter() -> void:
    player.sprite.play("jump")

func check_landing(direction_state_name: String, idle_state_name: String = "idle") -> void:
    if player.is_on_floor():
        if Input.get_axis("move_left", "move_right"):
            state_machine.change_state(direction_state_name)
        else:
            state_machine.change_state(idle_state_name)

func physics_update(delta) -> void:

    super(delta)

    player.velocity += player.get_gravity() * delta
    
    if Input.is_action_just_pressed("jump"):
        player.jump(false)
        state_machine.change_state("jump")

    if player.is_on_wall():
        state_machine.change_state("cling")

    check_landing("walk")
