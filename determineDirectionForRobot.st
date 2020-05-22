determineDirectionForRobot: sketchRobot 
    "COMPETITION ENTRIES _MUST_ OVERRIDE THIS METHOD.
     This method is the main entrypoint for competition entries.
     It is called each time the game world progresses one step in time.
     'sketchRobot' is a copy of the map/robots as seen by a robot's scanners (i.e. no internal state). 
     Each time step provides a new independent scan 'sketchRobot'.
     The mind instance remains constant across steps (i.e. it has memory across time steps).  
     The actual map/robots remain inaccessible to prevent accidental corruption of the game.
    "
	| point |
	(averageEnergy = -123456)ifTrue: [ "this will only get called once when the robot is setup since the average point value is not known"
		| highestDensityPoint densityOfPoint|
		highestDensityPoint := self determineHighestDensityPoint: sketchRobot.
		densityOfPoint := self determineDensityArroundPoint: highestDensityPoint Robot: sketchRobot. 
		(densityOfPoint > (averageEnergy * 3))ifTrue: [ 
			"self getDirectPathToPoint: highestDensityPoint  Robot: sketchRobot."
			pathToHighestDensityPoint := self greedyPath: (sketchRobot location) Point: highestDensityPoint Robot: sketchRobot.
			]
		].
	
	
	"this block of code checks to see if there s another high density point on the board that we can navigate to once we finish getting all the cells in the imediate vicinity"
	((pathToHighestDensityPoint isEmpty) and: (directionList size = 1))ifTrue: [ 
			| density highestDensityPoint |
			density := self determineDensityArroundPoint: (sketchRobot location) Robot: sketchRobot.
			(density < (averageEnergy))ifTrue: [ 
				| densityOfPoint |
				highestDensityPoint := self determineHighestDensityPoint: sketchRobot.
				densityOfPoint := self determineDensityArroundPoint: highestDensityPoint Robot: sketchRobot. 
				((densityOfPoint > (averageEnergy * 3) and: (density < (averageEnergy * 0.7))) or: (density < 0))ifTrue: [ 
					"self getDirectPathToPoint: highestDensityPoint Robot: sketchRobot."
					pathToHighestDensityPoint := (self greedyPath: ((directionList first at: 1)@(directionList first at: 2)) Point: highestDensityPoint Robot: sketchRobot).
				 ]
			]
		 ].
	
	
	
		(directionList isEmpty)ifTrue: [ 
			(pathToHighestDensityPoint isEmpty)ifFalse: [ 
				point := pathToHighestDensityPoint first.
				pathToHighestDensityPoint removeAt: 1.
			]ifTrue:[
				self Dijkstra: sketchRobot. 
				point := directionList first.
				directionList removeAt: 1.
				]
		 ]ifFalse:[
			point := directionList first.
			directionList removeAt: 1.
		].
		
	direction := (self DetermineRobotMovementFromPoint: point Robot: sketchRobot). 
	
