
class_name ProgressData extends Resource


## created using https://gamedevartisan.com/tutorials/godot-fundamentals/saving-user-preferences

@export var progress: Dictionary[String, int] = {
    "level_1": 0,
    "level_2": 0,
}

@export var last_level_name: String = "level_1"

func save() -> void:
    ResourceSaver.save(self, "user://progress_data.tres")


static func load_or_create() -> ProgressData:
    var resource: ProgressData = ResourceLoader.load("user://progress_data.tres") as ProgressData
    if not resource:
        resource = ProgressData.new()
        
    return resource