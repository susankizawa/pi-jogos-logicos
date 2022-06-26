extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func change_scene_to(scene_resource):
	self.get_child(0).queue_free()
	
	var new_scene = scene_resource.instance()
	
	self.add_child(new_scene)

func reload_scene(scene_resource_path):
	var current_scene = self.get_child(0)
	
	current_scene.queue_free()
	
	yield(current_scene,"tree_exited")
	
	var scene_resource = load(scene_resource_path)
	var new_scene = scene_resource.instance()
	
	self.add_child(new_scene)
