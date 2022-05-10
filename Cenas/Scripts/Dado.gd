extends KinematicBody2D


# Variáveis
var propriedade = ""
var velocidade = 100
var destino = Vector2(0,0)
var direcao = Vector2(0,0)

# Nós (godot)
onready var sprite = get_node("Sprite")

# Chamado quando o nó (godot) entra na árvore de cena pela primeira vez.
func _ready():
	# Escolhe uma propriedade aleatório entre "Vermelho", "Verde" e "Azul" e modifica a cor da textura pra propriedade ser visível
	match (randi() % 3):
		0:
			propriedade = "Vermelho"
			sprite.modulate = Color(1, 0, 0)
		1:
			propriedade = "Verde"
			sprite.modulate = Color(0, 1, 0)
		2:
			propriedade = "Azul"
			sprite.modulate = Color(0, 0, 1)

# Chamado a cada frame. 'delta' é o tempo que passou desde a última frame.
func _process(delta):
	# Calcula o movimento do dado
	direcao = (destino - self.global_position).normalized() # "normalized" transforma um vetor pra ele ter distância 1. Por exemplo se você tem um vetor (2,2), o vetor normalizado seria (0.5,0.5)
	move_and_slide(direcao * velocidade) # Move o dado
