!classDefinition: #TerniLapilliTests category: #TerniLapilli!
TestCase subclass: #TerniLapilliTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTests methodsFor: 'beginning tests' stamp: 'J.S 5/25/2019 00:29:02'!
test01WhenGameStartsItIsNotOver
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	self assert: (terniLapilli isOver not).! !

!TerniLapilliTests methodsFor: 'beginning tests' stamp: 'J.S 5/24/2019 23:47:33'!
test02WhenGameStartsThereAreNoPositionsMarked
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	self assert: (terniLapilli positionsMarked isEmpty).! !


!TerniLapilliTests methodsFor: 'marking tests' stamp: 'J.S 5/26/2019 00:42:51'!
test03XStartsPlaying
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	self assert: (terniLapilli isPlayingX)
	! !

!TerniLapilliTests methodsFor: 'marking tests' stamp: 'J.S 5/26/2019 00:43:00'!
test04XCanMarkDuringHisTurn
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	
	self assert: (terniLapilli positionsMarkedByX = (Set with: 1@1)).
	self assert: (terniLapilli positionsMarked = (Set with: 1@1))! !

!TerniLapilliTests methodsFor: 'marking tests' stamp: 'J.S 5/26/2019 00:43:09'!
test05OPlaysNextWhenXFinishesPlaying
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	
	self assert: (terniLapilli isPlayingO).! !

!TerniLapilliTests methodsFor: 'marking tests' stamp: 'J.S 5/26/2019 00:45:55'!
test06XCannotPlayDuringTurnOfO
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	self 
		should: [terniLapilli putXAt: 1@2]  
		raise: Error 
		withMessageText: (TerniLapilli notYourTurnErrorMessage).
	
	self assert: (terniLapilli positionsMarked = (Set with: 1@1)).
	self assert: (terniLapilli positionsMarkedByX = (Set with: 1@1))! !

!TerniLapilliTests methodsFor: 'marking tests' stamp: 'J.S 5/26/2019 00:43:25'!
test07OCanMarkDuringHisTurn
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 1@2.
	
	self assert: (terniLapilli positionsMarkedByO = (Set with: 1@2)).
	self assert: (terniLapilli positionsMarked = (Set with: 1@1 with: 1@2))! !

!TerniLapilliTests methodsFor: 'marking tests' stamp: 'J.S 5/26/2019 00:43:34'!
test08XPlaysNextWhenOFinishesPlaying
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 1@2.
	
	self assert: (terniLapilli isPlayingX).! !

!TerniLapilliTests methodsFor: 'marking tests' stamp: 'J.S 5/26/2019 00:43:45'!
test09OCannotPlayDuringTurnOfX
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	self 
		should: [terniLapilli putOAt: 1@2]  
		raise: Error 
		withMessageText: (TerniLapilli notYourTurnErrorMessage).! !

!TerniLapilliTests methodsFor: 'marking tests' stamp: 'J.S 5/25/2019 15:28:45'!
test12ThrowsErrorWhenMarkingPositionOutOfBoard
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	self 
		should: [terniLapilli putXAt: 5@5.]  
		raise: Error
		withMessageText: (TerniLapilli positionNotInBoardErrorMessage).! !

!TerniLapilliTests methodsFor: 'marking tests' stamp: 'J.S 5/26/2019 00:49:31'!
test13PlayerCannotMarkMoreThan3Positions
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with:1@1 with:1@2 with:3@3) to: #X.
	terniLapilli addAll: (Set with:2@2 with:2@3 with:3@1) to: #O.
	
	self 
		should: [terniLapilli putXAt: 1@3.]  
		raise: Error
		withMessageText: (TerniLapilli cannotMarkMorePositionsErrorMessage).
		
	self assert: ((terniLapilli positionsMarked includes: 1@3) not)! !

!TerniLapilliTests methodsFor: 'marking tests' stamp: 'J.S 5/26/2019 12:43:27'!
test14ThrowsErrorWhenMarkingNonEmptyPosition
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 2@2.
	self 
		should: [terniLapilli putOAt: 2@2.]  
		raise: Error - MessageNotUnderstood 
		withMessageText: (TerniLapilli positionNotEmptyErrorMessage).! !


