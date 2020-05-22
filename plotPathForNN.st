plotPathForNN: sketchRobot
	"variable initilization"
	| currentItterations x y paths firstPath pathID pathEnergies bestPathID bestPath|
	currentItterations := 1.
	x := sketchRobot location x.
	y := sketchRobot location y.
	pathID := 1.
	pathEnergies := Dictionary newFrom: {1 -> 0.}.
	
	"paths = {0:[(x, y)]} in python"
	firstPath := OrderedCollection new.
	firstPath add: (Array newFrom: {x . y}). "creates a dynamic array at runtime instead of a literal array where the values must be known, the elements of this array need to be separated by a dot"
	paths := Dictionary newFrom: {1 -> firstPath.}. 
	
	[currentItterations <= depthNN] whileTrue: [ 
		|newPaths|.
		newPaths := Dictionary new.
		((paths keys sorted) first) to: ((paths keys sorted) last) do: [ 
			:key|
			|path neighbors|.	
			path := paths at: key.
			"Transcript crShow: (self getFourNeighbors: ((path last) at: 1)@((path last) at: 2) Robot: sketchRobot)."
			neighbors := self getFourNeighbors: ((path last) at: 1)@((path last) at: 2) Robot: sketchRobot. "retunrs a list formated as follows: [right, down, left, up]"
			1 to: 4 do: [ 
				: neighborIndex|
				|neighbor neighborPoint|.
				neighbor := (neighbors at: neighborIndex). 
				neighborPoint := Array newFrom: {(neighbor location x) . (neighbor location y)}.
				"Transcript crShow: path.
				Transcript crShow: neighborPoint.	"	
				(path includes: neighborPoint )ifFalse: [
					 |newVal newPath|.
					newVal := (pathEnergies at: key) + (neighbor energy).
					newPath := path copy.
					newPath addLast: neighborPoint.
					newPaths at: pathID put: newPath.
					pathEnergies at: pathID put: newVal.
					pathID := (pathID + 1) 
					
					
					]
				ifTrue:[
					"Transcript crShow: path.
					Transcript crShow: (Array newFrom: {(neighbor location x) . (neighbor location y)}).
					Transcript crShow: 'DOES  INCLUDE'."
					].
				 ]. 
			 ].
		paths := newPaths copy.
		currentItterations := currentItterations + 1.
		 ].
	bestPathID  := 0.
	1 to: ((pathEnergies values) size) do: [ 
			:key|
			((pathEnergies values max) = (pathEnergies at: key))ifTrue:[
				bestPathID := key
				].
			].
	bestPath := paths at: bestPathID.
	bestPath removeAt: 1.
	directionList := bestPath. "stores best path as a instance variable"
	
	
	
	
