extends Area2D


# Variáveis exportáveis (váriaveis que podem ser modificadas no editor)
export(String, "Vermelho", "Verde", "Azul") var cor_escolhida = "Vermelho" # 3 valores (de texto: "Vermelho", "Verde" e "Azul") podem ser escolhidos para essa variável
export var rapidez = 1.0 # 1 valor decimal qualquer que o developer pode digitar pode ser essa variável

# Variáveis
var dados = [] # Fila de dados que estão sendo processados, o que estão mais próximos do final do vetor são mais recentes. Por exemplo: dados[0] começou a ser processado antes de dados[1]
var being_dragged = false # Se o jogador está arrastando esse nó com o mouse. Atualmente desabilitado

# Nós (godot)
onready var main = get_tree().get_root().get_node("Main")
onready var game = main.get_node("Game")
onready var entrada = get_node("Entrada")
onready var saida1 = get_node("Saida1")
onready var saida2 = get_node("Saida2")
onready var botao_de_propriedade = get_node("Node2D/OptionButton")

# Cenas

# Chamado quando o nó (godot) entra na árvore de cena pela primeira vez.
func _ready():
	pass


# Chamado a cada frame. 'delta' é o tempo que passou desde a última frame.
func _process(delta):
	if is_instance_valid(game) and !game.rodando:
		for timer in range(7,self.get_child_count()):
			get_child(timer).paused = true
	else:
		for timer in range(7,self.get_child_count()):
			get_child(timer).paused = false
	
	if !game.game_over_timer.paused and game.game_over_timer.time_left > 0:
		botao_de_propriedade.disabled = true
	else:
		botao_de_propriedade.disabled = false

func _on_Entrada_body_entered(body):
	# Detecta se um corpo entrou em contato com a entrada deste nó
	
	# Se o corpo está no grupo dado, começa a processar o dado
	if body.is_in_group("dado"):
		# Faz o dado ficar parado no centro desse nó enquanto está sendo processado
		body.position = self.position
		body.destino = self.global_position
		
		# Adiciona o nó (godot) para a fila de dados que estão sendo processados
		dados.append(body)
		
		# Cria um timer com duração igual ao tempo de processamento (rapidez)
		# Prepara o timer
		var timer = Timer.new()
		timer.connect("timeout", self, "_on_Rapidez_timeout") # Quando o acaba o timer, executa o que estiver na função "_on_Rapidez_timeout"
		timer.set_wait_time(rapidez)
		
		# Adiciona o timer como criança desse nó (self)
		add_child(timer)
		
		# Inicia o timer
		timer.start()


func _on_Rapidez_timeout():
	# Retira o valor que estiver em dados[0] e coloca na variável dado
	# Como se fosse uma fila a pessoa que estava na frente sai da fila dados e vai pro variável dado enquanto as outras pessoas na fila movem pra frente
	var dado = dados.pop_front()
	
	# Escolhe para que saída enviar o dado dependendo da propriedade do dado e a cor que deseja ser filtrada
	if dado.propriedade == cor_escolhida:
		enviar_dado(dado, 1) # Enviar dado para Saida1
	else:
		enviar_dado(dado, 2) # Enviar dado para Saida2
	
	get_child(7).queue_free() # Deleta o timer criado no início do processamento do dado mais antigo da fila, ou seja, o que acabou de ser processado

func enviar_dado(d, s):
	var saida
	
	# Pega o nó (godot) da saída escolhida
	if s == 1:
		saida = saida1
	elif s == 2:
		saida = saida2
	
	if saida.entrada_conectada == null:
		game.rodando = false
		return
	
	# Ajusta a posição do dado e para onde o dado vai se mover
	d.global_position = saida.global_position
	d.destino = saida.entrada_conectada.global_position


func _on_SistemaEspecialista_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			# Se o botão esquerdo do mouse está sendo pressionado, arrastar este nó (self)
			if event.pressed:
				being_dragged = true
			# Se o botão esquerdo do mouse NÃO está sendo pressionado, NÃO arrastar este nó (self)
			else:
				being_dragged = false
	elif event is InputEventMouseMotion:
		if being_dragged:
			# Se este nó (self) ESTÁ sendo arrastado, a posição dele é a mesma que a do mouse
			global_position = event.global_position

func _on_OptionButton_item_selected(index):
	cor_escolhida = botao_de_propriedade.get_item_text(index)
