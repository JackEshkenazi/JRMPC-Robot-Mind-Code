greedyPath: startPoint Point: endPoint Robot: sketchRobot
    "comment stating purpose of message"

    | priority neighbors current cameFrom path |
    
    priority := Dictionary new.
    cameFrom := Dictionary new.
    path := OrderedCollection new.
    
    cameFrom at: startPoint put: -1000.
    priority at: startPoint put: 0.

    [(priority size > 0) and: ((priority size) < ((sketchRobot map width) * 1.5) asInteger)]whileTrue:[
        | minValue |
        minValue := priority values min.
        priority keysAndValuesDo:[ :key :value |
            (value = minValue)ifTrue:[
                current := key ].
            ].
        
        priority removeKey: current.
        
        (current = endPoint)ifTrue:[
            [current = -1000]whileFalse:[
                path add: (Array newFrom: {current x . current y}).
                current := cameFrom at: current
                ].
				path removeLast.
            path := path reversed.
            ^path.]
            ifFalse:[
            neighbors := self getFourNeighbors: current Robot: sketchRobot.
            1 to: neighbors size do: [ :neighborIndex |
                | neighbor |
                neighbor := neighbors at: neighborIndex.
                         (neighbor isMemberOf: DeathCell)ifFalse: [ 
                    ((cameFrom keys) includes: (neighbor location))ifFalse:[
                            (neighbor energy <= -100000)ifTrue:[
                        priority at: (neighbor location) put: (2*((neighbor location x - endPoint x) abs + (neighbor location y - endPoint y) abs)).
                        cameFrom at: (neighbor location) put: current.
								] ifFalse:[
                               priority at: (neighbor location) put: (((neighbor location x - endPoint x) abs + (neighbor location y - endPoint y) abs)).
                        			cameFrom at: (neighbor location) put: current
].
].
        ].].].].
	^(OrderedCollection new) 