!TerniLapilliTests methodsFor: 'sliding tests' stamp: 'J.S 5/26/2019 11:46:15'!
test26PlayerCanNotSlideIfDidntMarked3Positions

	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1) to: #X.
	
	self 
		should: [terniLapilli slideXFrom: 3@1 to: 3@2]
		raise: Error - MessageNotUnderstood
		withMessageText: (TerniLapilli cannotSlideYetErrorMessage).
		
	self assert: (terniLapilli positionsMarked = (Set with: 3@1))
	! !

!TerniLapilliTests methodsFor: 'sliding tests' stamp: 'J.S 5/26/2019 12:03:45'!
test27PlayerCanSlideDuringHisTurn

	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 3@2 with: 2@2) to: #O.
	terniLapilli addAll: (Set with: 1@1 with: 1@2 with: 2@3) to: #X.
	
	terniLapilli slideXFrom: 1@1 to: 2@1.
	
	self assert: ((terniLapilli positionsMarkedByX includes: 1@1) not).
	self assert: (terniLapilli positionsMarkedByX includes: 2@1).	! !

!TerniLapilliTests methodsFor: 'sliding tests' stamp: 'J.S 5/26/2019 13:04:01'!
test29TurnChangesWhenPlayerFinishesSliding
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 3@2 with: 2@2) to: #O.
	terniLapilli addAll: (Set with: 1@1 with: 1@2 with: 2@3) to: #X.
	
	terniLapilli slideXFrom: 1@1 to: 2@1.
	
	self assert: (terniLapilli isPlayingO).! !

!TerniLapilliTests methodsFor: 'sliding tests' stamp: 'J.S 5/26/2019 13:17:58'!
test30PlayerCannotSlideWhenPositionIsNotEmpty
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 3@2 with: 2@2) to: #O.
	terniLapilli addAll: (Set with: 1@1 with: 1@2 with: 2@3) to: #X.
	
	self 
		should: [terniLapilli slideXFrom: 1@1 to: 1@2.]  
		raise: Error
		withMessageText: (TerniLapilli positionNotEmptyErrorMessage ).
! !

!TerniLapilliTests methodsFor: 'sliding tests' stamp: 'J.S 5/26/2019 13:29:30'!
test31PlayerCannotSlideDuringTurnOfAnotherPlayer

	| terniLapilli |
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 3@2 with: 2@2) to: #O.
	terniLapilli addAll: (Set with: 1@1 with: 1@2 with: 2@3) to: #X.
	
	self 
		should: [terniLapilli slideOFrom: 3@2 to: 3@3]  
		raise: Error - MessageNotUnderstood 
		withMessageText: (TerniLapilli notYourTurnErrorMessage ).

	! !

!TerniLapilliTests methodsFor: 'sliding tests' stamp: 'J.S 5/26/2019 13:31:00'!
test32PlayerCannotSlideOutOfBoard

	| terniLapilli |
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 3@2 with: 2@2) to: #O.
	terniLapilli addAll: (Set with: 1@1 with: 1@2 with: 2@3) to: #X.
	
	self 
		should: [terniLapilli slideXFrom: 2@3 to: 2@4]  
		raise: Error - MessageNotUnderstood 
		withMessageText: (TerniLapilli positionNotInBoardErrorMessage ).

	! !

!TerniLapilliTests methodsFor: 'sliding tests' stamp: 'J.S 5/26/2019 13:34:12'!
test33PlayerCannotSlideToNonContiguousPosition
	| terniLapilli |
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 3@2 with: 2@2) to: #O.
	terniLapilli addAll: (Set with: 1@1 with: 1@2 with: 2@3) to: #X.
	
	self 
		should: [terniLapilli slideXFrom: 2@3 to: 2@1]  
		raise: Error - MessageNotUnderstood 
		withMessageText: (TerniLapilli invalidSlidingErrorMessage).

	! !


!TerniLapilliTests methodsFor: 'game over tests' stamp: 'J.S 5/25/2019 17:28:17'!
test15PlayerWinsIfCompletesTopRow
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 1@1 with: 1@2 with:1@3) to: #X.
	
	self assert: (terniLapilli hasPlayerXWon).! !

