setupOn: sketchRobot
	"COMPETITION ENTRIES _MAY_ OVERRIDE THIS METHOD.
	 This method facilitates initial setup of the mind related to the map parameters.
	 It is called once by the competition framework when the mind is instantiated.
 	 'sketchRobot' is a copy of the world as seen by the robot's scanners 
	"	
		
	self determineWarpEndpoints: sketchRobot.
	"Transcript crShow: (self greedyPath: sketchRobot location Point: 6@16 Robot: sketchRobot)."
