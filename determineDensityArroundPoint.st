determineDensityArroundPoint: point Robot: sketchRobot
    | neighborQueue neighbors totalEnergy x y currentCell|.
    x := point x.
    y := point y.
    totalEnergy := 0.
    neighborQueue := OrderedCollection new.
	currentCell := sketchRobot map cellAt: x@y.
	
	"check if our central cell is either a death call or a warp cell"
	(currentCell isMemberOf: WarpCell)ifTrue: [ 
		x := currentCell target x.
		y := currentCell target y.
		totalEnergy := (sketchRobot map cellAt: (currentCell target)) energy. 
		 ]ifFalse:[
			(currentCell isMemberOf: DeathCell )ifTrue: [ 
				^0.
				 ]ifFalse:[
				totalEnergy := currentCell energy.
				]
		].

    "get the first neighbors arround the current point passed in as a parameter"
    neighbors := self getFourNeighbors: x@y Robot: sketchRobot.
    1 to: (neighbors size) do: [ : neighborIndex|
        | neighbor neighborLocation|
        neighbor := (neighbors at: neighborIndex).
		  neighborLocation := neighbor location.
        (neighborQueue includes: neighborLocation)ifFalse: [ 
            (neighbor isMemberOf: DeathCell)ifFalse:[
                neighborQueue addLast: neighborLocation.
                	].
				"(neighbor isMemberOf: WarpCell)ifTrue:[
                neighborQueue addLast: (neighborLocation).
                	]"
                ]
            ].
    "get the second order neighbors arround those first points"
    1 to: (neighborQueue size) do: [ : i|
        neighbors := self getFourNeighbors: (neighborQueue at: i) Robot: sketchRobot.
        1 to: (neighbors size) do: [ : neighborIndex|
            | neighbor neighborLocation|
        neighbor := (neighbors at: neighborIndex).
		  neighborLocation := neighbor location.
        (neighborQueue includes: neighborLocation)ifFalse: [ 
            (neighbor isMemberOf: DeathCell)ifFalse:[
                neighborQueue addLast: neighborLocation.
                	].
				"(neighbor isMemberOf: WarpCell)ifTrue: [
                neighborQueue addLast: (neighborLocation).
                	]"
                ]
            ]
    ].
    "once we have a list of all the neighbors arround the given point, sum up the point values for those neighbors"
    1 to: (neighborQueue size) do: [ : i|
        | neighbor |
        neighbor := neighborQueue at: i.
            totalEnergy := totalEnergy + ((sketchRobot map cellAt: neighbor) energy)
        ].
    ^totalEnergy.
	
