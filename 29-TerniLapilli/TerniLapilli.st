!classDefinition: #TerniLapilliTests category: #TerniLapilli!
TestCase subclass: #TerniLapilliTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!


!TerniLapilliTests methodsFor: 'marking tests' stamp: 'J.S 5/26/2019 22:34:47'!
test03XStartsPlaying
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	self assert: (terniLapilli isXPlaying)
	! !

!TerniLapilliTests methodsFor: 'marking tests' stamp: 'J.S 5/26/2019 00:43:00'!
test04XCanMarkDuringHisTurn
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	
	self assert: (terniLapilli positionsMarkedByX = (Set with: 1@1)).
	self assert: (terniLapilli positionsMarked = (Set with: 1@1))! !

!TerniLapilliTests methodsFor: 'marking tests' stamp: 'J.S 5/26/2019 22:34:38'!
test05OPlaysNextWhenXFinishesPlaying
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	
	self assert: (terniLapilli isOPlaying).! !

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

!TerniLapilliTests methodsFor: 'marking tests' stamp: 'J.S 5/26/2019 22:34:47'!
test08XPlaysNextWhenOFinishesPlaying
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 1@2.
	
	self assert: (terniLapilli isXPlaying).! !

!TerniLapilliTests methodsFor: 'marking tests' stamp: 'J.S 5/26/2019 00:43:45'!
test09OCannotPlayDuringTurnOfX
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	self 
		should: [terniLapilli putOAt: 1@2]  
		raise: Error 
		withMessageText: (TerniLapilli notYourTurnErrorMessage).! !

!TerniLapilliTests methodsFor: 'marking tests' stamp: 'J.S 5/26/2019 18:12:08'!
test10ThrowsErrorWhenMarkingPositionOutOfBoard
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	self 
		should: [terniLapilli putXAt: 5@5.]  
		raise: Error
		withMessageText: (TerniLapilli positionNotInBoardErrorMessage).! !

!TerniLapilliTests methodsFor: 'marking tests' stamp: 'J.S 5/26/2019 18:12:14'!
test11PlayerCannotMarkMoreThan3Positions
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with:1@1 with:1@2 with:3@3) to: #X.
	terniLapilli addAll: (Set with:2@2 with:2@3 with:3@1) to: #O.
	
	self 
		should: [terniLapilli putXAt: 1@3.]  
		raise: Error
		withMessageText: (TerniLapilli cannotMarkMorePositionsErrorMessage).
		
	self assert: ((terniLapilli positionsMarked includes: 1@3) not)! !

!TerniLapilliTests methodsFor: 'marking tests' stamp: 'J.S 5/26/2019 18:12:19'!
test12ThrowsErrorWhenMarkingNonEmptyPosition
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 2@2.
	self 
		should: [terniLapilli putOAt: 2@2.]  
		raise: Error - MessageNotUnderstood 
		withMessageText: (TerniLapilli positionNotEmptyErrorMessage).! !


!TerniLapilliTests methodsFor: 'sliding tests' stamp: 'J. 5/27/2019 00:13:08'!
test13XCanNotSlideIfDidntMarked3Positions

	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 3@1.
	terniLapilli putOAt: 1@1.
	
	self 
		should: [terniLapilli slideXFrom: 3@1 to: 3@2]
		raise: Error - MessageNotUnderstood
		withMessageText: (TerniLapilli cannotSlideYetErrorMessage).
		
	self assert: (terniLapilli positionsMarkedByX = (Set with: 3@1))! !

!TerniLapilliTests methodsFor: 'sliding tests' stamp: 'J.S 5/26/2019 18:14:03'!
test14OCanNotSlideIfDidntMarked3Positions

	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 3@1.
	terniLapilli putOAt: 3@2.
	terniLapilli putXAt: 1@2.
			
	self 
		should: [terniLapilli slideOFrom: 3@2 to: 3@3]
		raise: Error - MessageNotUnderstood
		withMessageText: (TerniLapilli cannotSlideYetErrorMessage).
		
	self assert: (terniLapilli positionsMarkedByO = (Set with: 3@2))
	! !

