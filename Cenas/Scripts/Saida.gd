extends Area2D


# Variáveis exportáveis
export(int, 1, 100) var num_min_dados = 10

export(bool) var exige_vermelho = false
export(bool) var exige_verde = false
export(bool) var exige_azul = false

export(float, 0, 1) var precisao_min = 1

# Variáveis
var dados = [] # Dados armazenados 

# Quantidade de dados de cada propriedade que estão armazenados na saída
var quantidade = [0, 0, 0, 0] # quantidade[0] = quantidade total de dados recebidos, quantidade[1] = quantidade de dados vermelhos, quantidade[2] = quantidade de dados verdes e quantidade[3] = quantidade de dados azuis

var precisao = 0.0

var passado = false

# Nós
onready var game = get_tree().get_root().get_node("Main/Game")
onready var propriedade1_img = get_node("Propriedade1")
onready var propriedade2_img = get_node("Propriedade2")
onready var propriedade3_img = get_node("Propriedade3")
onready var quant_min_barra = get_node("QuantidadeMin")
onready var quant_min_text = get_node("QuantidadeMinNum")
onready var precisao_barra = get_node("Precisao")
onready var precisao_text = get_node("PrecisaoNum")

# Chamado quando o nó (godot) entra na árvore de cena pela primeira vez.
func _ready():
	quant_min_text.set_text("%d" % num_min_dados)
	quant_min_barra.max_value = num_min_dados
	
	if !exige_vermelho:
		propriedade1_img.modulate = Color(0.5,0.5,0.5)
	if !exige_azul:
		propriedade2_img.modulate = Color(0.5,0.5,0.5)
	if !exige_verde:
		propriedade3_img.modulate = Color(0.5,0.5,0.5)
	

# Chamado a cada frame. 'delta' é o tempo que passou desde a última frame.
func _process(delta):
	if quantidade[0] >= num_min_dados and precisao >= precisao_min:
		if !passado:
			game.saidas_passadas += 1
			passado = true
	
	quant_min_barra.value = dados.size()
	precisao_barra.value = precisao

func _on_Entrada_body_entered(body):
	if body.is_in_group("dado"):
		# Adiciona ao vetor de dados armazenados o dado que entrar em contato com a entrada
		dados.append(body.propriedade)
		
		atualizar()
		
		# Deleta o dado que entrar em contato com este nó (self)
		body.queue_free()

func atualizar():
	quantidade[0] = dados.size()
	quantidade[1] = dados.count("Vermelho")
	quantidade[2] = dados.count("Verde")
	quantidade[3] = dados.count("Azul")
	
	var dados_certos = 0
	
	if exige_vermelho:
		dados_certos += quantidade[1]
	
	if exige_verde:
		dados_certos += quantidade[2]
	
	if exige_azul:
		dados_certos += quantidade[3]
	
	precisao = float(dados_certos / quantidade[0])
	
	print(precisao)
