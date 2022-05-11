extends Area2D


# Variáveis
var dados = [] # Dados armazenados 

# Quantidade de dados de cada propriedade que estão armazenados na saída
var quant_vermelhos = 0
var quant_verdes = 0
var quant_azuis = 0

# Chamado quando o nó (godot) entra na árvore de cena pela primeira vez.
func _ready():
	pass

# Chamado a cada frame. 'delta' é o tempo que passou desde a última frame.
#func _process(delta):
#	pass

func _on_Entrada_body_entered(body):
	if body.is_in_group("dado"):
		# Adiciona ao vetor de dados armazenados o dado que entrar em contato com a entrada
		dados.append(body.propriedade)
		
		quant_vermelhos = dados.count("Vermelho")	# Conta quantos dados vermelhos tem armazenados
		quant_verdes = dados.count("Verde")			# Conta quantos dados verdes tem armazenados
		quant_azuis = dados.count("Azul")			# Conta quantos dados azuis tem armazenados
		
		# Deleta o dado que entrar em contato com este nó (self)
		body.queue_free()
