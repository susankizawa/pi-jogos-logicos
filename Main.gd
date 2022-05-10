extends Node


# Variáveis

# Chamado quando o nó (godot) entra na árvore de cena pela primeira vez.
func _ready():
	# Randomiza a seed pra gerar valores aleatórios
	randomize()


# Chamado a cada frame. 'delta' é o tempo que passou desde a última frame.
func _process(_delta):
	pass
