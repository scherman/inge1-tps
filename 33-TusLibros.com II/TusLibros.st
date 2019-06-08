!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'cart cashier book pricelist creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'setUp/tearDown' stamp: 'J.S 6/8/2019 18:10:52'!
setUp
	book := 'el secreto de sus ojos'.
	pricelist := OrderedCollection with: book.
	cart := Cart acceptingItemsOf: pricelist ! !


!CashierTest methodsFor: 'testing' stamp: 'J.S 6/8/2019 18:08:43'!
test01CheckoutOfAnEmptyCartShouldRaiseException
	
	cashier := Cashier for: cart with: creditCard.
	
	self should: [cashier checkout] raise: Error - MessageNotUnderstood  withMessageText: Cart cannotCheckoutEmptyCartException ! !

!CashierTest methodsFor: 'testing' stamp: 'J.S 6/8/2019 18:09:45'!
test02CheckoutOfACartWithExpiredCreditCardRaisesAnException
	
	cart add: book.
	cashier := Cashier for: cart with: creditCard.
	
	self should: [cashier checkout] raise: Error - MessageNotUnderstood  withMessageText: Cashier invalidCreditCardException! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'J.S 6/8/2019 17:00:50'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	state := EmptyCartState new.! !


!Cart methodsFor: 'queries' stamp: 'J.S 6/8/2019 17:06:03'!
occurrencesOf: anItem

	^state occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'J.S 6/8/2019 17:03:01'!
includes: anItem

	^state includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'J.S 6/8/2019 17:02:47'!
isEmpty
	
	^state isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'J.S 6/8/2019 17:10:01'!
add: anItem

	self assertIsValidItem: anItem.
	
	^state add: anItem to: self.! !

!Cart methodsFor: 'adding' stamp: 'J.S 6/8/2019 17:10:05'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	1 to: aQuantity do: [ :aNumber | self add: anItem ]! !


!Cart methodsFor: 'accessing' stamp: 'J.S 6/8/2019 17:05:41'!
state: aCartState 
	state _ aCartState! !


!Cart methodsFor: 'as yet unclassified' stamp: 'J.S 6/8/2019 17:45:46'!
performCheckout
	^state performCheckout! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'as yet unclassified' stamp: 'J.S 6/8/2019 18:07:29'!
cannotCheckoutEmptyCartException
	^'cannot etc'! !


!classDefinition: #CartState category: #TusLibros!
Object subclass: #CartState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartState methodsFor: 'as yet unclassified' stamp: 'J.S 6/8/2019 16:59:35'!
add: anItem to: aCart
	^self subclassResponsibility ! !

!CartState methodsFor: 'as yet unclassified' stamp: 'J.S 6/8/2019 17:03:43'!
includes: anItem
	^self subclassResponsibility ! !

!CartState methodsFor: 'as yet unclassified' stamp: 'J.S 6/8/2019 17:02:30'!
isEmpty
	^self subclassResponsibility ! !

!CartState methodsFor: 'as yet unclassified' stamp: 'J.S 6/8/2019 17:46:01'!
performCheckout
	^self subclassResponsibility ! !


!CartState methodsFor: 'accessing' stamp: 'J.S 6/8/2019 17:07:13'!
occurrencesOf: anItem 
	^self subclassResponsibility ! !


!classDefinition: #EmptyCartState category: #TusLibros!
CartState subclass: #EmptyCartState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!EmptyCartState methodsFor: 'as yet unclassified' stamp: 'J.S 6/8/2019 16:59:12'!
add: anItem to: aCart
	aCart state: (NotEmptyCartState with: (OrderedCollection with: anItem)).
	
	! !

!EmptyCartState methodsFor: 'as yet unclassified' stamp: 'J.S 6/8/2019 17:03:34'!
includes: anItem
	^false! !

!EmptyCartState methodsFor: 'as yet unclassified' stamp: 'J.S 6/8/2019 17:02:16'!
isEmpty
^true! !

!EmptyCartState methodsFor: 'as yet unclassified' stamp: 'J.S 6/8/2019 17:07:31'!
occurrencesOf: anItem
	^0! !

!EmptyCartState methodsFor: 'as yet unclassified' stamp: 'J.S 6/8/2019 18:07:01'!
performCheckout
	self error: Cart cannotCheckoutEmptyCartException ! !


!classDefinition: #NotEmptyCartState category: #TusLibros!
CartState subclass: #NotEmptyCartState
	instanceVariableNames: 'items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!NotEmptyCartState methodsFor: 'as yet unclassified' stamp: 'J.S 6/8/2019 17:00:27'!
add: anItem to: aCart
	items add: anItem.! !

!NotEmptyCartState methodsFor: 'as yet unclassified' stamp: 'J.S 6/8/2019 17:03:25'!
includes: anItem
	^items includes: anItem! !

!NotEmptyCartState methodsFor: 'as yet unclassified' stamp: 'J.S 6/8/2019 17:04:59'!
initializeWith: aListOfItems
	items := aListOfItems ! !

!NotEmptyCartState methodsFor: 'as yet unclassified' stamp: 'J.S 6/8/2019 17:02:22'!
isEmpty
^false! !

!NotEmptyCartState methodsFor: 'as yet unclassified' stamp: 'J.S 6/8/2019 18:07:09'!
performCheckout
! !


!NotEmptyCartState methodsFor: 'accessing' stamp: 'J.S 6/8/2019 17:07:04'!
occurrencesOf: anItem 
	^items occurrencesOf: anItem! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotEmptyCartState class' category: #TusLibros!
NotEmptyCartState class
	instanceVariableNames: ''!

!NotEmptyCartState class methodsFor: 'as yet unclassified' stamp: 'J.S 6/8/2019 17:04:43'!
with: aListOfItems
	^(self new initializeWith: aListOfItems)! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart card'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'J.S 6/8/2019 15:50:17'!
initializeFor: aCart with: aCreditCard 
	cart := aCart.
	card := aCreditCard! !


!Cashier methodsFor: 'cashing' stamp: 'J.S 6/8/2019 18:09:16'!
checkout
	cart performCheckout.
	^self error: self class invalidCreditCardException ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'J.S 6/8/2019 15:41:51'!
for: aCart with: aCreditCard 
	^self new initializeFor: aCart with: aCreditCard.! !


!Cashier class methodsFor: 'Errors' stamp: 'J.S 6/8/2019 16:09:33'!
invalidCreditCardException
	^'could not process buy because the credit card is invalid'! !
