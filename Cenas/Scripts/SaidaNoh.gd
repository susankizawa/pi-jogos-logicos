extends Area2D


# Variáveis
export(NodePath) var entrada_conectada_caminho

# Nós (godot)
onready var linha = get_node("Line2D")
onready var entrada_conectada = get_node(entrada_conectada_caminho)

# Chamado quando o nó (godot) entra na árvore de cena pela primeira vez.
func _ready():
	pass


# Chamado a cada frame. 'delta' é o tempo que passou desde a última frame.
func _process(delta):
	# Desenha uma linha verde entre esta saída e a entrada a qual esta saída esta conectada
	# Na verdade, a linha já existe e esta função edita a linha para que esteja conectada entre esta saída e a entrada conectada
	linha.set_point_position(1, entrada_conectada.global_position - self.global_position)