!TerniLapilliTests methodsFor: 'sliding tests' stamp: 'J.S 5/26/2019 18:16:25'!
test15XCanSlideDuringHisTurn

	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 3@2 with: 2@2) to: #O.
	terniLapilli addAll: (Set with: 1@1 with: 1@2 with: 2@3) to: #X.
	
	terniLapilli slideXFrom: 1@1 to: 2@1.
	
	self assert: ((terniLapilli positionsMarkedByX includes: 1@1) not).
	self assert: (terniLapilli positionsMarkedByX includes: 2@1).	! !

!TerniLapilliTests methodsFor: 'sliding tests' stamp: 'J.S 5/26/2019 18:17:23'!
test16OCanSlideDuringHisTurn

	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 3@2 with: 2@2) to: #O.
	terniLapilli addAll: (Set with: 1@1 with: 1@2 with: 2@3) to: #X.
	
	terniLapilli slideXFrom: 1@1 to: 2@1.
	terniLapilli slideOFrom: 3@2 to: 3@3.
	
	self assert: ((terniLapilli positionsMarkedByO includes: 3@2) not).
	self assert: (terniLapilli positionsMarkedByO includes: 3@3).	! !

!TerniLapilliTests methodsFor: 'sliding tests' stamp: 'J.S 5/26/2019 22:34:38'!
test17OPlaysNextWhenXFinishesSliding
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 3@2 with: 2@2) to: #O.
	terniLapilli addAll: (Set with: 1@1 with: 1@2 with: 2@3) to: #X.
	
	terniLapilli slideXFrom: 1@1 to: 2@1.
	
	self assert: (terniLapilli isOPlaying).! !

!TerniLapilliTests methodsFor: 'sliding tests' stamp: 'J.S 5/26/2019 22:34:47'!
test18XPlaysNextWhenOFinishesSliding
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 3@2 with: 2@2) to: #O.
	terniLapilli addAll: (Set with: 1@1 with: 1@2 with: 2@3) to: #X.
	
	terniLapilli slideXFrom: 1@1 to: 2@1.
	terniLapilli slideOFrom: 3@2 to: 3@3.
	
	self assert: (terniLapilli isXPlaying).! !

!TerniLapilliTests methodsFor: 'sliding tests' stamp: 'J.S 5/26/2019 18:32:19'!
test19XCannotSlideWhenPositionIsNotEmpty
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 3@2 with: 2@2) to: #O.
	terniLapilli addAll: (Set with: 1@1 with: 1@2 with: 2@3) to: #X.
	
	self 
		should: [terniLapilli slideXFrom: 1@1 to: 1@2.]  
		raise: Error
		withMessageText: (TerniLapilli positionNotEmptyErrorMessage ).
! !

!TerniLapilliTests methodsFor: 'sliding tests' stamp: 'J.S 5/26/2019 18:33:11'!
test20OCannotSlideWhenPositionIsNotEmpty
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 3@2 with: 2@2) to: #O.
	terniLapilli addAll: (Set with: 1@1 with: 1@2 with: 2@3) to: #X.
	
	terniLapilli slideXFrom: 1@1 to: 2@1.
	
	self 
		should: [terniLapilli slideOFrom: 3@1 to: 3@2.]  
		raise: Error
		withMessageText: (TerniLapilli positionNotEmptyErrorMessage ).
! !

!TerniLapilliTests methodsFor: 'sliding tests' stamp: 'J.S 5/26/2019 18:34:51'!
test21XCannotSlideWhenOIsPlaying

	| terniLapilli |
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 3@2 with: 2@2) to: #O.
	terniLapilli addAll: (Set with: 1@1 with: 1@2 with: 2@3) to: #X.
	
	self 
		should: [terniLapilli slideOFrom: 3@2 to: 3@3]  
		raise: Error - MessageNotUnderstood 
		withMessageText: (TerniLapilli notYourTurnErrorMessage ).

	! !

