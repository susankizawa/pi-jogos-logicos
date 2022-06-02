extends Area2D


# Declare member variables here. Examples:
var entrada_conectada
var linha
var mouse_em_cima = false

# Nós
onready var main = get_tree().get_root().get_node("Main")

# Called when the node enters the scene tree for the first time.
func _ready():
	linha = Line2D.new()
	linha.add_point(Vector2.ZERO)
	linha.add_point(Vector2.ZERO)
	add_child(linha)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Saida_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			main.iniciar_coneccao(self)


func _on_Saida_mouse_entered():
	mouse_em_cima = true


func _on_Saida_mouse_exited():
	mouse_em_cima = false
