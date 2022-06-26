extends Area2D


# Variáveis
var mouse_em_cima = false

# Nós (godot)
var linha
var saida_conectada

onready var game = get_tree().get_root().get_node("Main/Game")

# Chamado quando o nó (godot) entra na árvore de cena pela primeira vez.
func _ready():
	linha = Line2D.new()
	for i in 2:
		linha.add_point(Vector2.ZERO)
		linha.z_index = -30
	add_child(linha)


# Chamado a cada frame. 'delta' é o tempo que passou desde a última frame.
func _process(delta):
	pass


func _on_Saida_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			game.iniciar_conexao(self)


func _on_Saida_mouse_entered():
	mouse_em_cima = true


func _on_Saida_mouse_exited():
	mouse_em_cima = false


func _on_Entrada_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			if is_instance_valid(game):
				game.iniciar_conexao(self)


func _on_Entrada_mouse_entered():
	mouse_em_cima = true


func _on_Entrada_mouse_exited():
	mouse_em_cima = false
