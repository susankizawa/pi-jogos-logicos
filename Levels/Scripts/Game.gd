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

# Nós
onready var main = get_tree().get_root().get_node("Main")
onready var game_over_timer = get_node("GameOver")

# Cenas
var vitoria_scene = preload("res://Levels/sucesso.tscn")
var fracasso_scene = preload("res://Levels/fracasso.tscn")

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
	var estatisticas = ""
	
	for saida in saidas:
		estatisticas += String("%s\nDados recebidos: %d\nVermelhos: %d\nVerdes: %d\nAzuis: %d\n\nPrecisão: %.1f%%\n\n" % [saida.name,saida.quantidade[0],saida.quantidade[1],saida.quantidade[2],saida.quantidade[3],saida.precisao * 100])
	
	main.change_scene_to(vitoria_scene)
	
	var tela_de_vitoria = main.get_node("sucesso")
	
	tela_de_vitoria.escrever_estatisticas(estatisticas)

func fracasso():
	var estatisticas = ""
	
	for saida in saidas:
		estatisticas += String("%s\nDados recebidos: %d\nVermelhos: %d\nVerdes: %d\nAzuis: %d\n\nPrecisão: %.1f%%\n\n" % [saida.name,saida.quantidade[0],saida.quantidade[1],saida.quantidade[2],saida.quantidade[3],saida.precisao * 100])
	
	main.change_scene_to(fracasso_scene)
	
	var tela_de_fracasso = main.get_node("fracasso")
	
	tela_de_fracasso.escrever_estatisticas(estatisticas)

func iniciar_conexao(noh):
	if game_over_timer.paused or game_over_timer.time_left == 0:
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


func _on_Rodar_pressed():
	rodando = true
	
	var rodar_button = get_node("Rodar")
	var parar_button = get_node("Parar")
	rodar_button.hide()
	parar_button.show()
	
	game_over_timer.start()

func _on_Parar_pressed():
	main.reload_scene(self.filename)


func _on_GameOver_timeout():
	fracasso()

