extends Node


# Variáveis

# Saidas
onready var saida1 = get_node("Saida1")
onready var saida2 = get_node("Saida2")

# Chamado quando o nó (godot) entra na árvore de cena pela primeira vez.
func _ready():
	# Randomiza a seed pra gerar valores aleatórios
	randomize()


# Chamado a cada frame. 'delta' é o tempo que passou desde a última frame.
func _process(_delta):
	# Escreve no Output as informações das saídas quando espaço ou enter são apertados (outras teclas também pode ser usadas, precisa verificar no Input Map)
	if Input.is_action_just_pressed("ui_accept"):
		print("Saída 1")
		print("Vermelhos: ", saida1.quant_vermelhos)
		print("Verdes: ", saida1.quant_verdes)
		print("Azuis: ", saida1.quant_azuis)
		print("")
		print("Saída 2")
		print("Vermelhos: ", saida2.quant_vermelhos)
		print("Verdes: ", saida2.quant_verdes)
		print("Azuis: ", saida2.quant_azuis)
		print("")
