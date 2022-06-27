extends Area2D


# Variáveis
var being_dragged = false

# Nós
onready var game = get_tree().get_root().get_node("Main/Game")

# Chamado quando o nó (godot) entra na árvore de cena pela primeira vez.
func _ready():
	pass

# Chamado a cada frame. 'delta' é o tempo que passou desde a última frame.
func _process(delta):
	if !game.rodando and being_dragged:
		if Input.is_action_just_pressed("delete"):
			self.queue_free()
		
		global_position = get_global_mouse_position()


func _on_Entrada_body_entered(body):
	if body.is_in_group("dado"):
		# Deleta o dado que entrar em contato com este nó (self)
		body.queue_free()


func _on_Lixeira_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			# Se o botão esquerdo do mouse está sendo pressionado, arrastar este nó (self)
			if !game.conectando and event.pressed:
				being_dragged = true
			# Se o botão esquerdo do mouse NÃO está sendo pressionado, NÃO arrastar este nó (self)
			else:
				being_dragged = false
