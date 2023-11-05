extends Node

var versus_computer = false # would rather not have this set here at all.
var current_scene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	#print_debug(current_scene)

func switch_scene(res_path):
	call_deferred("_deferred_switch_scene", res_path)

func _deferred_switch_scene(res_path):
	current_scene.free()

	var new_scene = load(res_path)
	if versus_computer:
		# I don't really like the way I did this, but it works for now. Figure out a
		# different method in the future.
		current_scene = new_scene.instantiate()
	else:
		current_scene = new_scene.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene

	# versus_computer = false 	# reset this after it gets consumed above, so that we
								# dont instantiate something that cant have a flag.
								# don't like that i'm doing it this way.
