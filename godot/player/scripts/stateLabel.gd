extends Label


@export var state_machine : BaseCharacterStateMachine

func _process(delta):
	text = "State : " + state_machine.currentState.name + ", " + state_machine.currentState.currentState.name
