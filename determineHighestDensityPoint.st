determineHighestDensityPoint: sketchRobot
	| width height maxEnergy maxEnergyPoint totalEnergyOnGrid pointDensities highestDensityPointList|. "initilize the variable"
   width := sketchRobot map width.
   height := sketchRobot map height.
	totalEnergyOnGrid := 0 .
	maxEnergy := -10000000000. 
	maxEnergyPoint := 1@1.
	pointDensities := Dictionary new.
	
   1 to: height do:[:y | "assigns itterator number to y" 
       1 to: width do:[:x |
			| totalEnergy |
			totalEnergy := self determineDensityArroundPoint: x@y Robot: sketchRobot.
			totalEnergyOnGrid := totalEnergyOnGrid + totalEnergy.
			((sketchRobot map cellAt: x@y) isMemberOf: DeathCell)ifFalse:[	
				pointDensities at: totalEnergy put: x@y
			]
		]
	].
	
	averageEnergy := (totalEnergyOnGrid / ((width) * (height))) asInteger .
	highestDensityPointList := ((pointDensities keys sorted) reversed).
	1 to: (highestDensityPointList size) do: [ :i |
		| density point path|
		density := highestDensityPointList at: i.
		point := pointDensities at: density.	
		((unreachablePoints includes: point) and: (unreachablePointsBackup includes: point))ifFalse:[
		"(unreachablePoints includes: point)ifFalse:["
			path := (self greedyPath: (sketchRobot location) Point: point Robot: sketchRobot).
			(path isEmpty )ifFalse: [
				maxEnergy := density.
				(unreachablePoints includes: point)ifTrue:[
					unreachablePoints remove: point.
				].
				(unreachablePointsBackup includes: point)ifTrue:[
					unreachablePointsBackup remove: point.
				].
				maxEnergyPoint := point.
				^maxEnergyPoint.
				]ifTrue:[
				"this implements a 'two strike' approach in order to determine if a point is actually unreachable and not just that we checkedd for that point within a deathbox"
					(unreachablePoints includes: point)ifFalse:[
						unreachablePoints add: point.
					]ifTrue:[
						(unreachablePointsBackup includes: point)ifFalse:[
							"Transcript crShow: unreachablePoints.
							Transcript crShow: unreachablePointsBackup."
							unreachablePointsBackup add: point.
							]
						]
				]
		 ]
	].

	
	
	
	
	
	"(totalEnergy > maxEnergy)ifTrue: [ 
					| path |
					
					((sketchRobot map cellAt: x@y) isMemberOf: DeathCell)ifFalse:[
						path := (self greedyPath: (sketchRobot location) Point: x@y Robot: sketchRobot).
						
						(path isEmpty )ifFalse: [
							maxEnergy := totalEnergy.
							maxEnergyPoint := x@y
				 		]
				]
			]"

