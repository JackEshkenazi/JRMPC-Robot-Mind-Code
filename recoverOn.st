recoverOn: sketchRobot
	"COMPETITION ENTRIES _MAY_ OVERRIDE THIS METHOD.
	 If the mind doesn't complete its step within the designated time, its process is terminated.
	 Depending on how you manage your data objects, they may end up corrupted.
	 This method allows the mind to reset and continue playing.
 	 'sketchRobot' is a copy of the world as seen by the robot's scanners 
	"
	Transcript crShow: 'PROGRAM TOOK TOO LONG, EXITING'.
	self setupOn: sketchRobot