!TerniLapilliTests methodsFor: 'game over tests' stamp: 'J.S 5/25/2019 17:28:24'!
test16PlayerWinsIfCompletesMiddleRow
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 2@1 with: 2@2 with:2@3) to: #X.
	
	self assert: (terniLapilli hasPlayerXWon).! !

!TerniLapilliTests methodsFor: 'game over tests' stamp: 'J.S 5/25/2019 17:28:33'!
test17PlayerWinsIfCompletesLowerRow
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 3@2 with:3@3) to: #X.
	
	self assert: (terniLapilli hasPlayerXWon).! !

!TerniLapilliTests methodsFor: 'game over tests' stamp: 'J.S 5/25/2019 17:28:41'!
test18PlayerWinsIfCompletesFirstColumn
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 1@1 with: 2@1 with:3@1) to: #X.
	
	self assert: (terniLapilli hasPlayerXWon).! !

!TerniLapilliTests methodsFor: 'game over tests' stamp: 'J.S 5/25/2019 17:28:47'!
test19PlayerWinsIfCompletesSecondColumn
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 1@2 with: 2@2 with:3@2) to: #X.
	
	self assert: (terniLapilli hasPlayerXWon).! !

!TerniLapilliTests methodsFor: 'game over tests' stamp: 'J.S 5/25/2019 17:28:54'!
test20PlayerWinsIfCompletesThirdColumn
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 1@3 with: 2@3 with:3@3) to: #X.
	
	self assert: (terniLapilli hasPlayerXWon).! !

!TerniLapilliTests methodsFor: 'game over tests' stamp: 'J.S 5/25/2019 17:29:00'!
test21PlayerWinsIfCompletesDiagonalFromTopLeftToBottomRight
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 1@1 with: 2@2 with:3@3) to: #X.
	
	self assert: (terniLapilli hasPlayerXWon).! !

!TerniLapilliTests methodsFor: 'game over tests' stamp: 'J.S 5/25/2019 17:29:06'!
test22PlayerWinsIfCompletesDiagonalFromBottomLeftToTopRight
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 2@2 with:1@3) to: #X.
	
	self assert: (terniLapilli hasPlayerXWon).! !

!TerniLapilliTests methodsFor: 'game over tests' stamp: 'J.S 5/26/2019 00:52:11'!
test23WhenPlayerWinsGameIsOver
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 2@2 with:1@3) to: #X.
	
	self assert: (terniLapilli isOver).! !

!TerniLapilliTests methodsFor: 'game over tests' stamp: 'J.S 5/26/2019 14:26:28'!
test24PlayerCanNotMarkWhenGameIsOver

	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 2@2 with:1@3) to: #X.
	terniLapilli addAll: (Set with: 2@1 with: 2@3) to: #O.
	
	self 
		should: [terniLapilli putOAt: 3@3]
		raise: Error
		withMessageText: (TerniLapilli cannotPlayWhenGameIsOverErrorMessage ).
	! !

!TerniLapilliTests methodsFor: 'game over tests' stamp: 'J.S 5/26/2019 14:28:04'!
test25PlayerCanNotSlideWhenGameIsOver

	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 2@2 with:1@3) to: #X.
	terniLapilli addAll: (Set with: 2@1 with: 2@3 with: 3@2) to: #O.
	
	self 
		should: [terniLapilli slideXFrom: 2@1 to: 1@2]
		raise: Error
		withMessageText: (TerniLapilli cannotPlayWhenGameIsOverErrorMessage ).
	! !


!classDefinition: #BoardState category: #TerniLapilli!
Object subclass: #BoardState
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!BoardState methodsFor: 'initialization' stamp: 'J.S 5/25/2019 18:12:24'!
initializeWith: aTerniLapilli

	terniLapilli := aTerniLapilli.! !


!BoardState methodsFor: 'validation' stamp: 'J.S 5/25/2019 20:10:33'!
execute: aBlockClosure ifInRange: aPosition

	| xInRange yInRange |
	xInRange := aPosition x between: 1 and: 3.
	yInRange := aPosition y between: 1 and: 3.
	
	(xInRange and: yInRange)
		ifTrue: aBlockClosure value
		ifFalse: [self error: TerniLapilli positionNotInBoardErrorMessage]
	
	 ! !

