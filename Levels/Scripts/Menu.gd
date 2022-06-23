extends Control


# Declare member variables here. Examples:
var game_scene = preload("res://Levels/Level1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	var game = game_scene.instance()
	get_tree().get_root().get_node("Main").add_child(game)
	self.queue_free()

func _on_QuitButton_pressed():
	get_tree().quit()
