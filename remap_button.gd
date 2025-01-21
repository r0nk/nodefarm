extends Button

#https://github.com/Game-Dev-Artisan/godot-fundamentals/blob/main/scenes/ui/menus/remap_button.gd

@export var action: String

func _init():
	toggle_mode=true

func _ready():
	set_process_unhandled_input(false)
	update_key_text()

func _toggled(button_pressed):
	set_process_unhandled_input(button_pressed)
	if button_pressed:
		text = "... Awaiting Input ..."
		release_focus()
	else:
		update_key_text()
		grab_focus()

func _unhandled_input(event):
	if event.pressed:
		button_pressed=false
		if event.keycode == KEY_ESCAPE:
			return
		InputMap.action_erase_events(action)
		InputMap.action_add_event(action,event)

func update_key_text():
	text = "%s: %s" % [action.capitalize(),InputMap.action_get_events(action)[0].as_text()]
