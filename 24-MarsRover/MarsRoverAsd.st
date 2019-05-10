!classDefinition: #MarsRoverTests category: #MarsRover!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'js 5/6/2019 21:56:57'!
test01
	
	|aPoint aDirection rover|
	
	aPoint := Point x: 0 y: 0.
	aDirection := NorthDirection new.
	rover := (MarsRover withLocation: aPoint andPointingTo: aDirection).
	
	rover execute: ''.
	
	self assert: (rover position = (0@0)).
	self assert: (rover direction = aDirection)
	 ! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'js 5/6/2019 21:56:57'!
test02
	
	|aPoint aDirection rover|
	
	aPoint := Point x: 0 y: 0.
	aDirection := NorthDirection new.
	rover := (MarsRover withLocation: aPoint andPointingTo: aDirection).
	
	rover execute: 'f'.
	
	self assert: (rover position = (0@1)).
	self assert: (rover direction = aDirection)
	 ! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'js 5/6/2019 21:56:57'!
test03
	
	|aPoint aDirection rover|
	
	aPoint := Point x: 0 y: 0.
	aDirection := NorthDirection new.
	rover := (MarsRover withLocation: aPoint andPointingTo: aDirection).
	
	rover execute: 'b'.
	
	self assert: (rover position = (0@-1)).
	self assert: (rover direction = aDirection)
	 ! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'js 5/6/2019 21:56:57'!
test04
	
	|aPoint aDirection rover|
	
	aPoint := Point x: 0 y: 0.
	aDirection := NorthDirection new.
	rover := (MarsRover withLocation: aPoint andPointingTo: aDirection).
	
	rover execute: 'r'.
	
	self assert: (rover position = (0@0)).
	self assert: (rover direction = EastDirection new).
	 ! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'js 5/6/2019 21:57:01'!
test05
	
	|aPoint aDirection rover|
	
	aPoint := Point x: 0 y: 0.
	aDirection := NorthDirection new.
	rover := (MarsRover withLocation: aPoint andPointingTo: aDirection).
	
	rover execute: 'l'.
	
	self assert: (rover position = (0@0)).
	self assert: (rover direction = WestDirection new).
	 ! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'js 5/6/2019 21:56:57'!
test06
	
	|aPoint aDirection rover|
	
	aPoint := Point x: 0 y: 0.
	aDirection := NorthDirection new.
	rover := (MarsRover withLocation: aPoint andPointingTo: aDirection).
	
	[rover execute: 'x'. self fail.]
		on: Error - MessageNotUnderstood
		do: [
			self assert: (rover position = (0@0)).
			self assert: (rover direction = aDirection).
	 	]! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'js 5/6/2019 21:57:01'!
test07
	
	|aPoint aDirection rover|
	
	aPoint := Point x: 0 y: 0.
	aDirection := NorthDirection new.
	rover := (MarsRover withLocation: aPoint andPointingTo: aDirection).
	
	rover execute: 'lf'.
	
	self assert: (rover position = (-1@0)).
	self assert: (rover direction = WestDirection new).
	 ! !


!classDefinition: #DirectionState category: #MarsRover!
Object subclass: #DirectionState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!DirectionState methodsFor: 'as yet unclassified' stamp: 'js 5/6/2019 21:55:25'!
= aCardinalPoint 

	^ (self class) = (aCardinalPoint class)! !


!classDefinition: #EastDirection category: #MarsRover!
DirectionState subclass: #EastDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!


!classDefinition: #NorthDirection category: #MarsRover!
DirectionState subclass: #NorthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!NorthDirection methodsFor: 'actions' stamp: 'js 5/6/2019 20:50:00'!
moveBackwards: aPoint 

	^ (aPoint x)@(aPoint y - 1).! !

!NorthDirection methodsFor: 'actions' stamp: 'js 5/6/2019 20:48:56'!
moveForward: aPoint 

	^ (aPoint x)@(aPoint y + 1).! !

!NorthDirection methodsFor: 'actions' stamp: 'js 5/6/2019 21:57:01'!
rotateLeft: aNorth 
	
	^ WestDirection new.! !

!NorthDirection methodsFor: 'actions' stamp: 'js 5/6/2019 21:56:51'!
rotateRight: aNorth 

	^ EastDirection new.! !


!classDefinition: #WestDirection category: #MarsRover!
DirectionState subclass: #WestDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!WestDirection methodsFor: 'actions' stamp: 'js 5/6/2019 21:30:02'!
moveForward: aPoint 

	^ (aPoint x - 1)@(aPoint y).! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'location direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'js 5/6/2019 19:48:19'!
withLocation: aPoint andPointingTo: aDirection 

	location := aPoint.
	direction := aDirection.! !


!MarsRover methodsFor: 'actions' stamp: 'js 5/6/2019 21:27:58'!
execute: aString 
	(aString isEmpty) ifTrue: [^self].
	
	aString do: [ :aCommand | 
			(aCommand = $f) ifTrue: [location := direction moveForward: location.] ifFalse: [
				(aCommand = $b) ifTrue: [location := direction moveBackwards: location.] ifFalse: [
					(aCommand = $r) ifTrue: [direction := direction rotateRight: direction.] ifFalse: [
						(aCommand = $l) ifTrue: [direction := direction rotateLeft: direction.] ifFalse: [
							self error: MarsRover commandNotFoundErrorMessage.
						].
					].
				].
			].
		].
! !


!MarsRover methodsFor: 'getters' stamp: 'js 5/6/2019 20:47:35'!
direction
	^direction! !

!MarsRover methodsFor: 'getters' stamp: 'js 5/6/2019 20:47:12'!
position

	^location.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'js 5/6/2019 21:04:20'!
commandNotFoundErrorMessage 

	^'No se puede ese comando amiwo'! !

!MarsRover class methodsFor: 'initialization' stamp: 'js 5/6/2019 20:46:34'!
withLocation: aPoint andPointingTo: aDirection 

	^self new withLocation: aPoint andPointingTo: aDirection.! !


