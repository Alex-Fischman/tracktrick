tool
extends Spatial

export(Array, PackedScene) var scenes
export(Array, int) var track_layout

func _ready():
	var last_instance
	for i in track_layout:
		if not last_instance:
			last_instance = scenes[i].instance()
			add_child(last_instance)
		else:
			var offset = last_instance.get_node(@"End").global_transform
			last_instance = scenes[i].instance()
			add_child(last_instance)
			last_instance.global_transform = offset
