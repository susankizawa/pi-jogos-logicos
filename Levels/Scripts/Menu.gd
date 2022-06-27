extends Control


# Nós
onready var main = get_tree().get_root().get_node("Main")

# Cenas
var level_select_scene = preload("res://Levels/Level Select.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	main.change_scene_to(level_select_scene)

func _on_QuitButton_pressed():
	get_tree().quit()


