!classDefinition: #TerniLapilliTests category: #TerniLapilli!
TestCase subclass: #TerniLapilliTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTests methodsFor: 'tests' stamp: 'js 5/23/2019 00:18:35'!
test01XShouldBeTheFirstPlayer
	| terniLapilli aPosition |
	
	aPosition := 1@1.
	terniLapilli := TerniLapilli new.
	[terniLapilli putOAt: aPosition. self fail.] on: 
	Error do: [
		self assert: (terniLapilli isEmpty)].
	! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'js 5/23/2019 17:43:59'!
test02WhenXStartsTheBoardIsNoLongerEmptyAtThatPosition
	| terniLapilli aPosition |
	
	aPosition := 1@1.
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: aPosition.
	self assert: (terniLapilli position: aPosition isTakenBy: #X).
	self assert: (terniLapilli positionsTaken = (Set with: 1@1))
	! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'js 5/23/2019 13:58:43'!
test03WhenGameStartsItIsNotOver
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	self assert: (terniLapilli isOver not).! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'js 5/23/2019 14:09:56'!
test04WhenGameStartsNoPlayersHaveWon
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	self assert: (terniLapilli hasPlayerXWon not).
	self assert: (terniLapilli hasPlayerOWon not).! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'js 5/23/2019 14:12:17'!
test05WhenTheFirstMoveIsMadeNobodyHasWon
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 1@1.
	self assert: (terniLapilli hasPlayerXWon not).
	self assert: (terniLapilli hasPlayerOWon not).
	self assert: (terniLapilli isOver not).! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'js 5/23/2019 17:43:08'!
test06ShouldRaiseErrorWhenTheSecondMoveIsNotO
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 1@1.
	[terniLapilli putXAt: 1@2. self fail.] on: 
	Error do: [
		self assert: (terniLapilli positionsTaken = (Set with: 1@1))].! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'boardState positionsTakenByX positionsTakenByO'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'functionality' stamp: 'js 5/23/2019 14:00:15'!
isOver
	^(boardState isOver)! !

!TerniLapilli methodsFor: 'functionality' stamp: 'js 5/23/2019 00:33:05'!
putOAt: aPosition 
	boardState putOAt: aPosition for: self.! !

!TerniLapilli methodsFor: 'functionality' stamp: 'js 5/23/2019 00:24:23'!
putXAt: aPosition
	boardState putXAt: aPosition for: self.! !


!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'js 5/23/2019 15:00:41'!
hasPlayerOWon
	^(positionsTakenByO size = 3)! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'js 5/23/2019 15:00:05'!
initialize
	boardState := TerniLapilliBoardEmptyState new.
	positionsTakenByX := Set new.
	positionsTakenByO  := Set new.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'js 5/23/2019 00:19:59'!
isEmpty
	^(boardState class = TerniLapilliBoardEmptyState )! !


!TerniLapilli methodsFor: 'private - functionality' stamp: 'js 5/23/2019 15:03:52'!
addToO: aPosition
	positionsTakenByO add: aPosition.! !

!TerniLapilli methodsFor: 'private - functionality' stamp: 'js 5/23/2019 15:03:47'!
addToX: aPosition
	positionsTakenByX add: aPosition.! !


!TerniLapilli methodsFor: 'internal state' stamp: 'js 5/23/2019 00:29:37'!
boardState: aTerniLapilliBoardNotEmptyOrFullState 
	boardState _ aTerniLapilliBoardNotEmptyOrFullState! !

!TerniLapilli methodsFor: 'internal state' stamp: 'js 5/23/2019 15:00:54'!
hasPlayerXWon
	^(positionsTakenByX size = 3)! !

!TerniLapilli methodsFor: 'internal state' stamp: 'js 5/23/2019 15:02:32'!
position: aPosition isTakenBy: aPlayer 
	(aPlayer = #X) ifTrue: [^ positionsTakenByX includes: aPosition.].
	^ positionsTakenByO includes: aPosition.! !

!TerniLapilli methodsFor: 'internal state' stamp: 'js 5/23/2019 17:54:30'!
positionsTaken
	^(positionsTakenByX union: positionsTakenByO)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilli!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'exceptions' stamp: 'js 5/23/2019 00:16:33'!
PlayerXShouldStart
	^'Player X Should Start'! !


!TerniLapilli class methodsFor: 'nil' stamp: 'js 5/23/2019 17:32:25'!
NotYourTurnError
	^'no es tu turno amigue'! !


!classDefinition: #TerniLapilliBoardState category: #TerniLapilli!
Object subclass: #TerniLapilliBoardState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!


!classDefinition: #TerniLapilliBoardEmptyState category: #TerniLapilli!
TerniLapilliBoardState subclass: #TerniLapilliBoardEmptyState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliBoardEmptyState methodsFor: 'as yet unclassified' stamp: 'js 5/23/2019 14:11:17'!
hasPlayerOWon
	^false! !

!TerniLapilliBoardEmptyState methodsFor: 'as yet unclassified' stamp: 'js 5/23/2019 14:10:40'!
hasPlayerXWon
	^false! !

!TerniLapilliBoardEmptyState methodsFor: 'as yet unclassified' stamp: 'js 5/23/2019 00:54:07'!
positionsTaken
	^0! !

!TerniLapilliBoardEmptyState methodsFor: 'as yet unclassified' stamp: 'js 5/23/2019 00:32:46'!
putOAt: aPosition for: aTerniLapilli
	^ self error: TerniLapilli PlayerXShouldStart ! !


!TerniLapilliBoardEmptyState methodsFor: 'functionality' stamp: 'js 5/23/2019 18:23:48'!
putXAt: aPosition for: aTerniLapilli 
	aTerniLapilli boardState: (TerniLapilliBoardNotEmptyOrFullState with: (TerniLapilliXTurnState new)).
	aTerniLapilli putXAt: aPosition! !


!TerniLapilliBoardEmptyState methodsFor: 'evaluating' stamp: 'js 5/23/2019 14:00:36'!
isOver
	^false! !


!classDefinition: #TerniLapilliBoardFullState category: #TerniLapilli!
TerniLapilliBoardState subclass: #TerniLapilliBoardFullState
	instanceVariableNames: 'board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliBoardFullState methodsFor: 'as yet unclassified' stamp: 'js 5/23/2019 00:54:20'!
positionsTaken
	^6! !


!classDefinition: #TerniLapilliBoardNotEmptyOrFullState category: #TerniLapilli!
TerniLapilliBoardState subclass: #TerniLapilliBoardNotEmptyOrFullState
	instanceVariableNames: 'turnState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliBoardNotEmptyOrFullState methodsFor: 'initialization' stamp: 'js 5/23/2019 18:17:58'!
initializeWith: aTurnState 
	turnState := aTurnState! !


!TerniLapilliBoardNotEmptyOrFullState methodsFor: 'functionality' stamp: 'js 5/23/2019 00:52:56'!
position: aPosition isTakenBy: aPlayer 
	^board position: aPosition isOccupiedBy: aPlayer.! !

!TerniLapilliBoardNotEmptyOrFullState methodsFor: 'functionality' stamp: 'js 5/23/2019 18:21:38'!
putOAt: aPosition for: aTerniLapilli 
	turnState putOAt: aPosition for: aTerniLapilli.
	turnState := TerniLapilliXTurnState new.
	"aTerniLapilli addToX: aPosition"
		 "if true tira error"! !

!TerniLapilliBoardNotEmptyOrFullState methodsFor: 'functionality' stamp: 'js 5/23/2019 18:21:50'!
putXAt: aPosition for: aTerniLapilli 
	turnState putXAt: aPosition for: aTerniLapilli.
	turnState := TerniLapilliOTurnState new.
	"aTerniLapilli addToX: aPosition"
		 "if true tira error"! !


!TerniLapilliBoardNotEmptyOrFullState methodsFor: 'as yet unclassified' stamp: 'js 5/23/2019 18:30:51'!
hasPlayerOWon
	^false! !

!TerniLapilliBoardNotEmptyOrFullState methodsFor: 'as yet unclassified' stamp: 'js 5/23/2019 18:30:47'!
hasPlayerXWon
	^false! !

!TerniLapilliBoardNotEmptyOrFullState methodsFor: 'as yet unclassified' stamp: 'js 5/23/2019 14:19:28'!
isOver
	^(self hasPlayerOWon  or: (self hasPlayerXWon))! !

!TerniLapilliBoardNotEmptyOrFullState methodsFor: 'as yet unclassified' stamp: 'js 5/23/2019 00:54:33'!
positionsTaken
	^board positionsTaken! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliBoardNotEmptyOrFullState class' category: #TerniLapilli!
TerniLapilliBoardNotEmptyOrFullState class
	instanceVariableNames: ''!

!TerniLapilliBoardNotEmptyOrFullState class methodsFor: 'instance creation' stamp: 'js 5/23/2019 18:17:49'!
with: aTurnState 
	^self new initializeWith: aTurnState.! !


!classDefinition: #TerniLapilliTurnState category: #TerniLapilli!
Object subclass: #TerniLapilliTurnState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!


!classDefinition: #TerniLapilliOTurnState category: #TerniLapilli!
TerniLapilliTurnState subclass: #TerniLapilliOTurnState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliOTurnState methodsFor: 'nil' stamp: 'js 5/23/2019 18:29:53'!
putXAt: aPosition for: aTerniLapilli
	^self error: TerniLapilli NotYourTurnError! !


!TerniLapilliOTurnState methodsFor: 'as yet unclassified' stamp: 'js 5/23/2019 18:29:44'!
putOAt: aPosition for: aTerniLapilli
	aTerniLapilli addToO: aPosition
! !


!classDefinition: #TerniLapilliXTurnState category: #TerniLapilli!
TerniLapilliTurnState subclass: #TerniLapilliXTurnState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliXTurnState methodsFor: 'nil' stamp: 'js 5/23/2019 18:30:05'!
putOAt: aPosition for: aTerniLapilli
	^self error: TerniLapilli NotYourTurnError! !


!TerniLapilliXTurnState methodsFor: 'as yet unclassified' stamp: 'js 5/23/2019 18:29:20'!
putXAt: aPosition for: aTerniLapilli
	aTerniLapilli addToX: aPosition! !
