!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'aSentenceFinderByPrefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setUp/tearDown' stamp: 'J.S 4/19/2019 14:32:02'!
setUp

	| aStack |
	
	aStack := OOStack new.
	
	aStack push: 'simétrica definida positiva'.
	aStack push: 'simetrica definida positiva'.
	aStack push: 'sime trica definida positiva'.
	aStack push: 'mi mama me mima'.
	aStack push: 'simetricadefinidapositiva'.
	
	aSentenceFinderByPrefix := SentenceFinderByPrefix with: aStack .! !


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'J.S 4/19/2019 15:29:00'!
test01AnEmptyPrefixOnFindMethodShouldRaiseError
	^self should: [aSentenceFinderByPrefix find: ''] raise: Error asserting: [ :anError | self assert: anError messageText = SentenceFinderByPrefix prefixCannotBeEmptyErrorDescription ]
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'J.S 4/19/2019 21:43:43'!
test02APrefixWithSpacesOnFindMethodShouldRaiseError
	self should: [aSentenceFinderByPrefix find: 'Paul McCartney'] raise: Error asserting: [ :anError | self assert: anError messageText = SentenceFinderByPrefix prefixCannotContainSpacesErrorDescription ]
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'J.S 4/19/2019 22:46:03'!
test03APrefixThatIsntInTheStackShouldReturnAnEmptyCollection
	self assert: ((aSentenceFinderByPrefix find: 'paulmccartney') size = 0)
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'J.S 4/19/2019 21:43:35'!
test04FindShouldReturnAllElementsWithTheGivenPrefix
	
	|aCollection theExpectedCollection|
	
	aCollection := aSentenceFinderByPrefix find: 'sime'.
	theExpectedCollection := Bag withAll: #('simetricadefinidapositiva' 'simetrica definida positiva' 'sime trica definida positiva').
	
	self assert: aCollection = theExpectedCollection 
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'J.S 4/19/2019 21:43:31'!
test05FindShouldBeCaseSensitive
	
	self assert: ((aSentenceFinderByPrefix find: 'Sime') size = 0)
! !


!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'J.S 4/19/2019 15:20:30'!
should: aBlockToRun raise: anExceptionType 

	^self should: aBlockToRun raise: anExceptionType asserting: []

	
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'J.S 4/19/2019 15:19:48'!
should: aBlockToRun raise: anExceptionType asserting: aVerificationBlock

	[ aBlockToRun value.
	self fail ]
		on: anExceptionType 
		do: aVerificationBlock 
	
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'inspecting' stamp: 'J.S 4/16/2019 00:14:42'!
isEmpty
	^(elements size = 0)! !


!OOStack methodsFor: 'functionality' stamp: 'J.S 4/16/2019 00:38:45'!
pop
	| poppedElement |
	
	poppedElement := self elements elementValue.
	elements := self elements previousElement.
	^poppedElement! !

!OOStack methodsFor: 'functionality' stamp: 'J.S 4/16/2019 00:17:54'!
push: aValue 
	| newElement |
	
	newElement := StackElement createWith: aValue andAddTo: elements.
	elements := newElement! !

!OOStack methodsFor: 'functionality' stamp: 'J.S 4/16/2019 00:39:51'!
size
	^elements size! !

!OOStack methodsFor: 'functionality' stamp: 'J.S 4/16/2019 00:37:00'!
top
	^elements elementValue! !


!OOStack methodsFor: 'as yet unclassified' stamp: 'J.S 4/16/2019 00:25:14'!
elements
	^elements! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'J.S 4/16/2019 00:08:14'!
initialize
	elements := StackBottom new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'J.S 4/19/2019 23:01:38'!
add: aSentence to: aSet ifBeginsWith: aPrefix

	(aSentence beginsWith: aPrefix) ifTrue: [
		aSet add: aSentence.
	].
! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'J.S 4/19/2019 20:38:54'!
assertIsValid: aPrefix
	(aPrefix isEmpty) ifTrue: [self error: self class prefixCannotBeEmptyErrorDescription ].
	(aPrefix includesSubString: ' ') ifTrue: [self error: self class prefixCannotContainSpacesErrorDescription ].
	! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'J.S 4/19/2019 21:17:58'!
find: aPrefix

	self assertIsValid: aPrefix.
	^self getElementsBeginningWith: aPrefix.
! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'J.S 4/19/2019 23:01:47'!
getElementsBeginningWith: aPrefix

	|  sentencesBeginningWithPrefix  |.
	
	sentencesBeginningWithPrefix := Set new.
	
	^self select: [:aSentence | self add: aSentence to: sentencesBeginningWithPrefix ifBeginsWith: aPrefix] from: stack using: sentencesBeginningWithPrefix.
! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'J.S 4/19/2019 10:30:33'!
initializeWith: aStack
	stack := aStack! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'J.S 4/19/2019 23:02:02'!
select: aBlock from: aStack using: aSetOfSentences

	| aSentence |.
	
	(aStack isEmpty) ifFalse:
	[ 
		aSentence := aStack pop.
		aBlock value: aSentence.
		self select: aBlock from: aStack using: aSetOfSentences.
		aStack push: aSentence.
	].

	^aSetOfSentences
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: 'uniqueInstance'!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'J.S 4/19/2019 13:52:28'!
prefixCannotBeEmptyErrorDescription
	^'The prefix cannot be empty'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'J.S 4/19/2019 13:53:00'!
prefixCannotContainSpacesErrorDescription
	^'The prefix cannot contain spaces'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'J.S 4/19/2019 10:29:59'!
with: aStack
	^ self new initializeWith: aStack! !


!classDefinition: #StackBottom category: #'Stack-Exercise'!
Object subclass: #StackBottom
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackBottom methodsFor: 'as yet unclassified' stamp: 'J.S 4/16/2019 00:56:55'!
elementValue
	^self error: OOStack stackEmptyErrorDescription ! !

!StackBottom methodsFor: 'as yet unclassified' stamp: 'J.S 4/16/2019 00:07:33'!
size
	^0! !


!classDefinition: #StackElement category: #'Stack-Exercise'!
Object subclass: #StackElement
	instanceVariableNames: 'value previous'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackElement methodsFor: 'as yet unclassified' stamp: 'J.S 4/16/2019 00:02:48'!
elementValue
	^value! !

!StackElement methodsFor: 'as yet unclassified' stamp: 'J.S 4/16/2019 00:12:18'!
initializeWith: aValue andAddTo: aList

	value := aValue.
	previous := aList! !

!StackElement methodsFor: 'as yet unclassified' stamp: 'J.S 4/16/2019 00:02:08'!
previous: topOfTheStack
	previous := topOfTheStack ! !

!StackElement methodsFor: 'as yet unclassified' stamp: 'J.S 4/16/2019 00:02:22'!
previousElement
	^previous ! !

!StackElement methodsFor: 'as yet unclassified' stamp: 'J.S 4/16/2019 00:03:23'!
size
	^1 + self previousElement size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackElement class' category: #'Stack-Exercise'!
StackElement class
	instanceVariableNames: ''!

!StackElement class methodsFor: 'as yet unclassified' stamp: 'J.S 4/16/2019 00:28:00'!
createWith: aValue andAddTo: aList
	^ self new initializeWith: aValue andAddTo: aList! !