!TerniLapilliTests methodsFor: 'sliding tests' stamp: 'J.S 5/26/2019 18:35:35'!
test22OCannotSlideWhenXIsPlaying

	| terniLapilli |
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 3@2 with: 2@2) to: #O.
	terniLapilli addAll: (Set with: 1@1 with: 1@2 with: 2@3) to: #X.
	
	self 
		should: [terniLapilli slideOFrom: 3@2 to: 3@3]  
		raise: Error - MessageNotUnderstood 
		withMessageText: (TerniLapilli notYourTurnErrorMessage ).

	! !

!TerniLapilliTests methodsFor: 'sliding tests' stamp: 'J.S 5/26/2019 18:39:18'!
test23OCannotSlideOutOfBoard

	| terniLapilli |
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 3@2 with: 2@2) to: #O.
	terniLapilli addAll: (Set with: 1@1 with: 1@2 with: 2@3) to: #X.

	terniLapilli slideXFrom: 1@1 to: 2@1.
	
	self 
		should: [terniLapilli slideOFrom: 3@1 to: 4@1]  
		raise: Error - MessageNotUnderstood 
		withMessageText: (TerniLapilli positionNotInBoardErrorMessage ).

	! !

!TerniLapilliTests methodsFor: 'sliding tests' stamp: 'J.S 5/26/2019 18:36:16'!
test23XCannotSlideOutOfBoard

	| terniLapilli |
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 3@2 with: 2@2) to: #O.
	terniLapilli addAll: (Set with: 1@1 with: 1@2 with: 2@3) to: #X.
	
	self 
		should: [terniLapilli slideXFrom: 2@3 to: 2@4]  
		raise: Error - MessageNotUnderstood 
		withMessageText: (TerniLapilli positionNotInBoardErrorMessage ).

	! !

!TerniLapilliTests methodsFor: 'sliding tests' stamp: 'J.S 5/26/2019 18:39:36'!
test24XCannotSlideToNonContiguousPosition
	| terniLapilli |
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 3@2 with: 2@2) to: #O.
	terniLapilli addAll: (Set with: 1@1 with: 1@2 with: 2@3) to: #X.
	
	self 
		should: [terniLapilli slideXFrom: 2@3 to: 2@1]  
		raise: Error - MessageNotUnderstood 
		withMessageText: (TerniLapilli invalidSlidingErrorMessage).

	! !

!TerniLapilliTests methodsFor: 'sliding tests' stamp: 'J.S 5/26/2019 18:43:12'!
test25OCannotSlideToNonContiguousPosition
	| terniLapilli |
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 3@2 with: 2@2) to: #O.
	terniLapilli addAll: (Set with: 1@1 with: 1@2 with: 2@3) to: #X.
	
	terniLapilli slideXFrom: 1@1 to: 2@1.
	
	self 
		should: [terniLapilli slideOFrom: 3@1 to: 1@3]  
		raise: Error - MessageNotUnderstood 
		withMessageText: (TerniLapilli invalidSlidingErrorMessage).

	! !


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

!TerniLapilliTests methodsFor: 'game over tests' stamp: 'J.S 5/26/2019 18:43:32'!
test26PlayerWinsIfCompletesTopRow
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 1@1 with: 1@2 with:1@3) to: #X.
	
	self assert: (terniLapilli hasPlayerXWon).! !

!TerniLapilliTests methodsFor: 'game over tests' stamp: 'J.S 5/26/2019 18:43:38'!
test27PlayerWinsIfCompletesMiddleRow
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 2@1 with: 2@2 with:2@3) to: #X.
	
	self assert: (terniLapilli hasPlayerXWon).! !

