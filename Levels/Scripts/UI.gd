extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Nós
onready var game = get_tree().get_root().get_node("Main/Game")
onready var rodar_button = get_node("VBoxContainer2/Rodar")
onready var parar_button = get_node("VBoxContainer2/Parar")

# Cenas
var sistema_especialista_scene = preload("res://Cenas/SistemaEspecialista.tscn")
var arvore_de_decisao_scene = preload("res://Cenas/ArvoredeDeDecisaoCor.tscn")
var lixeira_scene = preload("res://Cenas/Lixeira.tscn")


# Sinais
signal rodar
signal parar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Rodar_pressed():
	emit_signal("rodar")
	
	rodar_button.hide()
	parar_button.show()


func _on_Parar_pressed():
	emit_signal("parar")


func _on_SistemaEspecialista_pressed():
	var sistema_especialista_instance = sistema_especialista_scene.instance()
	
	sistema_especialista_instance.global_position = get_viewport_rect().size / 2
	
	game.add_child(sistema_especialista_instance)
	
	game.atualizar_entradas_e_saidas()

func _on_ArvoreDeDecisao_pressed():
	var arvore_de_decisao_instance = arvore_de_decisao_scene.instance()
	
	arvore_de_decisao_instance.global_position = get_viewport_rect().size / 2
	
	game.add_child(arvore_de_decisao_instance)
	
	game.atualizar_entradas_e_saidas()

func _on_Lixeira_pressed():
	var lixeira_instance = lixeira_scene.instance()
	
	lixeira_instance.global_position = get_viewport_rect().size / 2
	
	game.add_child(lixeira_instance)
	
	game.atualizar_entradas_e_saidas()





