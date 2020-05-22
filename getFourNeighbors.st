getFourNeighbors: point Robot: sketchRobot
	| x y right down left up|
	x := point x.
	y := point y.
	right := (sketchRobot map cellAt: (x+1)@y).
	down := (sketchRobot map cellAt: x@(y-1)).
	left := (sketchRobot map cellAt: (x-1)@y).
	up := (sketchRobot map cellAt: x@(y+1)).
	
	^(Array newFrom: {right . down . left . up})
