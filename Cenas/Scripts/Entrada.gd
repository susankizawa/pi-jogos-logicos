extends Area2D


# Variáveis exportáveis
export(Array, int) var dados_por_propriedade = [10, 10, 10] # dados_por_propriedade[0] para quantidade de dados vermelhos, dados_por_propriedade[1] para quantidade de dados verdes e dados_por_propriedade[2] para quantidade de dados azuis

# Variáveis
var dados = [] # Dados armazenados que logo serão expelidos


# Nós (godot)
onready var game = get_tree().get_root().get_node("Main/Game")
onready var saida = get_node("Saida")
onready var rapidez = get_node("Rapidez")
onready var quant_p1 = get_node("QuantidadeP1")
onready var quant_p2 = get_node("QuantidadeP2")
onready var quant_p3 = get_node("QuantidadeP3")

#onready var saida_entrada_conectada = saida.get_node(saida.entrada_conectada_caminho)

# Cenas
var dado_cena = preload("res://Cenas/Dado.tscn")

# Chamado quando o nó (godot) entra na árvore de cena pela primeira vez.
func _ready():
	for i in dados_por_propriedade.size():
		# Para cada propriedade,
		match (i):
			0:
				# Adicionar dados vermelhos j vezes ao vetor dados
				for j in dados_por_propriedade[i]:
					dados.append("Vermelho")
			1:
				# Adicionar dados verdes j vezes ao vetor dados
				for j in dados_por_propriedade[i]:
					dados.append("Verde")
			2:
				# Adicionar dados azuis j vezes ao vetor dados
				for j in dados_por_propriedade[i]:
					dados.append("Azul")
	
	# Embaralha os dados
	dados.shuffle()
	
	# Enquanto ainda tiver dados, enviar dado
	if !dados.empty():
		rapidez.paused = true
		rapidez.start()
		

# Chamado a cada frame. 'delta' é o tempo que passou desde a última frame.
func _process(delta):
	if !game.rodando:
		rapidez.paused = true
	else:
		rapidez.paused = false
	
	quant_p1.text = String(dados.count("Vermelho"))
	quant_p2.text = String(dados.count("Azul"))
	quant_p3.text = String(dados.count("Verde"))

func enviar_dado():
	if saida.entrada_conectada == null:
		game.rodando = false
		return
	
	# Retira o primeiro dado do vetor
	var nova_propriedade = dados.pop_back()
	
	# Prepara uma instância da cena "Dado.tscn" para ser adicionada
	var dado = dado_cena.instance()
	
	# Modifica variáveis da instância
	dado.global_position = saida.global_position
	dado.destino = saida.entrada_conectada.global_position
	dado.propriedade = nova_propriedade
	
	# Adiciona a instância criada como uma criança do nó "game" (godot)
	game.call_deferred("add_child", dado)
	
	# Tempo entre cada dado mandado
	# Se ainda tiver dados,
	# Inicia o timer que tem duração de, por exemplo, 1s
	# Quando o timer acaba a função "_on_Rapidez_timeout" é chamada
	# E outro dado é enviado
	if !dados.empty():
		rapidez.start()

func _on_Rapidez_timeout():
	# Envia outro dado quando o timer Rapidez acaba
	enviar_dado()
