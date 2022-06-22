extends Node


# Variáveis
var noh_inicial_da_conexao
var noh_final_da_conexao
var conectando = false
var rodando = false

var saidasNohs
var entradasNohs

var entrada
var saidas

var saidas_passadas = 0

# Chamado quando o nó (godot) entra na árvore de cena pela primeira vez.
func _ready():
	# Randomiza a seed pra gerar valores aleatórios
	randomize()
	
	entrada = get_node("Entrada")
	saidas = get_tree().get_nodes_in_group("saida")
	
	saidasNohs = get_tree().get_nodes_in_group("saidaNoh")
	entradasNohs = get_tree().get_nodes_in_group("entradaNoh")


# Chamado a cada frame. 'delta' é o tempo que passou desde a última frame.
func _process(_delta):
	if saidas_passadas == saidas.size():
		vitoria()

func _unhandled_input(event):
	if conectando:
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
			if !event.pressed:
				if noh_inicial_da_conexao.is_in_group("saidaNoh"):
					for entradaNoh in entradasNohs:
						if entradaNoh.mouse_em_cima:
							noh_final_da_conexao = entradaNoh
				elif noh_inicial_da_conexao.is_in_group("entradaNoh"):
					for saidaNoh in saidasNohs:
						if saidaNoh.mouse_em_cima:
							noh_final_da_conexao = noh_inicial_da_conexao
							noh_inicial_da_conexao = saidaNoh
				
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
	for saida in saidas:
		print(saida.name)
		print("Dados recebidos: ", saida.quantidade[0])
		print("Vermelhos: ", saida.quantidade[1])
		print("Verdes: ", saida.quantidade[2])
		print("Azuis: ", saida.quantidade[3])
		print("Precisão: ", saida.precisao * 100, "%")
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

func _on_Button_pressed():
	rodando = true
	entrada.enviar_dado()
	
	var button = get_node("Button")
	
	button.disabled = true
	
