extends Node


signal game_over

enum Duration {
	INSTANT = 0,
	INFINITE,
	HAS_DURATION
}

enum Operation {
	ADD = 0,
	MULTIPLY,
	DIVIDE,
	OVERRIDE
}

var player: Player
var points := 0
var wave := 0
var upgraded := false
var cleared := false

func reset():
	points = 0
	wave = 0
	upgraded = false
	cleared = false
