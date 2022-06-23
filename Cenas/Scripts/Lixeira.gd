extends Area2D


# Variáveis

# Chamado quando o nó (godot) entra na árvore de cena pela primeira vez.
func _ready():
	pass

# Chamado a cada frame. 'delta' é o tempo que passou desde a última frame.
func _process(delta):
	pass

func _on_Entrada_body_entered(body):
	if body.is_in_group("dado"):
		# Deleta o dado que entrar em contato com este nó (self)
		body.queue_free()


func _on_Entrada_input_event(viewport, event, shape_idx):
	pass # Replace with function body.


func _on_Entrada_mouse_entered():
	pass # Replace with function body.


func _on_Entrada_mouse_exited():
	pass # Replace with function body.
