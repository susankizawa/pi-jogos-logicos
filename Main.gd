extends Node


# Declare member variables here. Examples:
var noh_inicio_da_coneccao
var noh_fim_da_coneccao
var conectando = false

var saidas
var entradas


# Called when the node enters the scene tree for the first time.
func _ready():
	saidas = get_tree().get_nodes_in_group("saida")
	entradas = get_tree().get_nodes_in_group("entrada")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _unhandled_input(event):
	if conectando:
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
			if !event.pressed:
				
				if noh_inicio_da_coneccao.is_in_group("saida"):
					for entrada in entradas:
						if entrada.mouse_em_cima:
							noh_fim_da_coneccao = entrada
				elif noh_inicio_da_coneccao.is_in_group("entrada"):
					for saida in saidas:
						if saida.mouse_em_cima:
							noh_fim_da_coneccao = noh_inicio_da_coneccao
							noh_inicio_da_coneccao = saida
				
				if noh_inicio_da_coneccao != null and noh_fim_da_coneccao != null:
					conectar(noh_inicio_da_coneccao,noh_fim_da_coneccao)
				else:
					desconectar()
				
		elif event is InputEventMouseMotion:
			noh_inicio_da_coneccao.linha.set_point_position(1,event.position - noh_inicio_da_coneccao.position)


func iniciar_coneccao(noh):
	noh_inicio_da_coneccao = noh
	conectando = true

func conectar(saida,entrada):
	if entrada.saida_conectada != null:
		entrada.saida_conectada.linha.set_point_position(1,Vector2.ZERO)
		entrada.saida_conectada = null
	
	saida.entrada_conectada = entrada
	entrada.saida_conectada = saida
	
	saida.linha.set_point_position(1,entrada.position - saida.position)
	entrada.linha.set_point_position(1,Vector2.ZERO)
	
	noh_inicio_da_coneccao = null
	noh_fim_da_coneccao = null
	conectando = false

func desconectar():
	noh_inicio_da_coneccao.linha.set_point_position(1,Vector2.ZERO)
	noh_inicio_da_coneccao = null
	conectando = false
