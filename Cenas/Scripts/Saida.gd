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

# Chamado quando o nó (godot) entra na árvore de cena pela primeira vez.
func _ready():
	pass

# Chamado a cada frame. 'delta' é o tempo que passou desde a última frame.
func _process(delta):
	if quantidade[0] >= num_min_dados and precisao >= precisao_min:
		if !passado:
			game.saidas_passadas += 1
			passado = true

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
		dados_certos+= quantidade[3]
	
	precisao = dados_certos / quantidade[0]
