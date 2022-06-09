extends Control


# Declare member variables here. Examples:
var game = preload("res://Main.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	get_tree().change_scene_to(game)


func _on_QuitButton_pressed():
	get_tree().quit()
