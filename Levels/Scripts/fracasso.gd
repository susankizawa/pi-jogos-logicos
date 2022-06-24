extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Nós
onready var estatisticas = get_node("CenterContainer/VBoxContainer/Estatisticas")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func escrever_estatisticas(texto):
	estatisticas.text = texto
