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

!OOStackTest methodsFor: 'test' stamp: 'js 4/21/2019 15:27:14'!
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
	instanceVariableNames: 'aSentenceFinderByPrefix aRepeatedSentence aSentenceStartingWithSime anotherSentenceStartingWithSime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'js 4/21/2019 15:20:19'!
setUp

	| aStack |
	
	aStack := OOStack new.
	aRepeatedSentence  := 'mi mama me mima'.
	aSentenceStartingWithSime := 'simetrica definida positiva'.
	anotherSentenceStartingWithSime := 'simetricadefinidapositiva'.
	
	aStack push: 'simétrica definida positiva'.
	aStack push: aSentenceStartingWithSime .
	aStack push: aRepeatedSentence.
	aStack push: aRepeatedSentence.
	aStack push: anotherSentenceStartingWithSime .
	
	aSentenceFinderByPrefix := SentenceFinderByPrefix with: aStack .! !


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Jonathan Scherman 4/20/2019 04:02:24'!
test01AnEmptyPrefixOnFindMethodShouldRaiseError

	self assertThatFindingWithPrefix: '' throwsErrorWithMessageText: SentenceFinderByPrefix prefixCannotBeEmptyErrorDescription .! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Jonathan Scherman 4/20/2019 04:02:52'!
test02APrefixWithSpacesOnFindMethodShouldRaiseError

	self assertThatFindingWithPrefix: 'Paul McCartney' throwsErrorWithMessageText: SentenceFinderByPrefix prefixCannotContainSpacesErrorDescription.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'js 4/21/2019 16:21:21'!
test03AnEmptyStackShouldReturnAnEmptyCollection
	
	aSentenceFinderByPrefix := SentenceFinderByPrefix with: OOStack new.

	self assertASentenceFinderDoesNotFindSentencesWithPrefix: 'nonEmptyPrefix' .
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'js 4/21/2019 16:21:30'!
test04APrefixThatIsNotInTheStackShouldReturnAnEmptyCollection

	self assertASentenceFinderDoesNotFindSentencesWithPrefix: 'paulmccartney'.
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'js 4/21/2019 15:51:51'!
test05FindShouldReturnAllElementsWithTheGivenPrefix
	
	|aCollection theExpectedCollection|
	
	aCollection := aSentenceFinderByPrefix find: 'sime'.
	theExpectedCollection := OrderedCollection with:  aSentenceStartingWithSime with: anotherSentenceStartingWithSime.
	
	self assert: aCollection = theExpectedCollection 
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'js 4/21/2019 16:21:44'!
test06FindShouldBeCaseSensitive
	
	self assertASentenceFinderDoesNotFindSentencesWithPrefix: 'Sime'.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'js 4/21/2019 15:51:56'!
test07FindShouldReturnRepeatedSentecesAsWell
	
	| sentencesContainingPrefix expectedSentences |
	sentencesContainingPrefix := aSentenceFinderByPrefix  find: 'mi'.
	expectedSentences := OrderedCollection with: aRepeatedSentence with: aRepeatedSentence.
	
	self assert: expectedSentences equals: sentencesContainingPrefix .! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'js 4/21/2019 16:22:50'!
test08FindShouldPreserveTheStackGivenAPrefixThatIsInASentence
	
	|aStack aCopyOfTheStack anotherSentenceFinderByPrefix|
	aStack := OOStack new.
	aStack push: aSentenceStartingWithSime.
	aStack push: anotherSentenceStartingWithSime.
	aCopyOfTheStack :=  aStack copy.
	
	anotherSentenceFinderByPrefix := SentenceFinderByPrefix with: aStack.
	anotherSentenceFinderByPrefix find: 'sime'.
	
	self assert:  aStack containsTheSameAs: aCopyOfTheStack! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'js 4/21/2019 16:22:43'!
test09FindShouldPreserveTheStackGivenAPrefixThatIsntInASentence
	
	|aStack aCopyOfTheStack anotherSentenceFinderByPrefix|
	aStack := OOStack new.
	aStack push: aSentenceStartingWithSime.
	aStack push: aRepeatedSentence.
	aCopyOfTheStack :=  aStack copy.
	
	anotherSentenceFinderByPrefix := SentenceFinderByPrefix with: aStack.
	anotherSentenceFinderByPrefix find: 'coso'.
	
	self assert:  aStack containsTheSameAs: aCopyOfTheStack! !


!SentenceFinderByPrefixTest methodsFor: 'assertion' stamp: 'js 4/21/2019 16:05:23'!
assert: aStack containsTheSameAs: anotherStack

	[aStack isEmpty] whileFalse:
	[
		self assert: aStack pop equals: anotherStack pop.
	].! !

!SentenceFinderByPrefixTest methodsFor: 'assertion' stamp: 'js 4/21/2019 16:20:40'!
assertASentenceFinderDoesNotFindSentencesWithPrefix: aPrefix

	self assert: (aSentenceFinderByPrefix find: aPrefix) isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'assertion' stamp: 'Jonathan Scherman 4/20/2019 04:01:52'!
assertThatFindingWithPrefix: aPrefix throwsErrorWithMessageText: aMessageText
 
	self 
		should: [aSentenceFinderByPrefix find: aPrefix] 
		raise: Error 
		asserting: [ :anError | self assert: anError messageText = aMessageText ]
! !

