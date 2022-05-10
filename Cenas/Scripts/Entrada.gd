extends Area2D


# Variáveis

# Nós (godot)
onready var main = get_tree().get_root().get_node("Main")
onready var saida = get_node("Saida")
onready var rapidez = get_node("Rapidez")

onready var saida_entrada_conectada = saida.get_node(saida.entrada_conectada_caminho)

# Cenas
var dado_cena = preload("res://Cenas/Dado.tscn")

# Chamado quando o nó (godot) entra na árvore de cena pela primeira vez.
func _ready():
	enviar_dado()

# Chamado a cada frame. 'delta' é o tempo que passou desde a última frame.
#func _process(delta):
#	pass

func enviar_dado():
	# Prepara uma instância da cena "Dado.tscn" para ser adicionada
	var dado = dado_cena.instance()
	
	# Modifica variáveis da instância
	dado.global_position = saida.global_position
	dado.destino = saida_entrada_conectada.global_position
	
	# Adiciona a instância criada como uma criança do nó "Main" (godot)
	main.call_deferred("add_child", dado)
	
	# Tempo entre cada dado mandado
	# Inicia o timer que tem duração de, por exemplo, 1s
	# Quando o timer acaba a função "_on_Rapidez_timeout" é chamada
	# E outro dado é enviado
	rapidez.start()

func _on_Rapidez_timeout():
	# Envia outro dado quando o timer Rapidez acaba
	enviar_dado()