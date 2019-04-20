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


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Jonathan Scherman 4/20/2019 04:02:24'!
test01AnEmptyPrefixOnFindMethodShouldRaiseError

	self assertThatFindingWithPrefix: '' throwsErrorWithMessageText: SentenceFinderByPrefix prefixCannotBeEmptyErrorDescription .! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Jonathan Scherman 4/20/2019 04:02:52'!
test02APrefixWithSpacesOnFindMethodShouldRaiseError

	self assertThatFindingWithPrefix: 'Paul McCartney' throwsErrorWithMessageText: SentenceFinderByPrefix prefixCannotContainSpacesErrorDescription.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Jonathan Scherman 4/20/2019 04:04:36'!
test03AnEmptyStackShouldReturnAnEmptyCollection
	
	aSentenceFinderByPrefix := SentenceFinderByPrefix with: OOStack new.

	self 
		assert: aSentenceFinderByPrefix 
		doesNotFindSentencesWithPrefix: 'paulmccartney'.
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Jonathan Scherman 4/20/2019 03:55:19'!
test04APrefixThatIsNotInTheStackShouldReturnAnEmptyCollection

	self 
		assert: aSentenceFinderByPrefix 
		doesNotFindSentencesWithPrefix: 'paulmccartney'.
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Jonathan Scherman 4/20/2019 03:43:00'!
test05FindShouldReturnAllElementsWithTheGivenPrefix
	
	|aCollection theExpectedCollection|
	
	aCollection := aSentenceFinderByPrefix find: 'sime'.
	theExpectedCollection := Bag withAll: #('simetricadefinidapositiva' 'simetrica definida positiva' 'sime trica definida positiva').
	
	self assert: aCollection = theExpectedCollection 
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Jonathan Scherman 4/20/2019 03:55:30'!
test06FindShouldBeCaseSensitive
	
	self 
		assert: aSentenceFinderByPrefix 
		doesNotFindSentencesWithPrefix: 'Sime'.! !


!SentenceFinderByPrefixTest methodsFor: 'asserting' stamp: 'Jonathan Scherman 4/20/2019 03:50:40'!
assert: asd doesNotFindSentencesWithPrefix: aPrefix

	self assert: (asd find: aPrefix) isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'asserting' stamp: 'Jonathan Scherman 4/20/2019 04:01:52'!
assertThatFindingWithPrefix: aPrefix throwsErrorWithMessageText: aMessageText
 
	self 
		should: [aSentenceFinderByPrefix find: aPrefix] 
		raise: Error 
		asserting: [ :anError | self assert: anError messageText = aMessageText ]
! !

!SentenceFinderByPrefixTest methodsFor: 'asserting' stamp: 'J.S 4/19/2019 15:20:30'!
should: aBlockToRun raise: anExceptionType 

	^self should: aBlockToRun raise: anExceptionType asserting: []

	
! !

!SentenceFinderByPrefixTest methodsFor: 'asserting' stamp: 'J.S 4/19/2019 15:19:48'!
should: aBlockToRun raise: anExceptionType asserting: aVerificationBlock

	[ aBlockToRun value.
	self fail ]
		on: anExceptionType 
		do: aVerificationBlock 
	
! !


!classDefinition: #OOAbstractStackElement category: #'Stack-Exercise'!
Object subclass: #OOAbstractStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOAbstractStackElement methodsFor: 'functionality' stamp: 'Jonathan Scherman 4/20/2019 02:24:15'!
previous

	self shouldBeImplemented.! !

!OOAbstractStackElement methodsFor: 'functionality' stamp: 'Jonathan Scherman 4/20/2019 02:24:17'!
size

	self shouldBeImplemented.! !

!OOAbstractStackElement methodsFor: 'functionality' stamp: 'Jonathan Scherman 4/20/2019 02:24:19'!
value

	self shouldBeImplemented.! !


!OOAbstractStackElement methodsFor: 'inspecting' stamp: 'Jonathan Scherman 4/20/2019 02:23:56'!
isEmpty

	self shouldBeImplemented.! !


!classDefinition: #OONullStackElement category: #'Stack-Exercise'!
OOAbstractStackElement subclass: #OONullStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OONullStackElement methodsFor: 'functionality' stamp: 'Jonathan Scherman 4/20/2019 02:21:16'!
previous

	^OOStack stackEmptyErrorDescription ! !

!OONullStackElement methodsFor: 'functionality' stamp: 'Jonathan Scherman 4/20/2019 02:10:48'!
size
	
	^0.! !

!OONullStackElement methodsFor: 'functionality' stamp: 'Jonathan Scherman 4/20/2019 02:21:20'!
value

	^self error: OOStack stackEmptyErrorDescription ! !


!OONullStackElement methodsFor: 'inspecting' stamp: 'Jonathan Scherman 4/20/2019 02:07:53'!
isEmpty

	^true.! !


!classDefinition: #OOStackElement category: #'Stack-Exercise'!
OOAbstractStackElement subclass: #OOStackElement
	instanceVariableNames: 'value previous'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'functionality' stamp: 'Jonathan Scherman 4/20/2019 02:25:13'!