!BoardState methodsFor: 'validation' stamp: 'J.S 5/26/2019 15:59:07'!
execute: aBlockClosure ifInRangeAndNonEmpy: aPosition 

	(terniLapilli isEmpty: aPosition)
		ifFalse: [self error: (TerniLapilli positionNotEmptyErrorMessage )].
		
	self execute: aBlockClosure ifInRange: aPosition.
	
	 ! !


!BoardState methodsFor: 'functionality' stamp: 'J.S 5/25/2019 20:06:11'!
mark: aPosition with: aPlayer
	
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BoardState class' category: #TerniLapilli!
BoardState class
	instanceVariableNames: ''!

!BoardState class methodsFor: 'testing' stamp: 'J.S 5/25/2019 17:53:13'!
canHandle

	self subclassResponsibility ! !


!BoardState class methodsFor: 'initialization' stamp: 'J.S 5/25/2019 18:11:27'!
with: aTerniLapilli
	
	^ self new initializeWith: aTerniLapilli.! !


!classDefinition: #BoardFull category: #TerniLapilli!
BoardState subclass: #BoardFull
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!BoardFull methodsFor: 'functionality' stamp: 'J.S 5/25/2019 19:49:27'!
mark: aPosition with: aPlayer

	self 
		execute:  [ self error: TerniLapilli cannotMarkMorePositionsErrorMessage] 
		ifInRange: aPosition
		
	
	! !

!BoardFull methodsFor: 'functionality' stamp: 'J.S 5/26/2019 13:07:11'!
slide: aPosition to: aDestinationPosition from: aPlayer

	self 
		execute:  [terniLapilli slide: aPosition to: aDestinationPosition from: aPlayer] 
		ifInRangeAndNonEmpy: aDestinationPosition
		
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BoardFull class' category: #TerniLapilli!
BoardFull class
	instanceVariableNames: ''!

!BoardFull class methodsFor: 'testing' stamp: 'J.S 5/25/2019 20:05:06'!
canHandle: aTerniLapilli
	
	^ aTerniLapilli positionsMarked size = 6! !


!classDefinition: #BoardNotFull category: #TerniLapilli!
BoardState subclass: #BoardNotFull
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!BoardNotFull methodsFor: 'functionality' stamp: 'J.S 5/26/2019 12:51:56'!
mark: aPosition with: aPlayer
		
	self execute: [(terniLapilli positionsMarkedBy: aPlayer) add: aPosition]  ifInRangeAndNonEmpy: aPosition.
	
	! !

!BoardNotFull methodsFor: 'functionality' stamp: 'J.S 5/26/2019 12:33:52'!
slide: aPosition to: aDestinationPosition from: aPlayer

	self error: (TerniLapilli cannotSlideYetErrorMessage )
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BoardNotFull class' category: #TerniLapilli!
BoardNotFull class
	instanceVariableNames: ''!

!BoardNotFull class methodsFor: 'testing' stamp: 'J.S 5/25/2019 19:55:58'!
canHandle: aTerniLapilli
	
	^ aTerniLapilli positionsMarked size < 6! !


!classDefinition: #GameState category: #TerniLapilli!
Object subclass: #GameState
	instanceVariableNames: 'playingState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!GameState methodsFor: 'initialization' stamp: 'J.S 5/26/2019 16:02:07'!
initializeWith: aPlayingState

	playingState := aPlayingState.! !


!GameState methodsFor: 'getters' stamp: 'J.S 5/26/2019 16:02:07'!
playingNextState

	^ playingState.! !


!GameState methodsFor: 'functionality' stamp: 'J.S 5/25/2019 23:36:08'!
putOAt: aPosition

	self subclassResponsibility .! !

!GameState methodsFor: 'functionality' stamp: 'J.S 5/25/2019 23:36:19'!
putXAt: aPosition

	self subclassResponsibility .! !

!GameState methodsFor: 'functionality' stamp: 'J.S 5/26/2019 14:30:52'!
slideOFrom: aPosition to: aDestinationPosition

	self subclassResponsibility .! !

!GameState methodsFor: 'functionality' stamp: 'J.S 5/26/2019 14:30:49'!
slideXFrom: aPosition to: aDestinationPosition

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameState class' category: #TerniLapilli!
GameState class
	instanceVariableNames: ''!

