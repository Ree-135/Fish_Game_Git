extends Node

# Set state variables
enum State {
	OVERWORLD, # Player can move freely, click on book to open menu, and interact with fishing spots / other environmental things
	MINIGAME, # Player cannot move, click on book, or interact with fishing spots / other environmental things
	MENU # Player cannot move, click on book, or interact with fishing spots / other environmental things this is similar to MINIGAME but will have specific ui things later
}

# Current state variable
var current_state: State = State.OVERWORLD

# Function to change the state
func change_state(new_state: State):
	# Exit the current state
	exit_state(current_state)
	
	# Change to the new state
	current_state = new_state
	
	# Enter the new state
	enter_state(current_state)

# Function to handle entering a state
func enter_state(state: State):
	match state:
		State.OVERWORLD:
			print("Entering OverWorld")
			# Initialize OverWorld here
		State.MINIGAME:
			print("Entering MiniGame")
			# Initialize MiniGame here
		State.MENU:
			print("Entering Menu")
			# Initialize Menu here

# Function to handle exiting a state
func exit_state(state: State):
	match state:
		State.OVERWORLD:
			print("Exiting OverWorld")
			# Cleanup OverWorld here
		State.MINIGAME:
			print("Exiting MiniGame")
			# Cleanup MiniGame here
		State.MENU:
			print("Exiting Menu")
			# Cleanup Menu here
