extends CSGCylinder3D

@export var controller_number = 70
@export var value = 0

func _ready():
	OS.open_midi_inputs()
	print(OS.get_connected_midi_inputs())
	print("midi dial ready")

func _input(input_event):
	if input_event is InputEventMIDI:
		if input_event.controller_number == controller_number:
			value = input_event.controller_value
			rotation.y=1-value/25.0
			$Label3D.text=str(value)
#		_print_midi_info(input_event)

func _print_midi_info(midi_event: InputEventMIDI):
	print(midi_event)
	print("Channel " + str(midi_event.channel))
	print("Message " + str(midi_event.message))
	print("Pitch " + str(midi_event.pitch))
	print("Velocity " + str(midi_event.velocity))
	print("Instrument " + str(midi_event.instrument))
	print("Pressure " + str(midi_event.pressure))
	print("Controller number: " + str(midi_event.controller_number))
	print("Controller value: " + str(midi_event.controller_value))