!GameState class methodsFor: 'testing' stamp: 'J.S 5/25/2019 23:29:58'!
canHandle: aTerniLapilli

	self subclassResponsibility .! !


!GameState class methodsFor: 'instance creation' stamp: 'J.S 5/25/2019 23:45:38'!
with: aPlayingNextState

	^ ((self new) initializeWith: aPlayingNextState)! !


!classDefinition: #GameContinues category: #TerniLapilli!
GameState subclass: #GameContinues
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!GameContinues methodsFor: 'functionality' stamp: 'J.S 5/25/2019 23:33:53'!
putOAt: aPosition

	self playingNextState putOAt: aPosition.! !

!GameContinues methodsFor: 'functionality' stamp: 'J.S 5/25/2019 23:33:05'!
putXAt: aPosition

	self playingNextState putXAt: aPosition.! !

!GameContinues methodsFor: 'functionality' stamp: 'J.S 5/26/2019 16:02:07'!
slideOFrom: aPosition to: aDestinationPosition

	playingState slideOFrom: aPosition to: aDestinationPosition.! !

!GameContinues methodsFor: 'functionality' stamp: 'J.S 5/26/2019 16:02:07'!
slideXFrom: aPosition to: aDestinationPosition

	playingState slideXFrom: aPosition to: aDestinationPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameContinues class' category: #TerniLapilli!
GameContinues class
	instanceVariableNames: ''!

!GameContinues class methodsFor: 'testing' stamp: 'J.S 5/25/2019 23:30:27'!
canHandle: aTerniLapilli

	^ (aTerniLapilli isOver) not.! !


!classDefinition: #GameOver category: #TerniLapilli!
GameState subclass: #GameOver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!GameOver methodsFor: 'functionality' stamp: 'J.S 5/25/2019 23:33:32'!
putOAt: aPosition

	self error: (TerniLapilli cannotPlayWhenGameIsOverErrorMessage) ! !

!GameOver methodsFor: 'functionality' stamp: 'J.S 5/25/2019 23:33:16'!
putXAt: aPosition

	self error: (TerniLapilli cannotPlayWhenGameIsOverErrorMessage) ! !

!GameOver methodsFor: 'functionality' stamp: 'J.S 5/26/2019 16:02:54'!
slideOFrom: aPosition to: aDestinationPosition

	self error: (TerniLapilli cannotPlayWhenGameIsOverErrorMessage) ! !

!GameOver methodsFor: 'functionality' stamp: 'J.S 5/26/2019 16:02:49'!
slideXFrom: aPosition to: aDestinationPosition

	self error: (TerniLapilli cannotPlayWhenGameIsOverErrorMessage) ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOver class' category: #TerniLapilli!
GameOver class
	instanceVariableNames: ''!

!GameOver class methodsFor: 'testing' stamp: 'J.S 5/25/2019 23:30:55'!
canHandle: aTerniLapilli

	^ aTerniLapilli isOver! !


!classDefinition: #PlayingState category: #TerniLapilli!
Object subclass: #PlayingState
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlayingState methodsFor: 'initialization' stamp: 'J.S 5/25/2019 16:10:10'!
initializeWith: aTerniLapilli

	terniLapilli  := aTerniLapilli.
! !


!PlayingState methodsFor: 'functionality' stamp: 'J.S 5/25/2019 14:58:37'!
putOAt: aPosition 

	self subclassResponsibility .! !

!PlayingState methodsFor: 'functionality' stamp: 'J.S 5/25/2019 14:58:55'!
putXAt: aPosition 
	
	self subclassResponsibility.! !

!PlayingState methodsFor: 'functionality' stamp: 'J.S 5/26/2019 12:57:23'!
slideOFrom: aPosition to: aDestinationPosition	
	
	self subclassResponsibility.! !

!PlayingState methodsFor: 'functionality' stamp: 'J.S 5/26/2019 12:57:20'!
slideXFrom: aPosition to: aDestinationPosition	
	
	self subclassResponsibility.! !


!PlayingState methodsFor: 'testing' stamp: 'J.S 5/26/2019 00:03:57'!
isPlayingO

	self subclassResponsibility .! !

