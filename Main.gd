extends Node


# Variáveis

# Saidas
onready var entrada = get_node("Entrada")
onready var saida1 = get_node("Saida1")
onready var saida2 = get_node("Saida2")

# Chamado quando o nó (godot) entra na árvore de cena pela primeira vez.
func _ready():
	# Randomiza a seed pra gerar valores aleatórios
	randomize()


# Chamado a cada frame. 'delta' é o tempo que passou desde a última frame.
func _process(_delta):
	if saida1.passado and saida2.passado:
		vitoria()
	

func vitoria():
	get_tree().paused = true
	
	print(saida1.name)
	print("Dados recebidos: ", saida1.quantidade[0])
	print("Vermelhos: ", saida1.quantidade[1])
	print("Verdes: ", saida1.quantidade[2])
	print("Azuis: ", saida1.quantidade[3])
	print("Precisão: ", saida1.precisao * 100, "%")
	print("")
	print(saida2.name)
	print("Dados recebidos: ", saida2.quantidade[0])
	print("Vermelhos: ", saida2.quantidade[1])
	print("Verdes: ", saida2.quantidade[2])
	print("Azuis: ", saida2.quantidade[3])
	print("Precisão: ", saida2.precisao * 100, "%")
	print("")