!SentenceFinderByPrefixTest methodsFor: 'assertion' stamp: 'J.S 4/19/2019 15:19:48'!
should: aBlockToRun raise: anExceptionType asserting: aVerificationBlock

	[ aBlockToRun value.
	self fail ]
		on: anExceptionType 
		do: aVerificationBlock 
	
! !


!classDefinition: #LinkedListElement category: #'Stack-Exercise'!
Object subclass: #LinkedListElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!LinkedListElement methodsFor: 'functionality' stamp: 'js 4/21/2019 16:16:10'!
countChainSize

	self subclassResponsibility.! !

!LinkedListElement methodsFor: 'functionality' stamp: 'js 4/21/2019 16:16:16'!
previous

	self subclassResponsibility.! !

!LinkedListElement methodsFor: 'functionality' stamp: 'js 4/21/2019 16:16:22'!
value

	self subclassResponsibility.! !


!LinkedListElement methodsFor: 'inspecting' stamp: 'js 4/21/2019 16:16:28'!
isEmpty

	self subclassResponsibility.! !


!classDefinition: #NullLinkedListElement category: #'Stack-Exercise'!
LinkedListElement subclass: #NullLinkedListElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NullLinkedListElement methodsFor: 'functionality' stamp: 'js 4/21/2019 14:50:21'!
countChainSize
	
	^0.! !

!NullLinkedListElement methodsFor: 'functionality' stamp: 'Jonathan Scherman 4/20/2019 02:21:16'!
previous

	^OOStack stackEmptyErrorDescription ! !

!NullLinkedListElement methodsFor: 'functionality' stamp: 'Jonathan Scherman 4/20/2019 02:21:20'!
value

	^self error: OOStack stackEmptyErrorDescription ! !


!NullLinkedListElement methodsFor: 'inspecting' stamp: 'Jonathan Scherman 4/20/2019 02:07:53'!
isEmpty

	^true.! !


!classDefinition: #RealLinkedListElement category: #'Stack-Exercise'!
LinkedListElement subclass: #RealLinkedListElement
	instanceVariableNames: 'value previous'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!RealLinkedListElement methodsFor: 'functionality' stamp: 'js 4/21/2019 14:50:21'!
countChainSize

	^1 + previous countChainSize.! !

!RealLinkedListElement methodsFor: 'functionality' stamp: 'Jonathan Scherman 4/20/2019 02:25:13'!
previous

	^previous ! !

!RealLinkedListElement methodsFor: 'functionality' stamp: 'Jonathan Scherman 4/20/2019 02:25:22'!
value

	^value! !


!RealLinkedListElement methodsFor: 'inspecting' stamp: 'Jonathan Scherman 4/20/2019 02:08:05'!
isEmpty

	^false.! !


!RealLinkedListElement methodsFor: 'initialization' stamp: 'Jonathan Scherman 4/20/2019 02:13:50'!
initializeWithValue: aValue previous: aList

	value := aValue.
	previous := aList! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RealLinkedListElement class' category: #'Stack-Exercise'!
RealLinkedListElement class
	instanceVariableNames: ''!

!RealLinkedListElement class methodsFor: 'instance creation' stamp: 'Jonathan Scherman 4/20/2019 02:28:46'!
withValue: aValue previous: anElement

	^ self new initializeWithValue: aValue previous: anElement! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topOfStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'inspecting' stamp: 'js 4/21/2019 14:38:30'!
isEmpty

	^topOfStack isEmpty.! !


!OOStack methodsFor: 'functionality' stamp: 'js 4/21/2019 14:20:07'!
pop

	| poppedElement |
	
	poppedElement := topOfStack value.
	topOfStack := topOfStack previous.
	^poppedElement! !

!OOStack methodsFor: 'functionality' stamp: 'js 4/21/2019 14:20:13'!
push: aValue 

	| newElement |
	
	newElement := RealLinkedListElement withValue: aValue previous: topOfStack.
	topOfStack := newElement! !

!OOStack methodsFor: 'functionality' stamp: 'js 4/21/2019 15:26:17'!
size

	^topOfStack countChainSize! !

!OOStack methodsFor: 'functionality' stamp: 'js 4/21/2019 14:20:21'!
top

	^topOfStack value! !


!OOStack methodsFor: 'initialization' stamp: 'js 4/21/2019 14:20:01'!
initialize

	topOfStack := NullLinkedListElement new! !

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

!SentenceFinderByPrefix methodsFor: 'functionality' stamp: 'js 4/21/2019 15:52:22'!
find: aPrefix

	self assertIsValid: aPrefix.
	^sentences select: [:anElement | anElement beginsWith: aPrefix ]
! !


!SentenceFinderByPrefix methodsFor: 'private - assertion' stamp: 'Jonathan Scherman 4/20/2019 02:41:48'!
assertIsValid: aPrefix

	(aPrefix isEmpty) ifTrue: [self error: self class prefixCannotBeEmptyErrorDescription ].
	(aPrefix includesSubString: ' ') ifTrue: [self error: self class prefixCannotContainSpacesErrorDescription ].
	! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'js 4/21/2019 15:50:46'!
initializeWith: aStackOfSentences

	sentences := OrderedCollection new.
	[aStackOfSentences isEmpty ] whileFalse:
	[
		sentences addFirst: aStackOfSentences pop.
	].

	sentences do: [:anElement | aStackOfSentences push: anElement ].
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
