getDirectPathToPoint: point Robot: sketchRobot
	| currentX currentY targetX targetY|
		currentX := sketchRobot location x.
		currentY := sketchRobot location y.
		targetX := point x.
		targetY := point y.
		" add x vals to the path"
		(targetX < currentX)ifTrue: [ 
				currentX to: targetX by: -1 do: [:x|
					pathToHighestDensityPoint addLast: (Array newFrom: {x . currentY})
		 		]
			 ]ifFalse:[
			currentX to: targetX do: [:x|
				pathToHighestDensityPoint addLast: (Array newFrom: {x . currentY})
		 	]
		].
	" add y vals to the path"
	(targetY < currentY)ifTrue: [ 
			currentY to: targetY by: -1 do: [:y|
				pathToHighestDensityPoint addLast: (Array newFrom: {targetX . y})
		 	]
		 ] ifFalse: [ 
			currentY to: targetY do: [:y|
				pathToHighestDensityPoint addLast: (Array newFrom: {targetX . y})
		 	]
		]