!TerniLapilliTests methodsFor: 'game over tests' stamp: 'J.S 5/26/2019 18:43:43'!
test28PlayerWinsIfCompletesLowerRow
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 3@2 with:3@3) to: #X.
	
	self assert: (terniLapilli hasPlayerXWon).! !

!TerniLapilliTests methodsFor: 'game over tests' stamp: 'J.S 5/26/2019 18:43:57'!
test29PlayerWinsIfCompletesFirstColumn
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 1@1 with: 2@1 with:3@1) to: #X.
	
	self assert: (terniLapilli hasPlayerXWon).! !

!TerniLapilliTests methodsFor: 'game over tests' stamp: 'J.S 5/26/2019 18:44:04'!
test30PlayerWinsIfCompletesSecondColumn
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 1@2 with: 2@2 with:3@2) to: #X.
	
	self assert: (terniLapilli hasPlayerXWon).! !

!TerniLapilliTests methodsFor: 'game over tests' stamp: 'J.S 5/26/2019 18:44:09'!
test31PlayerWinsIfCompletesThirdColumn
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 1@3 with: 2@3 with:3@3) to: #X.
	
	self assert: (terniLapilli hasPlayerXWon).! !

!TerniLapilliTests methodsFor: 'game over tests' stamp: 'J.S 5/26/2019 18:44:14'!
test32PlayerWinsIfCompletesDiagonalFromTopLeftToBottomRight
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 1@1 with: 2@2 with:3@3) to: #X.
	
	self assert: (terniLapilli hasPlayerXWon).! !

!TerniLapilliTests methodsFor: 'game over tests' stamp: 'J.S 5/26/2019 18:44:19'!
test33PlayerWinsIfCompletesDiagonalFromBottomLeftToTopRight
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 2@2 with:1@3) to: #X.
	
	self assert: (terniLapilli hasPlayerXWon).! !

!TerniLapilliTests methodsFor: 'game over tests' stamp: 'J.S 5/26/2019 18:44:26'!
test34WhenPlayerWinsGameIsOver
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli addAll: (Set with: 3@1 with: 2@2 with:1@3) to: #X.
	
	self assert: (terniLapilli isOver).! !


!classDefinition: #GameState category: #TerniLapilli!
Object subclass: #GameState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

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


!GameState methodsFor: 'testing' stamp: 'J.S 5/26/2019 19:08:08'!
isOPlaying

	self subclassResponsibility .! !

!GameState methodsFor: 'testing' stamp: 'J.S 5/26/2019 19:02:30'!
isOver

	self subclassResponsibility ! !

!GameState methodsFor: 'testing' stamp: 'J.S 5/26/2019 19:41:15'!
isXPlaying

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameState class' category: #TerniLapilli!
GameState class
	instanceVariableNames: ''!

!GameState class methodsFor: 'instance creation' stamp: 'J.S 5/26/2019 22:32:58'!
with: aTerniLapilli

	self subclassResponsibility ! !


!GameState class methodsFor: 'testing' stamp: 'J.S 5/26/2019 23:34:57'!
canHandle: aTerniLapilli

	self subclassResponsibility .! !


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


!GameOver methodsFor: 'testing' stamp: 'J.S 5/26/2019 19:10:15'!
isOPlaying

	^ false.! !

!GameOver methodsFor: 'testing' stamp: 'J.S 5/26/2019 19:10:04'!
isOver

	^ true.! !

!GameOver methodsFor: 'testing' stamp: 'J.S 5/26/2019 19:10:43'!
isXPlaying

	^ false.! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOver class' category: #TerniLapilli!
GameOver class
	instanceVariableNames: ''!

!GameOver class methodsFor: 'instance creation' stamp: 'J.S 5/26/2019 22:32:14'!
with: aTerniLapilli

	^ self new! !


!GameOver class methodsFor: 'testing' stamp: 'J.S 5/26/2019 23:20:11'!
canHandle: aTerniLapilli.

	^ aTerniLapilli hasAnyWon! !


