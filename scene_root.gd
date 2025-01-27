extends Node3D

const MENU = preload("res://menu.tscn")

var menu

signal menu_state_changed(menu_open: bool)


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		if menu == null:
			menu = MENU.instantiate()
			add_child(menu)
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			
			menu_state_changed.emit(true)
		else:
			menu.queue_free()
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			
			menu_state_changed.emit(false)
