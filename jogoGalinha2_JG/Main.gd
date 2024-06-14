extends Node

const Cena_Carros = preload("C:/Users/jgam3/Documents/jogoGalinha2_JG/Carros.tscn")

var pistas_rapidas = [104,272,488]
var pistas_lentas = [160,216,324,384,438,544,600]

var score1 = 0
var score2 = 0
func _ready():
	$AudioTema.play()
	$HUD/Mensagem.text = ""
	$HUD/Button.hide()
	randomize()

func ganhou():
	if score1 + score2 == 5:
		$Jogador.hide()
		$Jogador2.hide()
		$AudioTema.stop()
		$AudioVitoria.play()
		$TimerCarrosRapido.stop()
		$TimerCarrosLento.stop()
		$HUD/Mensagem.text = "Fim de Jogo"
		$HUD/Button.show()
	
	else:
		$HUD/Placar.text = str(score2)
		$HUD/Placar2.text = str(score1)
		$AudioPonto.play()



func _on_TimerCarrosRapido_timeout():
	var novo_carro = Cena_Carros.instance()
	add_child(novo_carro)
	
	var pista = pistas_rapidas[randi() % pistas_rapidas.size()]
	
	novo_carro.position = Vector2(-10,pista)
	novo_carro.linear_velocity.x = rand_range(700,710)
	novo_carro.linear_damp = -1

func _on_TimerCarrosLento_timeout():
	var novo_carro = Cena_Carros.instance()
	add_child(novo_carro)
	
	var pista = pistas_lentas[randi() % pistas_lentas.size()]
	
	novo_carro.position = Vector2(-10,pista)
	novo_carro.linear_velocity.x = rand_range(300,310)
	novo_carro.linear_damp = -1

func _on_Jogador_pontua():
	score1+=1
	ganhou()
func _on_Jogador2_pontua():
	score2+=1
	ganhou()


func _on_HUD_reinicia():
	$Jogador.show()
	$Jogador2.show()
	score1 = 0
	score2 = 0
	
	$Jogador.position = $Jogador.Posicao_Inicial
	$Jogador2.position = $Jogador2.Posicao_Inicial
	$AudioTema.play()
	
	$TimerCarrosRapido.start()
	$TimerCarrosLento.start()
	
	$HUD/Mensagem.text = ""
	$HUD/Placar.text = "0"
	$HUD/Placar2.text = "0"
	$HUD/Button.hide()
