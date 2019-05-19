!classDefinition: #MarsRoverTests category: #MarsRover!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTests methodsFor: 'tests' stamp: 'J.S 5/12/2019 15:36:19'!
test01DoesNothingWhenThereAreNoCommands
	
	|marsRover|

	marsRover := MarsRover at: 0@0 pointingTo: #North.
	
	marsRover execute: ''.
	
	self assert: marsRover IsAt: (0@0) pointingTo: #North.
	 ! !

!MarsRoverTests methodsFor: 'tests' stamp: 'J.S 5/12/2019 15:36:30'!
test02DoesNotExecuteInvalidCommand
	
	|marsRover|

	marsRover := MarsRover at: 0@0 pointingTo: #North.
	
	self 
		assertThat: [marsRover execute: 'x'. self fail.] 
		failsWithMessage: (MarsRover invalidCommandErrorMessage)
		thenAssert: [self assert: marsRover IsAt: (0@0) pointingTo: #North].
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'J.S 5/12/2019 15:36:40'!
test03MovesUpWhenPointingNorthAndGoesForward
	
	|marsRover|

	marsRover := MarsRover at: 0@0 pointingTo: #North.
	
	marsRover execute: 'f'.
	
	self assert: marsRover IsAt: (0@1) pointingTo: #North.
	 ! !

!MarsRoverTests methodsFor: 'tests' stamp: 'J.S 5/12/2019 15:36:48'!
test04MovesDownWhenPointingNorthAndGoesBackwards
	
	|marsRover|

	marsRover := MarsRover at: 0@0 pointingTo: #North.
	
	marsRover execute: 'b'.
	
	self assert: marsRover IsAt: (0@-1) pointingTo: #North.
	 ! !

!MarsRoverTests methodsFor: 'tests' stamp: 'J.S 5/12/2019 15:37:10'!
test05PointsEastWhenPointingNorthAndTurnsRight
	
	|marsRover|

	marsRover := MarsRover at: 0@0 pointingTo: #North.
	
	marsRover execute: 'r'.
	
	self assert: marsRover IsAt: (0@0) pointingTo: #East.
	 ! !

!MarsRoverTests methodsFor: 'tests' stamp: 'J.S 5/12/2019 15:37:21'!
test06PointsWestWhenPointingNorthAndTurnsLeft
	
	|marsRover|

	marsRover := MarsRover at: 0@0 pointingTo: #North.
	
	marsRover execute: 'l'.
	
	self assert: marsRover IsAt: (0@0) pointingTo: #West.! !

!MarsRoverTests methodsFor: 'tests' stamp: 'J.S 5/12/2019 15:37:35'!
test07MovesRightWhenPointingEastAndGoesForward
	
	|marsRover|

	marsRover := MarsRover at: 0@0 pointingTo: #East.
	
	marsRover execute: 'f'.
	
	self assert: marsRover IsAt: (1@0) pointingTo: #East.
	 ! !

!MarsRoverTests methodsFor: 'tests' stamp: 'J.S 5/12/2019 15:37:44'!
test08MovesLeftWhenPointingEastAndGoesBackwards
	
	|marsRover|

	marsRover := MarsRover at: 0@0 pointingTo: #East.
	
	marsRover execute: 'b'.
	
	self assert: marsRover IsAt: (-1@0) pointingTo: #East.
	 ! !

!MarsRoverTests methodsFor: 'tests' stamp: 'J.S 5/12/2019 15:37:57'!
test09PointsSouthWhenPointingEastAndTurnsRight
	
	|marsRover|

	marsRover := MarsRover at: 0@0 pointingTo: #East.
	
	marsRover execute: 'r'.
	
	self assert: marsRover IsAt: (0@0) pointingTo: #South.
	 ! !

!MarsRoverTests methodsFor: 'tests' stamp: 'J.S 5/12/2019 15:38:10'!
test10PointsNorthWhenPointingEastAndTurnsLeft
	
	|marsRover|

	marsRover := MarsRover at: 0@0 pointingTo: #East.
	
	marsRover execute: 'l'.
	
	self assert: marsRover IsAt: (0@0) pointingTo:#North.
	 ! !

!MarsRoverTests methodsFor: 'tests' stamp: 'J.S 5/12/2019 15:38:17'!
test11MovesDownWhenPointingSouthAndGoesForward
	
	|marsRover|

	marsRover := MarsRover at: 0@0 pointingTo: #South.
	
	marsRover execute: 'f'.
	
	self assert: marsRover IsAt: (0@-1) pointingTo: #South.
	 ! !

!MarsRoverTests methodsFor: 'tests' stamp: 'J.S 5/12/2019 15:38:28'!
test12MovesUpWhenPointingSouthAndGoesBackwards
	
	|marsRover|

	marsRover := MarsRover at: 0@0 pointingTo: #South.
	
	marsRover execute: 'b'.
	
	self assert: marsRover IsAt: (0@1) pointingTo: #South.
	 ! !

!MarsRoverTests methodsFor: 'tests' stamp: 'J.S 5/12/2019 15:38:40'!
test13PointsWestWhenPointingSouthAndTurnsRight
	
	|marsRover|

	marsRover := MarsRover at: 0@0 pointingTo: #South.
	
	marsRover execute: 'r'.
	
	self assert: marsRover IsAt: (0@0) pointingTo: #West.
	 ! !

!MarsRoverTests methodsFor: 'tests' stamp: 'J.S 5/12/2019 15:38:50'!
test14PointsEastWhenPointingSouthAndTurnsLeft
	
	|marsRover|

	marsRover := MarsRover at: 0@0 pointingTo: #South.
	
	marsRover execute: 'l'.
	
	self assert: marsRover IsAt: (0@0) pointingTo: #East.
	 ! !

!MarsRoverTests methodsFor: 'tests' stamp: 'J.S 5/12/2019 15:39:00'!
test15MovesLeftWhenPointingWestAndGoesForward
	
	|marsRover|

	marsRover := MarsRover at: 0@0 pointingTo: #West.
	
	marsRover execute: 'f'.
	
	self assert: marsRover IsAt: (-1@0) pointingTo: #West.
	 ! !

!MarsRoverTests methodsFor: 'tests' stamp: 'J.S 5/12/2019 15:39:09'!
test16MovesRightWhenPointingWestAndGoesBackwards
	
	|marsRover|

	marsRover := MarsRover at: 0@0 pointingTo: #West.
	
	marsRover execute: 'b'.
	
	self assert: marsRover IsAt: (1@0) pointingTo: #West.
	 ! !

!MarsRoverTests methodsFor: 'tests' stamp: 'J.S 5/12/2019 15:39:20'!
test17PointsNorthWhenPointingWestAndTurnsRight
	
	|marsRover|

	marsRover := MarsRover at: 0@0 pointingTo: #West.
	
	marsRover execute: 'r'.
	
	self assert: marsRover IsAt: (0@0) pointingTo: #North.
	 ! !

!MarsRoverTests methodsFor: 'tests' stamp: 'J.S 5/12/2019 15:39:34'!
test18PointsSouthWhenPointingWestAndTurnsLeft
	
	|marsRover|

	marsRover := MarsRover at: 0@0 pointingTo: #West.
	
	marsRover execute: 'l'.
	
	self assert: marsRover IsAt: (0@0) pointingTo: #South.
	 ! !

!MarsRoverTests methodsFor: 'tests' stamp: 'J.S 5/12/2019 15:39:51'!
test19ExecutesMultipleCommands
	
	|marsRover|

	marsRover := MarsRover at: 0@0 pointingTo: #North.

	marsRover execute: 'frf'.
	
	self assert: marsRover IsAt: (1@1) pointingTo: #East.
	
	 ! !

!MarsRoverTests methodsFor: 'tests' stamp: 'J.S 5/12/2019 15:40:03'!
test20StopsExecutingWhenEncountersInvalidCommand
	
	|marsRover|

	marsRover := MarsRover at: 0@0 pointingTo: #North.

	self 
		assertThat: [marsRover execute: 'fxr'. self fail.]
		failsWithMessage: (MarsRover invalidCommandErrorMessage)
		thenAssert: [self assert: marsRover IsAt: (0@1) pointingTo: #North].
	
	 ! !


!MarsRoverTests methodsFor: 'assertions' stamp: 'js 5/10/2019 21:10:27'!
assert: aMarsRover IsAt: aPoint pointingTo: aCardinalPoint
	
	self assert: (aMarsRover location = aPoint).
	self assert: (aMarsRover direction = aCardinalPoint).! !

!MarsRoverTests methodsFor: 'assertions' stamp: 'js 5/10/2019 23:00:51'!
assertThat: aBlockToExecute failsWithMessage: anErrorMessage thenAssert: anAssertionBlock

	[aBlockToExecute value. self fail.]
		on: Error
		do: anAssertionBlock
	! !


!classDefinition: #CommandExecutor category: #MarsRover!
Object subclass: #CommandExecutor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CommandExecutor methodsFor: 'actions' stamp: 'js 5/10/2019 22:40:38'!
executeTo: aDirectionState

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CommandExecutor class' category: #MarsRover!
CommandExecutor class
	instanceVariableNames: ''!

!CommandExecutor class methodsFor: 'testing' stamp: 'js 5/10/2019 22:37:23'!
canHandle: aCommand

	self subclassResponsibility .! !


!classDefinition: #GoBackwardsCommandExecutor category: #MarsRover!
CommandExecutor subclass: #GoBackwardsCommandExecutor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!GoBackwardsCommandExecutor methodsFor: 'actions' stamp: 'js 5/10/2019 22:41:57'!
executeTo: aDirectionState

	aDirectionState moveBackwards.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GoBackwardsCommandExecutor class' category: #MarsRover!
GoBackwardsCommandExecutor class
	instanceVariableNames: ''!

!GoBackwardsCommandExecutor class methodsFor: 'testing' stamp: 'js 5/10/2019 22:36:59'!
canHandle: aCommand

	^ aCommand = $b.! !


!classDefinition: #GoForwardCommandExecutor category: #MarsRover!
CommandExecutor subclass: #GoForwardCommandExecutor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!GoForwardCommandExecutor methodsFor: 'actions' stamp: 'js 5/10/2019 22:42:08'!
executeTo: aDirectionState

	aDirectionState moveForward .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GoForwardCommandExecutor class' category: #MarsRover!
GoForwardCommandExecutor class
	instanceVariableNames: ''!

!GoForwardCommandExecutor class methodsFor: 'testing' stamp: 'js 5/10/2019 22:36:46'!
canHandle: aCommand

	^ aCommand = $f.! !


!classDefinition: #RotateLeftCommandExecutor category: #MarsRover!
CommandExecutor subclass: #RotateLeftCommandExecutor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateLeftCommandExecutor methodsFor: 'actions' stamp: 'js 5/10/2019 22:42:26'!
executeTo: aDirectionState

	aDirectionState rotateLeft.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateLeftCommandExecutor class' category: #MarsRover!
RotateLeftCommandExecutor class
	instanceVariableNames: ''!

!RotateLeftCommandExecutor class methodsFor: 'testing' stamp: 'js 5/10/2019 22:36:31'!
canHandle: aCommand

	^ aCommand = $l.! !


!classDefinition: #RotateRightCommandExecutor category: #MarsRover!
CommandExecutor subclass: #RotateRightCommandExecutor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateRightCommandExecutor methodsFor: 'actions' stamp: 'js 5/10/2019 22:42:39'!
executeTo: aDirectionState

	aDirectionState rotateRight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateRightCommandExecutor class' category: #MarsRover!
RotateRightCommandExecutor class
	instanceVariableNames: ''!

!RotateRightCommandExecutor class methodsFor: 'testing' stamp: 'js 5/10/2019 22:36:39'!
canHandle: aCommand

	^ aCommand = $r.! !


!classDefinition: #DirectionState category: #MarsRover!
Object subclass: #DirectionState
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!DirectionState methodsFor: 'initialization' stamp: 'js 5/10/2019 20:04:13'!
initializeWith: aMarsRover

 	marsRover := aMarsRover.! !


!DirectionState methodsFor: 'actions' stamp: 'js 5/10/2019 22:25:53'!
moveBackwards

	self subclassResponsibility.! !

!DirectionState methodsFor: 'actions' stamp: 'js 5/10/2019 22:26:00'!
moveForward

	self subclassResponsibility.! !

!DirectionState methodsFor: 'actions' stamp: 'js 5/10/2019 22:26:49'!
rotateLeft

	self subclassResponsibility.! !

!DirectionState methodsFor: 'actions' stamp: 'js 5/10/2019 22:26:45'!
rotateRight

	self subclassResponsibility.! !


!DirectionState methodsFor: 'getters' stamp: 'js 5/10/2019 22:25:33'!
direction
	
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DirectionState class' category: #MarsRover!
DirectionState class
	instanceVariableNames: ''!

!DirectionState class methodsFor: 'initialization' stamp: 'js 5/10/2019 20:03:24'!
with: aMarsRover

	^self new initializeWith: aMarsRover! !


!DirectionState class methodsFor: 'testing' stamp: 'js 5/10/2019 22:38:32'!
canHandle: aCardinalPoint

	self subclassResponsibility.! !


!classDefinition: #PointingEast category: #MarsRover!
DirectionState subclass: #PointingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!PointingEast methodsFor: 'getters' stamp: 'J.S 5/12/2019 15:35:37'!
direction

	^ #East.! !


!PointingEast methodsFor: 'actions' stamp: 'js 5/10/2019 21:24:07'!
moveBackwards

	marsRover moveLeft.! !

!PointingEast methodsFor: 'actions' stamp: 'js 5/10/2019 21:22:40'!
moveForward

	marsRover moveRight.! !

!PointingEast methodsFor: 'actions' stamp: 'J.S 5/13/2019 10:40:48'!
rotateLeft

	marsRover pointTo: #North.! !

!PointingEast methodsFor: 'actions' stamp: 'J.S 5/13/2019 10:40:54'!
rotateRight

	marsRover pointTo: #South.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PointingEast class' category: #MarsRover!
PointingEast class
	instanceVariableNames: ''!

!PointingEast class methodsFor: 'testing' stamp: 'js 5/10/2019 22:22:39'!
canHandle: aCardinalPoint 

	^ aCardinalPoint = 'East'.! !


!classDefinition: #PointingNorth category: #MarsRover!
DirectionState subclass: #PointingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!PointingNorth methodsFor: 'getters' stamp: 'J.S 5/12/2019 15:35:47'!
direction

	^ #North.! !


!PointingNorth methodsFor: 'actions' stamp: 'js 5/10/2019 20:51:38'!
moveBackwards

	marsRover moveDown.! !

!PointingNorth methodsFor: 'actions' stamp: 'js 5/10/2019 20:43:35'!
moveForward

	marsRover moveUp.! !

!PointingNorth methodsFor: 'actions' stamp: 'J.S 5/13/2019 10:41:00'!
rotateLeft

	marsRover pointTo: #West.! !

!PointingNorth methodsFor: 'actions' stamp: 'J.S 5/13/2019 10:41:06'!
rotateRight

	marsRover pointTo: #East.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PointingNorth class' category: #MarsRover!
PointingNorth class
	instanceVariableNames: ''!

!PointingNorth class methodsFor: 'testing' stamp: 'js 5/10/2019 22:22:49'!
canHandle: aCardinalPoint 

	^ aCardinalPoint = 'North'.! !


!classDefinition: #PointingSouth category: #MarsRover!
DirectionState subclass: #PointingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!PointingSouth methodsFor: 'getters' stamp: 'J.S 5/12/2019 15:35:55'!
direction

	^ #South.! !


!PointingSouth methodsFor: 'actions' stamp: 'js 5/10/2019 21:30:58'!
moveBackwards

	marsRover moveUp.! !

!PointingSouth methodsFor: 'actions' stamp: 'js 5/10/2019 21:30:14'!
moveForward

	marsRover moveDown.! !

!PointingSouth methodsFor: 'actions' stamp: 'J.S 5/13/2019 10:41:12'!
rotateLeft

	marsRover pointTo: #East.! !

!PointingSouth methodsFor: 'actions' stamp: 'J.S 5/13/2019 10:41:17'!
rotateRight

	marsRover pointTo: #West.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PointingSouth class' category: #MarsRover!
PointingSouth class
	instanceVariableNames: ''!

!PointingSouth class methodsFor: 'testing' stamp: 'js 5/10/2019 21:27:34'!
canHandle: aCardinalPoint 

	^ aCardinalPoint = 'South'. ! !


!classDefinition: #PointingWest category: #MarsRover!
DirectionState subclass: #PointingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!PointingWest methodsFor: 'getters' stamp: 'J.S 5/12/2019 15:36:02'!
direction

	^ #West.! !


!PointingWest methodsFor: 'actions' stamp: 'js 5/10/2019 21:35:17'!
moveBackwards

	marsRover moveRight.! !

!PointingWest methodsFor: 'actions' stamp: 'js 5/10/2019 21:34:44'!
moveForward

	marsRover moveLeft.! !

!PointingWest methodsFor: 'actions' stamp: 'J.S 5/13/2019 10:41:25'!
rotateLeft

	marsRover pointTo: #South.! !

!PointingWest methodsFor: 'actions' stamp: 'J.S 5/13/2019 10:41:31'!
rotateRight

	marsRover pointTo: #North.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PointingWest class' category: #MarsRover!
PointingWest class
	instanceVariableNames: ''!

!PointingWest class methodsFor: 'testing' stamp: 'js 5/10/2019 22:23:08'!
canHandle: aCardinalPoint 

	^ aCardinalPoint = 'West'.! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'location directionState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'js 5/10/2019 21:05:03'!
at: aPoint pointingTo: aCardinalPoint

	self pointTo: aCardinalPoint.
	location := aPoint.! !


!MarsRover methodsFor: 'actions' stamp: 'js 5/10/2019 22:56:03'!
execute: commands 

	commands do: [ :aCommand | 
		| aCommandExecutor |
		
		aCommandExecutor := (CommandExecutor subclasses 
			detect: [: aCommandExecutorClass | aCommandExecutorClass canHandle: aCommand]  
			ifNone: [self error: MarsRover invalidCommandErrorMessage.]) new. 
			
		aCommandExecutor executeTo: directionState.
	].
! !


!MarsRover methodsFor: 'getters' stamp: 'js 5/10/2019 20:31:03'!
direction

	^ directionState direction! !

!MarsRover methodsFor: 'getters' stamp: 'js 5/10/2019 20:47:01'!
location

	^ location.! !


!MarsRover methodsFor: 'private' stamp: 'js 5/10/2019 20:52:09'!
moveDown

	location := (location x)@(location y - 1).! !

!MarsRover methodsFor: 'private' stamp: 'js 5/10/2019 21:24:28'!
moveLeft

	location := (location x - 1)@(location y).! !

!MarsRover methodsFor: 'private' stamp: 'js 5/10/2019 21:23:03'!
moveRight

	location := (location x + 1)@(location y).! !

!MarsRover methodsFor: 'private' stamp: 'js 5/10/2019 20:45:25'!
moveUp

	location := (location x)@(location y + 1).! !

!MarsRover methodsFor: 'private' stamp: 'js 5/10/2019 20:56:37'!
pointTo: aCardinalPoint 
	
	directionState := (DirectionState subclasses 
		detect: [:aDirectionState | aDirectionState canHandle: aCardinalPoint] 
		ifNone:[self error: MarsRover invalidCardinalPointErrorMessage]) 
		with: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'js 5/10/2019 20:12:32'!
at: aPoint pointingTo: aCardinalPoint 

	^self new at: aPoint pointingTo: aCardinalPoint.! !

!MarsRover class methodsFor: 'initialization' stamp: 'js 5/10/2019 22:30:22'!
invalidCardinalPointErrorMessage

	^ 'Invalid cardinal point'.! !

!MarsRover class methodsFor: 'initialization' stamp: 'js 5/10/2019 22:30:07'!
invalidCommandErrorMessage 

	^ 'Command is invalid'.! !
