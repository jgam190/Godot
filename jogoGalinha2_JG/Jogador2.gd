extends Area2D

export var speed = 200

var Tamanho_Janela
var Posicao_Inicial = Vector2(580,690)

signal pontua

func _ready():
	Tamanho_Janela = get_viewport_rect().size

func _process(delta):
	var velocidade = Vector2()
	if Input.is_action_pressed("upW"):
		velocidade.y -=1
	if Input.is_action_pressed("downS"):
		velocidade.y +=1
	if Input.is_action_pressed("LeftA"):
		velocidade.x -=1
	if Input.is_action_pressed("RightD"):
		velocidade.x +=1

	velocidade = velocidade.normalized()*speed
	if velocidade.length() > 0:
		$Animacao.play()
	else:
		$Animacao.stop()
	
	if velocidade.y > 0:
		$Animacao.animation = "baixo"
	else:
		$Animacao.animation = "cima"

	position += velocidade * delta
	position.y = clamp(position.y,0, Tamanho_Janela.y)


func _on_Jogador2_body_entered(body):
		if body.name == "LinhaChegada":
				   emit_signal("pontua")
		else:
			  $Audio.play()
		position = Posicao_Inicial


