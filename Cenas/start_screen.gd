extends CanvasLayer

@onready var texture_rect_1 = %TextureRect1
@onready var label = %Label
@onready var texture_rect_2 = %TextureRect2
@onready var label_2 = %Label2
@onready var texture_rect_3 = %TextureRect3
@onready var label_3 = %Label3
@onready var timer = $Timer

var control_array = []


func _ready():
	control_array = [texture_rect_1, label, texture_rect_2, label_2, texture_rect_3, label_3]
	for control in control_array:
		(control as Control).visible = false


func _on_timer_timeout():
	var control = control_array.pop_front() as Control
	if control != null:
		control.visible = true
	else:
		timer.stop()
		timer.queue_free()
	


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Cenas/main.tscn")

