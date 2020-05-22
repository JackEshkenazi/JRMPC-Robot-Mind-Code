determineWarpEndpoints: sketchRobot

	| width height |. "initilize the variable"
   width := sketchRobot map width.
   height := sketchRobot map height.
	
   1 to: height do:[:y | "assigns itterator number to y" 
       1 to: width do:[:x |
			| cell |
			cell := (sketchRobot map cellAt: x@y).
			(cell isMemberOf: WarpCell)ifTrue: [ 
				| endpoint |
				endpoint := cell target.
				warpCellEndpoints at: (cell location) put: endpoint.
				 ]
		]
	].