!classDefinition: #OMarking category: #TerniLapilli!
GameState subclass: #OMarking
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!OMarking methodsFor: 'testing' stamp: 'J.S 5/26/2019 19:32:34'!
isOPlaying

	^ true.! !

!OMarking methodsFor: 'testing' stamp: 'J.S 5/26/2019 19:12:27'!
isOver

	^ false.! !

!OMarking methodsFor: 'testing' stamp: 'J.S 5/26/2019 19:32:42'!
isXPlaying

	^ false.! !


!OMarking methodsFor: 'functionality' stamp: 'J.S 5/26/2019 20:00:57'!
putOAt: aPosition 

	terniLapilli mark: aPosition from: #O ! !

!OMarking methodsFor: 'functionality' stamp: 'J.S 5/26/2019 19:29:19'!
putXAt: aPosition 

	self error: TerniLapilli notYourTurnErrorMessage.! !

!OMarking methodsFor: 'functionality' stamp: 'J.S 5/26/2019 19:30:14'!
slideOFrom: aPosition to: aDestinationPosition

	self error: TerniLapilli cannotSlideYetErrorMessage.! !

!OMarking methodsFor: 'functionality' stamp: 'J.S 5/26/2019 22:42:57'!
slideXFrom: aPosition to: aDestinationPosition

	^ self error: TerniLapilli notYourTurnErrorMessage.! !


!OMarking methodsFor: 'initialization' stamp: 'J.S 5/26/2019 19:58:39'!
initializeWith: aTerniLapilli.

	terniLapilli  := aTerniLapilli.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OMarking class' category: #TerniLapilli!
OMarking class
	instanceVariableNames: ''!

!OMarking class methodsFor: 'instance creation' stamp: 'J.S 5/26/2019 19:59:33'!
with: aTerniLapilli

	^ self new initializeWith: aTerniLapilli.! !


