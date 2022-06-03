extends Node


# Variáveis
var noh_inicial_da_conexao
var noh_final_da_conexao
var conectando = false

var saidas
var entradas

# Saidas
onready var entrada = get_node("Entrada")
onready var saida1 = get_node("Saida1")
onready var saida2 = get_node("Saida2")

# Chamado quando o nó (godot) entra na árvore de cena pela primeira vez.
func _ready():
	# Randomiza a seed pra gerar valores aleatórios
	randomize()
	
	saidas = get_tree().get_nodes_in_group("saida")
	entradas = get_tree().get_nodes_in_group("entrada")


# Chamado a cada frame. 'delta' é o tempo que passou desde a última frame.
func _process(_delta):
	if saida1.passado and saida2.passado:
		vitoria()


func _unhandled_input(event):
	if conectando:
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
			if !event.pressed:
				if noh_inicial_da_conexao.is_in_group("saida"):
					for entrada in entradas:
						if entrada.mouse_em_cima:
							noh_final_da_conexao = entrada
				elif noh_inicial_da_conexao.is_in_group("entrada"):
					for saida in saidas:
						if saida.mouse_em_cima:
							noh_final_da_conexao = noh_inicial_da_conexao
							noh_inicial_da_conexao = saida
				
				if noh_inicial_da_conexao != null and noh_final_da_conexao != null:
					conectar(noh_inicial_da_conexao,noh_final_da_conexao)
				else:
					desconectar()
				
		elif event is InputEventMouseMotion:
			noh_inicial_da_conexao.linha.set_point_position(1,event.position - noh_inicial_da_conexao.global_position)


func vitoria():
	get_tree().paused = true
	
	print("Sucesso!")
	print("")
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
	print("Recompensa: R$350,00")


func iniciar_conexao(noh):
	noh_inicial_da_conexao = noh
	conectando = true


func conectar(saida,entrada):
	if entrada.saida_conectada != null:
		entrada.saida_conectada.linha.set_point_position(1,Vector2.ZERO)
		entrada.saida_conectada = null
	
	saida.entrada_conectada = entrada
	entrada.saida_conectada = saida
	
	saida.linha.set_point_position(1,entrada.global_position - saida.global_position)
	entrada.linha.set_point_position(1,Vector2.ZERO)
	
	noh_inicial_da_conexao = null
	noh_final_da_conexao = null
	conectando = false


func desconectar():
	noh_inicial_da_conexao.linha.set_point_position(1,Vector2.ZERO)
	noh_inicial_da_conexao = null
	conectando = false
