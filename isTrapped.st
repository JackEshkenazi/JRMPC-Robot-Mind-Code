isTrapped: point Robot: sketchRobot Integer: count Set: squares
    "comment stating purpose of message"

    | x y neighbors|
    x := point x.
    y := point y.

    "get the first neighbors arround the current point passed in as a parameter"
    neighbors := self getFourNeighbors: x @ y Robot: sketchRobot.
    (count = 0)ifTrue: [ ^ squares ]
        ifFalse: [ 
            1 to: neighbors size do: [ :neighborIndex |
                | neighbor |
                neighbor := neighbors at: neighborIndex.
                (neighbor isMemberOf: DeathCell)
                    ifFalse: [ 
                        squares add: neighbor location.
                        squares addAll:(self isTrapped: neighbor location Robot: sketchRobot Integer: count - 1 Set: squares).
                        
                        ] 
                    ].
                 ^ squares 
                ]