!PlayingState methodsFor: 'testing' stamp: 'J.S 5/26/2019 00:03:51'!
isPlayingX

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayingState class' category: #TerniLapilli!
PlayingState class
	instanceVariableNames: ''!

!PlayingState class methodsFor: 'instance creation' stamp: 'J.S 5/25/2019 16:08:39'!
with: aTurniLapilli

	^ self new initializeWith: aTurniLapilli.! !


!classDefinition: #OPlaying category: #TerniLapilli!
PlayingState subclass: #OPlaying
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!OPlaying methodsFor: 'functionality' stamp: 'J.S 5/26/2019 00:02:39'!
putOAt: aPosition 

	| aBoardState |
	aBoardState := (BoardState subclasses detect: [:aBoardStateClass | aBoardStateClass canHandle: terniLapilli]) with: terniLapilli.

	"terniLapilli mark: aPosition with: #O."
	aBoardState mark: aPosition with: #O.
	terniLapilli playingNextState: (XPlaying with: terniLapilli)! !

!OPlaying methodsFor: 'functionality' stamp: 'J.S 5/25/2019 14:56:31'!
putXAt: aPosition 

	self error: TerniLapilli notYourTurnErrorMessage! !

!OPlaying methodsFor: 'functionality' stamp: 'J.S 5/26/2019 13:02:38'!
slideOFrom: aPosition to: aDestinationPosition	
	
	| aBoardState |
	aBoardState := (BoardState subclasses detect: [:aBoardStateClass | aBoardStateClass canHandle: terniLapilli ]) with: terniLapilli.
	
	aBoardState slide: aPosition to: aDestinationPosition  from: #O.
	terniLapilli playingNextState: (XPlaying with: terniLapilli)! !

!OPlaying methodsFor: 'functionality' stamp: 'J.S 5/26/2019 12:56:54'!
slideXFrom: aPosition to: aDestinationPosition	
	
	self error: (TerniLapilli notYourTurnErrorMessage)! !


!OPlaying methodsFor: 'testing' stamp: 'J.S 5/26/2019 00:03:39'!
isPlayingO

	^ true.! !

!OPlaying methodsFor: 'testing' stamp: 'J.S 5/26/2019 00:03:29'!
isPlayingX

	^ false.! !


!classDefinition: #XPlaying category: #TerniLapilli!
PlayingState subclass: #XPlaying
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!XPlaying methodsFor: 'functionality' stamp: 'J.S 5/25/2019 14:55:58'!
putOAt: aPosition 

	self error: TerniLapilli notYourTurnErrorMessage.! !

!XPlaying methodsFor: 'functionality' stamp: 'J.S 5/26/2019 01:25:28'!
putXAt: aPosition 
	
	| aBoardState |
	aBoardState := (BoardState subclasses detect: [:aBoardStateClass | aBoardStateClass canHandle: terniLapilli]) with: terniLapilli.
	
	aBoardState mark: aPosition with: #X.
	terniLapilli playingNextState: (OPlaying with: terniLapilli)! !

!XPlaying methodsFor: 'functionality' stamp: 'J.S 5/26/2019 12:57:05'!
slideOFrom: aPosition to: aDestinationPosition	
	
	self error: (TerniLapilli notYourTurnErrorMessage)! !

!XPlaying methodsFor: 'functionality' stamp: 'J.S 5/26/2019 13:02:24'!
slideXFrom: aPosition to: aDestinationPosition	
	
	| aBoardState |
	aBoardState := (BoardState subclasses detect: [:aBoardStateClass | aBoardStateClass canHandle: terniLapilli ]) with: terniLapilli.
	
	aBoardState slide: aPosition to: aDestinationPosition  from: #X.
	terniLapilli playingNextState: (OPlaying with: terniLapilli)! !


!XPlaying methodsFor: 'testing' stamp: 'J.S 5/26/2019 00:03:18'!
isPlayingO

	^ false.! !

!XPlaying methodsFor: 'testing' stamp: 'J.S 5/26/2019 00:03:02'!
isPlayingX

	^ true.! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'positionsMarkedByPlayer playingNextState gameState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'testing' stamp: 'J.S 5/25/2019 17:26:50'!
