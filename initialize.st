initialize 
	"COMPETITION ENTRIES _MAY_ OVERRIDE THIS METHOD.
	 This method is not part of the competition API, but a standard part of Pharo
	 called when objects are instatiated."
	doesYellowSquareExist := false.
	highestPointSquares := OrderedCollection new. 
	pathToHighestDensityPoint := OrderedCollection new.
	unreachablePoints := Set new.
	unreachablePointsBackup := Set new.
	hasHighDensityAreas := true.
	averageEnergy := -123456.
	depthNN := 3. "number of layers deep that the NN should look at"
	depthDijkstra := 4.
	directionList := OrderedCollection new.
	warpCellEndpoints := Dictionary new.
	super initialize