previous

	^previous ! !

!OOStackElement methodsFor: 'functionality' stamp: 'Jonathan Scherman 4/20/2019 02:11:24'!
size

	^1 + previous size.! !

!OOStackElement methodsFor: 'functionality' stamp: 'Jonathan Scherman 4/20/2019 02:25:22'!
value

	^value! !


!OOStackElement methodsFor: 'inspecting' stamp: 'Jonathan Scherman 4/20/2019 02:08:05'!
isEmpty

	^false.! !


!OOStackElement methodsFor: 'initialization' stamp: 'Jonathan Scherman 4/20/2019 02:13:50'!
initializeWithValue: aValue previous: aList

	value := aValue.
	previous := aList! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackElement class' category: #'Stack-Exercise'!
OOStackElement class
	instanceVariableNames: ''!

!OOStackElement class methodsFor: 'instance creation' stamp: 'Jonathan Scherman 4/20/2019 02:28:46'!
withValue: aValue previous: anElement

	^ self new initializeWithValue: aValue previous: anElement! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'lastElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'inspecting' stamp: 'Jonathan Scherman 4/20/2019 02:08:59'!
isEmpty

	^lastElement isEmpty.! !


!OOStack methodsFor: 'functionality' stamp: 'Jonathan Scherman 4/20/2019 02:26:10'!
pop

	| poppedElement |
	
	poppedElement := lastElement value.
	lastElement := lastElement previous.
	^poppedElement! !

!OOStack methodsFor: 'functionality' stamp: 'Jonathan Scherman 4/20/2019 02:26:47'!
push: aValue 

	| newElement |
	
	newElement := OOStackElement withValue: aValue previous: lastElement.
	lastElement := newElement! !

!OOStack methodsFor: 'functionality' stamp: 'Jonathan Scherman 4/20/2019 02:26:51'!
size

	^lastElement size! !

!OOStack methodsFor: 'functionality' stamp: 'Jonathan Scherman 4/20/2019 02:26:54'!
top

	^lastElement value! !


!OOStack methodsFor: 'initialization' stamp: 'Jonathan Scherman 4/20/2019 02:15:11'!
initialize

	lastElement := OONullStackElement new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'sentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'functionality' stamp: 'Jonathan Scherman 4/20/2019 03:18:50'!
add: aSentence to: aCollection ifSatisfies: aBlockCondition

	(aBlockCondition value: aSentence) ifTrue: [aCollection add: aSentence].! !

!SentenceFinderByPrefix methodsFor: 'functionality' stamp: 'Jonathan Scherman 4/20/2019 03:21:17'!
find: aPrefix

	self assertIsValid: aPrefix.
	^self getSentencesBeginningWith: aPrefix.
! !

!SentenceFinderByPrefix methodsFor: 'functionality' stamp: 'Jonathan Scherman 4/20/2019 03:22:50'!
getSentencesBeginningWith: aPrefix

	|  sentencesBeginningWithPrefix  |.
	
	sentencesBeginningWithPrefix := Bag new.
	
	^self 
		select: [:aSentence | aSentence beginsWith: aPrefix] 
		from: sentences
		andCollectResultsAt: sentencesBeginningWithPrefix.! !

!SentenceFinderByPrefix methodsFor: 'functionality' stamp: 'Jonathan Scherman 4/20/2019 03:23:51'!
initializeWith: aStackOfSentences

	sentences := aStackOfSentences! !

!SentenceFinderByPrefix methodsFor: 'functionality' stamp: 'Jonathan Scherman 4/20/2019 03:19:16'!
select: aBlockCondition from: aStack andCollectResultsAt: aResultsCollection
	
	(aStack isEmpty) ifFalse:
	[ 
		| aSentence |.
		
		aSentence := aStack pop.
		self add: aSentence to: aResultsCollection ifSatisfies: aBlockCondition.
		self select: aBlockCondition from: aStack andCollectResultsAt: aResultsCollection.
		aStack push: aSentence.
	].

	^aResultsCollection
! !


!SentenceFinderByPrefix methodsFor: 'asserting' stamp: 'Jonathan Scherman 4/20/2019 02:41:48'!
assertIsValid: aPrefix

	(aPrefix isEmpty) ifTrue: [self error: self class prefixCannotBeEmptyErrorDescription ].
	(aPrefix includesSubString: ' ') ifTrue: [self error: self class prefixCannotContainSpacesErrorDescription ].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: 'uniqueInstance'!

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'Jonathan Scherman 4/20/2019 03:24:28'!
with: aStackOfSentences

	^ self new initializeWith: aStackOfSentences! !


!SentenceFinderByPrefix class methodsFor: 'error' stamp: 'Jonathan Scherman 4/20/2019 03:24:09'!
prefixCannotBeEmptyErrorDescription

	^'The prefix cannot be empty'! !

!SentenceFinderByPrefix class methodsFor: 'error' stamp: 'Jonathan Scherman 4/20/2019 03:24:14'!
prefixCannotContainSpacesErrorDescription

	^'The prefix cannot contain spaces'! !
