aStar: startPoint Point: endPoint Robot: sketchRobot 
	"comment stating purpose of message"

	| x y neighbors openList closedList currentNode currentIndex startG startH startF endG endH endF Glist Hlist Flist currentF path cameFrom current |
	
    x := startPoint x.
    y := startPoint y.
	openList := Collection new.
	closedList := Collection new.
	
	startG := 0.
	startH := 0.
	startF := 0.
	endG := 0.
	endH := 0.
	endF := 0.
	
	Glist := Dictionary new.
	Hlist := Dictionary new.
	Flist := Dictionary new.
	
	openList add: startPoint.
	Glist at: startPoint put: 0.
	Flist at: startPoint put: 0.
	
	path := Collection new.
	cameFrom := Collection new.
	
	(openList size > 0)whileTrue:[	
		
		current := NullStream.
		currentF:= NullStream.
		
		currentNode := openList at: 0.
		currentF := Flist at: 0.
		currentIndex := 0.
		
		 1 to: openList size do: [ :index |
         | item |
         item := openList at: index.
			((current = NullStream) or: ((Flist at: index) < currentF))ifTrue:[
				currentNode := item.
				currentIndex := index.
					].				
			].
		
      openList remove: (openList at: currentIndex).
      closedList add: currentNode.
			
		(currentNode = endPoint)ifTrue:[
			current := currentNode.
			path := Collection new add: current.
			(cameFrom includes: current) whileTrue: [
				current := cameFrom at: currentIndex.
				path add: current.
				^path.
				].		 	 
			]. 
		
		x := currentNode x.
    	y := currentNode y.
		neighbors := self getFourNeighbors: x@y Robot: sketchRobot.
		
		1 to: (neighbors size) do: [ : neighborIndex|
        | neighbor |
        neighbor := (neighbors at: neighborIndex) location.
		  (closedList includes: neighbor)ifTrue: ["do nothing its been checked already"]ifFalse:[
			
			
			
			]		
		
		
	]. 
].
