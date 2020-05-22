DetermineRobotMovementFromPoint: point Robot: sketchRobot
	| fourNeighbors directionDict|
	fourNeighbors := sketchRobot fourNeighbors. "retunrs a list formated as follows: [right, down, left, up]"
	directionDict := Dictionary newFrom: {1 -> RobotEast soleInstance . 2 -> RobotSouth soleInstance . 3 -> RobotWest soleInstance . 4 -> RobotNorth soleInstance .}.
	1 to: 4 do: [ 
				: neighborIndex|
				|neighbor neighborPoint|.
				neighbor := (fourNeighbors at: neighborIndex). 
				neighborPoint := Array newFrom: {(neighbor location x) . (neighbor location y)}.
				(neighborPoint = point)ifTrue: [ 
					^(directionDict at: neighborIndex)
				].
	].
	"if the program gets here it most likley means that we have either warped or jumped since the path will not be out of bounds of the current robot point"
	directionList := OrderedCollection new.
	pathToHighestDensityPoint := OrderedCollection new.
	
