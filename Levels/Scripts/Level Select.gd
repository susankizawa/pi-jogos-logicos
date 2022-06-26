extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Nós
onready var main = get_tree().get_root().get_node("Main")


# Cenas
var tutorial = preload("res://Levels/Tutorial.tscn")
var level1 = preload("res://Levels/Level1.tscn")
var level2 = preload("res://Levels/Level2.tscn")
var level3 = preload("res://Levels/Level3.tscn")
var level4 = preload("res://Levels/Level4.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Tutorial_pressed():
	main.change_scene_to(tutorial)

func _on_Level1_pressed():
	main.change_scene_to(level1)

func _on_Level2_pressed():
	main.change_scene_to(level2)	

func _on_Level3_pressed():
	main.change_scene_to(level3)

func _on_Level4_pressed():
	main.change_scene_to(level4)
