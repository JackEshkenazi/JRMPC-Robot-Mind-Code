standardizePoint: xPoint Integer: yPoint Integer: columns Integer: rows
	"this will take a given coordinate and it wrap around the board"
	| newXPoint newYPoint |.
	
	newXPoint := ((xPoint \\ columns) abs). "\\ is the same as % in python, coordinate system starts at 1,1 so we need to shift everything by 1"
	newYPoint := ((yPoint \\ rows) abs).
	
	(xPoint = 0)ifTrue: [ 
		newXPoint := columns 
		 ].
	(newXPoint = 0)ifTrue: [ 
		newXPoint := columns 
		 ].
	(yPoint = 0)ifTrue: [ 
		newYPoint := rows 
		 ].
	(newYPoint = 0)ifTrue: [ 
		newYPoint := rows 
		 ].
	
	^ Array newFrom: {newXPoint . newYPoint}.
