@tool
extends EditorPlugin

const CHARACTER_CONTROLLER_FORWARD := {
	"name": "move_forward",
	"events": [
		{
			"physical_keycode": KEY_W,
		}
	]
}

const CHARACTER_CONTROLLER_BACKWARD := {
	"name": "move_backward",
	"events": [
		{
			"physical_keycode": KEY_S,
		}
	]
}
const CHARACTER_CONTROLLER_RIGHT := {
	"name": "move_right",
	"events": [
		{
			"physical_keycode": KEY_D,
		}
	]
}

const CHARACTER_CONTROLLER_LEFT := {
	"name": "move_left",
	"events": [
		{
			"physical_keycode": KEY_A,
		}
	]
}

const CHARACTER_CONTROLLER_SPRINT := {
	"name": "move_sprint",
	"events": [
		{
			"physical_keycode": KEY_SHIFT,
		}
	]
}

const CHARACTER_CONTROLLER_JUMP := {
	"name": "move_jump",
	"events": [
		{
			"physical_keycode": KEY_SPACE,
		}
	]
}

const CHARACTER_CONTROLLER_CROUCH := {
	"name": "move_crouch",
	"events": [
		{
			"physical_keycode": KEY_CTRL,
		}
	]
}

const CHARACTER_CONTROLLER_FLY_MODE := {
	"name": "move_fly_mode",
	"events": [
		{
			"physical_keycode": KEY_F,
		}
	]
}

func register_inputs():
	#most of this is taken from Expresso Bits and Whimfoome character_controller addon
	const ACTIONS = [
		CHARACTER_CONTROLLER_FORWARD,
		CHARACTER_CONTROLLER_BACKWARD,
		CHARACTER_CONTROLLER_RIGHT,
		CHARACTER_CONTROLLER_LEFT,
		CHARACTER_CONTROLLER_SPRINT,
		CHARACTER_CONTROLLER_JUMP,
		CHARACTER_CONTROLLER_CROUCH,
		CHARACTER_CONTROLLER_FLY_MODE
	]
	# Register input events
	for action_props in ACTIONS:
		var setting_name = "input/" + action_props["name"]

		if not ProjectSettings.has_setting(setting_name):
			var events = []

			var action_props_events = action_props["events"]

			for event_data in action_props_events:
				var event = InputEventKey.new()
				for prop_name in event_data:
					event.set(prop_name, event_data[prop_name])

				events.append(event)

			ProjectSettings.set_setting(setting_name, {
				"deadzone": float(action_props["deadzone"] if "deadzone" in action_props else 0.5),
				"events": events
			})

	var result = ProjectSettings.save()
	assert(result == OK, "Failed to save project settings")


func _enter_tree() -> void: # Initialization of the plugin goes here.
	register_inputs()
	#add_custom_type("FPSPlayer","CharacterBody3D",preload("fps_player.gd"),preload("fpsplayer_icon.png"))

func _exit_tree() -> void: # Clean-up of the plugin goes here.
	#remove_custom_type("FPSPlayer")
	pass
