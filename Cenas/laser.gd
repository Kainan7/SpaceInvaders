extends Area2D

class_name Laser #nome do laser
@export var speed = 1000 #velocidade do laser


func _process(delta):
	position.y -= speed * delta #posicao da bala em y
