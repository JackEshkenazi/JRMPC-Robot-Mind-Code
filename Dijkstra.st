Dijkstra: sketchRobot
	"create a new list of all points within the robots scanning radius ----------------------------------------"

	| grid pointsList x y highestPoint startingPoint distanceFromStart previousVertex visited unVisited shortestPathLength bestPath scanningRadius |
	"Transcript crShow: 'Dijkstra HAS BEEN CALLED -----------------------------------------------------'."
	
	scanningRadius := depthDijkstra.
	grid := OrderedCollection new.
	pointsList := OrderedCollection new.
	x := sketchRobot location x.
	y := sketchRobot location y.
	1 to: scanningRadius * 2 + 1 do: [ :xCord | 
		1 to: scanningRadius * 2 + 1 do: [ :yCord | 
			| xPoint yPoint point |
			xPoint := x - scanningRadius + xCord - 1.
			yPoint := y - scanningRadius + yCord - 1.
			"this will take a given coordinate and it wrap around the board"
			point := self standardizePoint: xPoint Integer: yPoint	Integer: sketchRobot map width	Integer: sketchRobot map height.
			(grid includes: point) ifFalse: [ "sometimes you get repeats because of the point standardization"
					| pointValue pointObj|
					grid addLast: point.
					pointObj := (sketchRobot map cellAt: (point at: 1) @ (point at: 2)).
					(pointObj isMemberOf: WarpCell)ifTrue: [ 
							| maxNeighborEnergy warpCellNeighbors|
							maxNeighborEnergy := 0.
							warpCellNeighbors := self getFourNeighbors: (pointObj target) Robot: sketchRobot.
							1 to: warpCellNeighbors size do: [ :index | 
								(((warpCellNeighbors at: index) energy) > maxNeighborEnergy)ifTrue:[
									maxNeighborEnergy := ((warpCellNeighbors at: index) energy)
									]
								].
									pointValue := maxNeighborEnergy.
					]ifFalse:[
						pointValue := pointObj energy.
					].
				pointsList addLast: pointValue .
			]
		] 
	].

	"initialization stuff -------------------------------------------------------------------------------------------------------------------------------"
	"find the highest point since we will be subtracting the value of all other points from this in order to find the cost to move to a square"
	highestPoint := pointsList max.
	startingPoint := Array newFrom:{x . y}.
	distanceFromStart := Dictionary new.
	previousVertex := Dictionary new.
	visited := OrderedCollection new.
	unVisited := grid copy.
	"Transcript crShow: 'STARTING POINT'.
	Transcript show: startingPoint."
	
	" set all distances to infinity and initlize previous distance dict with default keys"
	1 to: grid size do: [ :i | 
		| point |
		point := grid at: i.
		distanceFromStart at: point put: 1000000.	"1 million, number must be very large because distance from starting point to all other points is unkown at this point"
		previousVertex at: point put: (Array newFrom: #(-1 -1)) ].
	distanceFromStart at: startingPoint put: 0.
	
	
	"point visit loop --------------------------------------------------------------------------------------------"
	[ unVisited size > 0 ]whileTrue: [ | currentPoint minValue neighbors |
			"find min value in distanceFromStart dict"
			minValue := 10000000.	"10 million"
			distanceFromStart	keysAndValuesDo: [ :key :value | 
					((value < minValue) & ((visited includes: key) not))	ifTrue: [ 
							currentPoint := key.
							minValue := value 
							]
						 ].
			
			"iterate through neighbors"
			neighbors := self	getFourNeighbors: (currentPoint at: 1) @ (currentPoint at: 2)	Robot: sketchRobot.
			1 to: neighbors size do: [ :i | 
				| neighbor neighborPoint |
				neighbor := neighbors at: i.
				neighborPoint := Array newFrom: {neighbor location x. neighbor location y}.
				(grid includes: neighborPoint)ifTrue: [ | distance distanceFromNeighbor neighborEnergy|
						(neighbor isMemberOf: DeathCell)ifTrue: [ 
							neighborEnergy := -1000000.
							 ]ifFalse:[
								(neighbor isMemberOf: WarpCell)ifTrue: [ 
									| maxNeighborEnergy warpCellNeighbors|
									maxNeighborEnergy := 0.
									warpCellNeighbors := self getFourNeighbors: (neighbor target) Robot: sketchRobot.
									1 to: warpCellNeighbors size do: [ :index | 
										(((warpCellNeighbors at: index) energy) > maxNeighborEnergy)ifTrue:[
											maxNeighborEnergy := ((warpCellNeighbors at: index) energy)
											]
										].
									neighborEnergy := maxNeighborEnergy.
								]ifFalse:[
									neighborEnergy := neighbor energy.
								]
							].
						distance := (distanceFromStart at: currentPoint) + (highestPoint - neighborEnergy).
						distanceFromNeighbor := distanceFromStart at: neighborPoint.
						(distance < distanceFromNeighbor) ifTrue: [ 
								distanceFromStart at: neighborPoint put: distance.
								previousVertex at: neighborPoint put: currentPoint 
								] 
							] 
						].
			visited addLast: currentPoint.
			unVisited remove: currentPoint 
			].
	
	"while loop has exited meaning that the shortest path has been found ---------------------------------------------------------------------------"
	shortestPathLength := 1000000.	"1 million"
	bestPath := OrderedCollection new.
	[ bestPath isEmpty ]
		whileTrue: [ 1 to: grid size do: [ :i | 
				| point |
				point := grid at: i.
				((distanceFromStart at: point) < shortestPathLength	& (point = startingPoint) not )ifTrue: [ "point is not equal to starting point"
						| path newPoint shouldBreak |
						path := OrderedCollection new.
						"work backwards from best point to find optimal path"
						path addLast: point.	"the point we are trying to is the first item since the list will be reversed"
						newPoint := point.	"initialize newPoint w since this will be reassigned in the while loop"
						shouldBreak := false.
						[ shouldBreak ]whileFalse:[
							 newPoint := previousVertex at: newPoint.	"get the previous point and add it to the list"
								path addLast: newPoint.
								newPoint = startingPoint
									ifTrue: [ "if the starting point is equal to current point we found a path"
										"sometimes the newPoint will be equal to starting point but less than scanningRadius so we need to break"
										path size > scanningRadius
											ifTrue: [ 
												shortestPathLength := distanceFromStart at: point.
												bestPath := path	"this best path is only truly the best once the while loop has exited" 
													].
										shouldBreak := true 
										].
								path size > (scanningRadius * 4)
									ifTrue: [ shouldBreak := true 
										] 
									] 
								] 
							].
			"Transcript crShow: 'could not find path'."
			scanningRadius := scanningRadius - 1 
			].
	bestPath removeLast.
	bestPath := bestPath reversed.
	directionList := bestPath