hasPlayerOWon
	
	^ self hasPlayerWon: #O.! !

!TerniLapilli methodsFor: 'testing' stamp: 'J.S 5/25/2019 17:26:46'!
hasPlayerXWon
	
	^ self hasPlayerWon: #X.! !

!TerniLapilli methodsFor: 'testing' stamp: 'J.S 5/26/2019 15:59:07'!
isEmpty: aPosition

	^ (((self positionsMarkedByX) union: (self positionsMarkedByO)) includes: aPosition) not! !

!TerniLapilli methodsFor: 'testing' stamp: 'J.S 5/25/2019 17:27:24'!
isOver

	^ (self hasPlayerXWon) or: (self hasPlayerOWon).! !

!TerniLapilli methodsFor: 'testing' stamp: 'J.S 5/26/2019 00:04:36'!
isPlayingO

	^ playingNextState isPlayingO! !

!TerniLapilli methodsFor: 'testing' stamp: 'J.S 5/26/2019 00:04:26'!
isPlayingX

	^ playingNextState isPlayingX! !


!TerniLapilli methodsFor: 'functionality' stamp: 'J.S 5/25/2019 23:50:18'!
putOAt: aPosition
		
	| aGameState |
	aGameState := (GameState subclasses detect: [:aGameStateClass | aGameStateClass canHandle: self]) with: playingNextState.
	aGameState putOAt: aPosition.
	! !

!TerniLapilli methodsFor: 'functionality' stamp: 'J.S 5/25/2019 23:40:41'!
putXAt: aPosition 
	
	| aGameState |
	aGameState := (GameState subclasses detect: [:aGameStateClass | aGameStateClass canHandle: self]) with: playingNextState.
	aGameState putXAt: aPosition.


	
	! !

!TerniLapilli methodsFor: 'functionality' stamp: 'J.S 5/26/2019 14:31:35'!
slideOFrom: aPosition to: aDestinationPosition 
	| aGameState |
	aGameState := (GameState subclasses detect: [:aGameStateClass | aGameStateClass canHandle: self]) with: playingNextState.
	aGameState slideOFrom: aPosition to: aDestinationPosition.! !

!TerniLapilli methodsFor: 'functionality' stamp: 'J.S 5/26/2019 14:31:49'!
slideXFrom: aPosition to: aDestinationPosition 
	
	| aGameState |
	aGameState := (GameState subclasses detect: [:aGameStateClass | aGameStateClass canHandle: self]) with: playingNextState.
	aGameState slideXFrom: aPosition to: aDestinationPosition.! !