!OMarking class methodsFor: 'testing' stamp: 'J. 5/26/2019 23:42:23'!
canHandle: aTerniLapilli

	^ (aTerniLapilli hasTokensLeft: #O)
		and: aTerniLapilli isXPlaying 
		and: (aTerniLapilli hasAnyWon) not ! !


!classDefinition: #OSliding category: #TerniLapilli!
GameState subclass: #OSliding
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!OSliding methodsFor: 'testing' stamp: 'J.S 5/26/2019 19:36:03'!
isOPlaying

	^ true.! !

!OSliding methodsFor: 'testing' stamp: 'J.S 5/26/2019 19:11:10'!
isOver

	^ false.! !

!OSliding methodsFor: 'testing' stamp: 'J.S 5/26/2019 19:11:49'!
isXPlaying

	^ false.! !


!OSliding methodsFor: 'functionality' stamp: 'J.S 5/26/2019 19:39:23'!
putOAt: aPosition

	self error: TerniLapilli cannotMarkMorePositionsErrorMessage .! !

!OSliding methodsFor: 'functionality' stamp: 'J.S 5/26/2019 19:39:10'!
putXAt: aPosition

	self error: TerniLapilli notYourTurnErrorMessage.! !

!OSliding methodsFor: 'functionality' stamp: 'J.S 5/26/2019 23:00:44'!
slideOFrom: aPosition to: aDestinationPosition
	
	terniLapilli slide: aPosition to: aDestinationPosition from: #O. ! !

!OSliding methodsFor: 'functionality' stamp: 'J.S 5/26/2019 19:40:33'!
slideXFrom: aPosition to: aDestinationPosition
	
	self error: TerniLapilli notYourTurnErrorMessage .! !


!OSliding methodsFor: 'initialization' stamp: 'J.S 5/26/2019 19:58:51'!
initializeWith: aTerniLapilli.

	terniLapilli  := aTerniLapilli.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OSliding class' category: #TerniLapilli!
OSliding class
	instanceVariableNames: ''!

!OSliding class methodsFor: 'instance creation' stamp: 'J.S 5/26/2019 19:59:42'!
with: aTerniLapilli

	^ self new initializeWith: aTerniLapilli.! !


!OSliding class methodsFor: 'testing' stamp: 'J. 5/26/2019 23:45:32'!
canHandle: aTerniLapilli

	^ (aTerniLapilli hasTokensLeft: #O) not 
		and: (aTerniLapilli isXPlaying) 
		and: (aTerniLapilli hasAnyWon) not ! !


!classDefinition: #XMarking category: #TerniLapilli!
GameState subclass: #XMarking
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!XMarking methodsFor: 'functionality' stamp: 'J.S 5/25/2019 14:55:58'!
putOAt: aPosition 

	self error: TerniLapilli notYourTurnErrorMessage.! !

!XMarking methodsFor: 'functionality' stamp: 'J.S 5/26/2019 20:00:22'!
putXAt: aPosition 

	terniLapilli mark: aPosition from: #X 
	! !

!XMarking methodsFor: 'functionality' stamp: 'J.S 5/26/2019 12:57:05'!
slideOFrom: aPosition to: aDestinationPosition	
	
	self error: (TerniLapilli notYourTurnErrorMessage)! !

!XMarking methodsFor: 'functionality' stamp: 'J.S 5/26/2019 19:27:57'!
slideXFrom: aPosition to: aDestinationPosition

	self error: TerniLapilli cannotSlideYetErrorMessage 	
	! !


!XMarking methodsFor: 'testing' stamp: 'J.S 5/26/2019 19:13:36'!
isOPlaying

	^ false! !

!XMarking methodsFor: 'testing' stamp: 'J.S 5/26/2019 19:13:27'!
isOver

	^ false! !

!XMarking methodsFor: 'testing' stamp: 'J.S 5/26/2019 19:13:32'!
isXPlaying

	^ true! !


!XMarking methodsFor: 'initialization' stamp: 'J.S 5/26/2019 19:59:03'!
initializeWith: aTerniLapilli.

	terniLapilli  := aTerniLapilli.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XMarking class' category: #TerniLapilli!
XMarking class
	instanceVariableNames: ''!

!XMarking class methodsFor: 'instance creation' stamp: 'J.S 5/26/2019 19:59:48'!
with: aTerniLapilli

	^ self new initializeWith: aTerniLapilli.! !


!XMarking class methodsFor: 'testing' stamp: 'J. 5/26/2019 23:45:45'!
canHandle: aTerniLapilli

	^ (aTerniLapilli hasTokensLeft: #X) 
		and: (aTerniLapilli isOPlaying ) 
		and: (aTerniLapilli hasAnyWon) not ! !


!classDefinition: #XSliding category: #TerniLapilli!
GameState subclass: #XSliding
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!XSliding methodsFor: 'testing' stamp: 'J.S 5/26/2019 19:14:50'!
isOPlaying

	^ false.! !

!XSliding methodsFor: 'testing' stamp: 'J.S 5/26/2019 19:14:16'!
isOver

	^ false.! !

!XSliding methodsFor: 'testing' stamp: 'J.S 5/26/2019 19:36:22'!
isXPlaying

	^ true.! !


!XSliding methodsFor: 'functionality' stamp: 'J.S 5/26/2019 19:38:31'!
putOAt: aPosition

	self error: TerniLapilli notYourTurnErrorMessage ! !

!XSliding methodsFor: 'functionality' stamp: 'J.S 5/26/2019 22:56:57'!
putXAt: aPosition

	self error: TerniLapilli cannotMarkMorePositionsErrorMessage ! !

!XSliding methodsFor: 'functionality' stamp: 'J.S 5/26/2019 19:37:39'!
slideOFrom: aPosition to: aDestinationPosition

	self error: TerniLapilli notYourTurnErrorMessage.	
	! !

!XSliding methodsFor: 'functionality' stamp: 'J.S 5/26/2019 20:00:32'!
slideXFrom: aPosition to: aDestinationPosition

	terniLapilli slide: aPosition to: aDestinationPosition from: #X.	
	! !


!XSliding methodsFor: 'initialization' stamp: 'J.S 5/26/2019 19:59:11'!
initializeWith: aTerniLapilli.

	terniLapilli  := aTerniLapilli.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XSliding class' category: #TerniLapilli!
XSliding class
	instanceVariableNames: ''!

!XSliding class methodsFor: 'instance creation' stamp: 'J.S 5/26/2019 19:59:58'!
with: aTerniLapilli

	^ self new initializeWith: aTerniLapilli.! !


!XSliding class methodsFor: 'testing' stamp: 'J. 5/26/2019 23:45:52'!
canHandle: aTerniLapilli

	^ (aTerniLapilli hasTokensLeft: #X) not 
		and: (aTerniLapilli isOPlaying ) 
		and: (aTerniLapilli hasAnyWon) not 

	! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'positionsMarkedByPlayer gameState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'testing' stamp: 'J.S 5/26/2019 23:24:58'!
hasPlayerOWon
	
	^ self hasWon: #O.! !

!TerniLapilli methodsFor: 'testing' stamp: 'J.S 5/26/2019 23:24:35'!
hasPlayerXWon
	
	^ self hasWon: #X.! !

!TerniLapilli methodsFor: 'testing' stamp: 'J.S 5/26/2019 15:59:07'!
isEmpty: aPosition

	^ (((self positionsMarkedByX) union: (self positionsMarkedByO)) includes: aPosition) not! !

!TerniLapilli methodsFor: 'testing' stamp: 'J.S 5/26/2019 22:34:38'!
isOPlaying

	^ gameState isOPlaying! !

!TerniLapilli methodsFor: 'testing' stamp: 'J.S 5/26/2019 23:16:03'!
isOver

	^ self hasPlayerXWon or: self hasPlayerOWon.! !

!TerniLapilli methodsFor: 'testing' stamp: 'J.S 5/26/2019 22:34:47'!
isXPlaying

	^ gameState isXPlaying! !


!TerniLapilli methodsFor: 'functionality' stamp: 'J.S 5/26/2019 20:04:26'!
putOAt: aPosition
		
	gameState putOAt: aPosition.
	! !

!TerniLapilli methodsFor: 'functionality' stamp: 'J.S 5/26/2019 20:04:38'!
putXAt: aPosition 
	
	gameState putXAt: aPosition.


	
	! !

!TerniLapilli methodsFor: 'functionality' stamp: 'J.S 5/26/2019 20:05:03'!
slideOFrom: aPosition to: aDestinationPosition 
	
	gameState slideOFrom: aPosition to: aDestinationPosition .! !

!TerniLapilli methodsFor: 'functionality' stamp: 'J.S 5/26/2019 20:05:14'!
slideXFrom: aPosition to: aDestinationPosition 
	
	gameState slideXFrom: aPosition to: aDestinationPosition .! !


!TerniLapilli methodsFor: 'initialization' stamp: 'J.S 5/26/2019 19:43:06'!
initialize

	positionsMarkedByPlayer := Dictionary new.
	positionsMarkedByPlayer add: (#X -> Set new).
	positionsMarkedByPlayer add: (#O -> Set new).
	gameState := XMarking with: self.! !


!TerniLapilli methodsFor: 'internal' stamp: 'J. 5/26/2019 23:51:10'!
addAll: aCollectionOfPositions to: aPlayer
	"creado para testear mas facil"
	
	(self positionsMarkedBy: aPlayer) addAll: aCollectionOfPositions.
	self updateGameState ! !

!TerniLapilli methodsFor: 'internal' stamp: 'J.S 5/26/2019 23:19:25'!
hasAnyWon

	^ (self hasWon: #O) or: (self hasWon: #X)! !

!TerniLapilli methodsFor: 'internal' stamp: 'J. 5/26/2019 23:40:51'!
hasTokensLeft: aPlayer

	^ (self positionsMarkedBy: aPlayer) size < 3! !

!TerniLapilli methodsFor: 'internal' stamp: 'J.S 5/26/2019 22:15:54'!
hasWon: aPlayer

	^ TerniLapilli winningScenarios values anySatisfy: [:aWinnerCombination | (self positionsMarkedBy: aPlayer) = aWinnerCombination].! !

!TerniLapilli methodsFor: 'internal' stamp: 'J. 5/26/2019 23:58:17'!
mark: aPosition from: aPlayer
	
	self failIfNotEmpty: aPosition.
	self failIfNotInBoard: aPosition.
	
	(self positionsMarkedBy: aPlayer) add: aPosition.
	
	self updateGameState.
! !

!TerniLapilli methodsFor: 'internal' stamp: 'J.S 5/26/2019 15:02:12'!
positionsMarkedBy: aPlayer
	
	^ (positionsMarkedByPlayer 
		at: aPlayer 
		ifAbsent: [self error: TerniLapilli playerDoNotExistErrorMessage ]).
! !

!TerniLapilli methodsFor: 'internal' stamp: 'J. 5/27/2019 00:02:18'!
slide: aPosition to: aDestinationPosition from: aPlayer
	
	self failIfNotEmpty: aDestinationPosition.
	self failIfNotInBoard: aDestinationPosition.
	self failIfInvalidSlide: aPosition to: aDestinationPosition.
	
	(self positionsMarkedBy: aPlayer) remove: aPosition.
	(self positionsMarkedBy: aPlayer) add: aDestinationPosition .
	
	self updateGameState.
! !

!TerniLapilli methodsFor: 'internal' stamp: 'J. 5/26/2019 23:50:02'!
updateGameState

	gameState  := (GameState subclasses detect: [:aGameStateClass | aGameStateClass canHandle: self]) with: self.! !


!TerniLapilli methodsFor: 'accessing' stamp: 'J. 5/26/2019 23:49:36'!
positionsMarked

	^ positionsMarkedByPlayer 
		inject: (Set new) 
		into: [:positionsOfPlayerA :positionsOfPlayerB | positionsOfPlayerA union: positionsOfPlayerB].! !

!TerniLapilli methodsFor: 'accessing' stamp: 'J.S 5/26/2019 00:33:57'!
positionsMarkedByO

	^ self positionsMarkedBy: #O! !

!TerniLapilli methodsFor: 'accessing' stamp: 'J.S 5/26/2019 00:22:12'!
positionsMarkedByX

	^ self positionsMarkedBy: #X.! !


!TerniLapilli methodsFor: 'validation' stamp: 'J. 5/26/2019 23:59:19'!
failIfInvalidSlide: aPosition to: aDestinationPosition	

	| deltaX deltaY |
	deltaX := (aPosition x - aDestinationPosition x) abs.
	deltaY := (aPosition y - aDestinationPosition y) abs.
	(deltaX > 1 or: deltaY > 1) 
		ifTrue: [self error: TerniLapilli invalidSlidingErrorMessage ].! !

!TerniLapilli methodsFor: 'validation' stamp: 'J. 5/26/2019 23:57:35'!
failIfNotEmpty: aPosition
	
	(self isEmpty: aPosition)
		ifFalse: [self error: (TerniLapilli positionNotEmptyErrorMessage )].! !

!TerniLapilli methodsFor: 'validation' stamp: 'J. 5/26/2019 23:57:39'!
failIfNotInBoard: aPosition

	| xInRange yInRange |
	xInRange := aPosition x between: 1 and: 3.
	yInRange := aPosition y between: 1 and: 3.
	(xInRange and: yInRange)
		ifFalse: [self error: TerniLapilli positionNotInBoardErrorMessage].! !

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