!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'cart clientId book catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'testing' stamp: 'J.S 5/31/2019 18:46:09'!
test01WhenAddingACartItShouldBeEmpty

	self assert: (cart isEmpty)
	! !

!CartTest methodsFor: 'testing' stamp: 'J.S 5/31/2019 18:46:25'!
test02WhenAddingABookToTheCartItShouldNoLongerBeEmpty

	cart add: book.
	self assert: (cart isEmpty not).
	! !

!CartTest methodsFor: 'testing' stamp: 'J.S 5/31/2019 18:48:47'!
test03WhenAddingABookTheBookShouldBeAddedToBooks

	cart add: book.
	
	self assert: (cart books = (OrderedCollection with: book)).! !

!CartTest methodsFor: 'testing' stamp: 'J.S 6/1/2019 22:03:45'!
test04ListingACartItReturnsItsHash
	
	self assert: (cart listCart = cart identityHash ).! !

!CartTest methodsFor: 'testing' stamp: 'J.S 6/1/2019 22:03:16'!
test05canOnlyBuyItemsInCatalog
	| aBookNotInTheCatalog |
	
	aBookNotInTheCatalog := 'pepe'.
	self should: [cart add: aBookNotInTheCatalog] raise: Error withMessageText: Cart CannotAddBooksNotInTheCatalog.! !

!CartTest methodsFor: 'testing' stamp: 'J.S 6/1/2019 23:15:53'!
test06AddingMultipleBooksAtOnceAddsThemAll
	
	cart add: 3 of: book.
	self assert: (cart books = (OrderedCollection with: book with: book with: book))
! !


!CartTest methodsFor: 'setUp/tearDown' stamp: 'J.S 6/1/2019 22:21:13'!
setUp
	catalog := OrderedCollection with: 'el secreto de sus ojos'.
	cart := Cart with: catalog.
	book := 'el secreto de sus ojos'.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'J.S 6/1/2019 22:14:19'!
initializeWith: aCatalog
	books := OrderedCollection new.
	catalog := aCatalog.! !


!Cart methodsFor: 'elements inspection' stamp: 'J.S 5/31/2019 18:47:39'!
books
	^books! !

!Cart methodsFor: 'elements inspection' stamp: 'J.S 5/31/2019 18:34:29'!
isEmpty
	^(books size = 0)! !


!Cart methodsFor: 'buying' stamp: 'J.S 6/1/2019 22:49:19'!
add: aBook
	(catalog includes: aBook) ifTrue: [
		^books add: aBook 
	].
	self error: (Cart CannotAddBooksNotInTheCatalog).
	! !

!Cart methodsFor: 'buying' stamp: 'J.S 6/1/2019 22:50:53'!
add: anAmount of: aBook
	(catalog includes: aBook) ifTrue: [
		^(anAmount timesRepeat: [books add: aBook])
	].
	self error: (Cart CannotAddBooksNotInTheCatalog).
	! !


!Cart methodsFor: 'as yet unclassified' stamp: 'J.S 5/31/2019 19:08:20'!
listCart
	^self hash! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'J.S 6/1/2019 22:19:46'!
with: aCatalog 
	^(self new initializeWith: aCatalog ).! !


!Cart class methodsFor: 'errors' stamp: 'J.S 6/1/2019 22:04:09'!
CannotAddBooksNotInTheCatalog
	^'coso'! !