!TerniLapilli methodsFor: 'initialization' stamp: 'J.S 5/26/2019 15:03:09'!
initialize

	positionsMarkedByPlayer := Dictionary new.
	positionsMarkedByPlayer add: (#X -> Set new).
	positionsMarkedByPlayer add: (#O -> Set new).
	playingNextState := XPlaying with: self.! !


!TerniLapilli methodsFor: 'setters' stamp: 'J.S 5/25/2019 14:51:03'!
playingNextState: aPlayingNextState

	playingNextState  := aPlayingNextState.! !


!TerniLapilli methodsFor: 'internal' stamp: 'J.S 5/25/2019 15:34:07'!
addAll: aCollectionOfPositions to: aPlayer
	"creado para testear mas facil"
	
	(self positionsMarkedBy: aPlayer) addAll: aCollectionOfPositions! !

!TerniLapilli methodsFor: 'internal' stamp: 'J.S 5/26/2019 15:01:54'!
hasPlayerWon: aPlayer 
	
	| positionsMarkedOfPlayer |
	positionsMarkedOfPlayer := (self positionsMarkedBy: aPlayer).
	
	^ TerniLapilli winningScenarios values anySatisfy: [:aWinnerCombination | positionsMarkedOfPlayer = aWinnerCombination].! !

!TerniLapilli methodsFor: 'internal' stamp: 'J.S 5/26/2019 15:02:12'!
positionsMarkedBy: aPlayer
	
	^ (positionsMarkedByPlayer 
		at: aPlayer 
		ifAbsent: [self error: TerniLapilli playerDoNotExistErrorMessage ]).
! !

!TerniLapilli methodsFor: 'internal' stamp: 'J.S 5/26/2019 15:57:55'!
slide: aPosition to: aDestinationPosition from: aPlayer
	
	| deltaX deltaY |
	deltaX := (aPosition x - aDestinationPosition x) abs.
	deltaY := (aPosition y - aDestinationPosition y) abs.
	(deltaX > 1 or: deltaY > 1) ifTrue: [self error: TerniLapilli invalidSlidingErrorMessage ]. "SACAR ESTE IF?"
	
	(self positionsMarkedBy: aPlayer) remove: aPosition.
	(self positionsMarkedBy: aPlayer) add: aDestinationPosition .
! !


!TerniLapilli methodsFor: 'accessing' stamp: 'J.S 5/26/2019 15:57:13'!
positionsMarked

	^ positionsMarkedByPlayer inject: (Set new) into: [:positionsOfPlayerA :positionsOfPlayerB | positionsOfPlayerA union: positionsOfPlayerB].! !

!TerniLapilli methodsFor: 'accessing' stamp: 'J.S 5/26/2019 00:33:57'!
positionsMarkedByO

	^ self positionsMarkedBy: #O! !

!TerniLapilli methodsFor: 'accessing' stamp: 'J.S 5/26/2019 00:22:12'!
positionsMarkedByX

	^ self positionsMarkedBy: #X.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilli!
TerniLapilli class
	instanceVariableNames: 'winningScenarios'!

!TerniLapilli class methodsFor: 'error' stamp: 'J.S 5/25/2019 15:38:33'!
cannotMarkMorePositionsErrorMessage

	^ 'Player cannot put more than 3 elems.'! !

!TerniLapilli class methodsFor: 'error' stamp: 'J.S 5/25/2019 23:15:13'!
cannotPlayWhenGameIsOverErrorMessage

	^ 'Game is already finished'! !

!TerniLapilli class methodsFor: 'error' stamp: 'J.S 5/26/2019 01:45:34'!
cannotSlideYetErrorMessage

	'Player has to mark 3 positions in order to slide!!'! !

!TerniLapilli class methodsFor: 'error' stamp: 'J.S 5/26/2019 13:34:34'!
invalidSlidingErrorMessage

	^ 'That is not a valid slide.'! !

!TerniLapilli class methodsFor: 'error' stamp: 'J.S 5/24/2019 23:52:25'!
notYourTurnErrorMessage

	^ 'Not your turn, player!!'! !

!TerniLapilli class methodsFor: 'error' stamp: 'J.S 5/25/2019 09:27:49'!
playerDoNotExistErrorMessage
	
	^ 'Player do not exist!!'! !

!TerniLapilli class methodsFor: 'error' stamp: 'J.S 5/26/2019 12:44:07'!
positionNotEmptyErrorMessage
	
	^ 'Cannot mark position because it is not empty!!' ! !

!TerniLapilli class methodsFor: 'error' stamp: 'J.S 5/25/2019 23:15:38'!
positionNotInBoardErrorMessage

	^ 'Position is not in the board!!'! !


!TerniLapilli class methodsFor: 'initialization' stamp: 'J.S 5/26/2019 14:43:42'!
initialize
	
	winningScenarios  := Dictionary new.
	winningScenarios 
		add: #completesUpperRow -> (Set with: 1@1 with: 1@2 with: 1@3);
		add: #completesMiddleRow -> (Set with: 2@1 with: 2@2 with: 2@3);
		add: #completesLowerRow -> (Set with: 3@1 with: 3@2 with: 3@3);
		add: #completesLeftColumn -> (Set with: 1@1 with: 2@1 with: 3@1);
		add: #completesMiddleColumn -> (Set with: 1@2 with: 2@2 with: 3@2);
		add: #completesRightColumn -> (Set with: 1@3 with: 2@3 with: 3@3);
		add: #completesDecreasingDiagonal -> (Set with: 1@1 with: 2@2 with: 3@3);
		add: #completesIncreasingDiagonal -> (Set with: 3@1 with: 2@2 with: 1@3).! !


!TerniLapilli class methodsFor: 'getters' stamp: 'J.S 5/26/2019 14:46:33'!
winningScenarios

	^ winningScenarios ! !

TerniLapilli initialize!