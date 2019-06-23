!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'J.S 6/23/2019 17:28:41'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'J.S 6/23/2019 17:28:33'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'J.S 6/23/2019 17:28:29'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #InternalInterfaceTest category: #TusLibros!
TestCase subclass: #InternalInterfaceTest
	instanceVariableNames: 'cartInterface invalidClient clients aPricelist validClient book clock time creditCardNumber creditCardExpiringDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalInterfaceTest methodsFor: 'testing' stamp: 'J.S 6/23/2019 16:47:08'!
test01CreatingCartWithInvalidClientRaisesException
	
	self should:
		[cartInterface registerCartFor: invalidClient key with: invalidClient value]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: (anError messageText = InternalInterface cannotCreateCartForInvalidClientErrorMessage).
			self assert: (cartInterface cartsSessions isEmpty)
		]! !

!InternalInterfaceTest methodsFor: 'testing' stamp: 'J.S 6/16/2019 11:04:18'!
test02ACartSessionWithAnEmptyCartIsCreatedForAValidClient
	
	| createdCart |
	createdCart := cartInterface registerCartFor: validClient key with: validClient value.
	self assert: (cartInterface cartsSessions includesKey: createdCart).
	self assert: ((cartInterface cartsSessions at: createdCart ) cart isEmpty)! !

!InternalInterfaceTest methodsFor: 'testing' stamp: 'J.S 6/23/2019 16:47:08'!
test03CreatingCartWithInvalidPasswordRaisesException
	
	self should:
		[cartInterface registerCartFor: validClient key with: invalidClient value]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: (anError messageText = InternalInterface cannotCreateCartForInvalidClientErrorMessage).
			self assert: (cartInterface cartsSessions isEmpty)
		]! !

!InternalInterfaceTest methodsFor: 'testing' stamp: 'J.S 6/16/2019 11:51:26'!
test04CreatedCartCanBeListedAndIsEmpty
	
	| createdCart |
	createdCart := cartInterface registerCartFor: validClient key with: validClient value.
	self assert: ((cartInterface listCart: createdCart) isEmpty).! !

!InternalInterfaceTest methodsFor: 'testing' stamp: 'J.S 6/19/2019 00:06:58'!
test05AddingItemToCartAddsTheItem
	
	| createdCart expectedItems |
	expectedItems := Dictionary new.
	expectedItems add: book->2.
	
	createdCart := cartInterface registerCartFor: validClient key with: validClient value.
	cartInterface add: 2 of: book to: createdCart.
	
	self assert: ((cartInterface listCart: createdCart) = expectedItems).! !

!InternalInterfaceTest methodsFor: 'testing' stamp: 'J.S 6/21/2019 23:55:00'!
test06SessionExpiresAfter30MinutesOfInactivity
	
	| createdCartId |
	createdCartId := cartInterface registerCartFor: validClient key with: validClient value.
	self moveForward: 31.
	
	self assert: (cartInterface isSessionWithId: createdCartId expiredOn: self now)! !

!InternalInterfaceTest methodsFor: 'testing' stamp: 'J.S 6/23/2019 16:47:08'!
test07CannotListCartIfSessionIsExpired
	
	| createdCartId |
	createdCartId := cartInterface registerCartFor: validClient key with: validClient value.
	self moveForward: 31.
	self should:
		[cartInterface listCart: createdCartId]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: (anError messageText = InternalInterface cartSessionExpiredErrorMessage).
		]! !

!InternalInterfaceTest methodsFor: 'testing' stamp: 'J.S 6/23/2019 16:47:08'!
test08CannotAddAnItemToCartIfSessionIsExpired
	
	| createdCartId |
	createdCartId := cartInterface registerCartFor: validClient key with: validClient value.
	self moveForward: 31.
	self should:
		[cartInterface add: 2 of: book to: createdCartId]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: (anError messageText = InternalInterface cartSessionExpiredErrorMessage).
		]! !

!InternalInterfaceTest methodsFor: 'testing' stamp: 'J.S 6/21/2019 23:55:44'!
test09AddingItemToCartRefreshesSessionExpirationDate
	
	| createdCartId |
	createdCartId := cartInterface registerCartFor: validClient key with: validClient value.
	self moveForward: 25.
	cartInterface add: 2 of: book to: createdCartId.
	self moveForward: 25.
	
	self deny: (cartInterface isSessionWithId: createdCartId expiredOn: self now).! !

!InternalInterfaceTest methodsFor: 'testing' stamp: 'J.S 6/21/2019 23:55:57'!
test10ListingCartRefreshesSessionExpirationDate
	
	| createdCartId |
	createdCartId := cartInterface registerCartFor: validClient key with: validClient value.
	self moveForward: 25.
	cartInterface listCart: createdCartId.
	self moveForward: 25.
	
	self deny: (cartInterface isSessionWithId: createdCartId expiredOn: self now).! !

!InternalInterfaceTest methodsFor: 'testing' stamp: 'J.S 6/21/2019 23:57:31'!
test11PurchaseIsListedAfterCheckout
	
	| createdCartId  |
	createdCartId := cartInterface registerCartFor: validClient key with: validClient value.
	cartInterface add: 2 of: book to: createdCartId.
	cartInterface checkoutCartWithId: createdCartId 
					withCreditCardNumber: creditCardNumber
					withCreditCardExpiringDate: creditCardExpiringDate
					withCreditCardOwner: validClient key.
	self assert: (cartInterface listPurchasesFrom: validClient key) size = 1
! !

!InternalInterfaceTest methodsFor: 'testing' stamp: 'J.S 6/22/2019 00:11:08'!
test12CartSessionIsRemovedAfterCheckout
	
	| createdCartId  |
	createdCartId := cartInterface registerCartFor: validClient key with: validClient value.
	cartInterface add: 2 of: book to: createdCartId.
	cartInterface checkoutCartWithId: createdCartId 
					withCreditCardNumber: creditCardNumber
					withCreditCardExpiringDate: creditCardExpiringDate
					withCreditCardOwner: validClient key.
					
	self deny: (cartInterface cartsSessions keys includes: createdCartId)
! !

!InternalInterfaceTest methodsFor: 'testing' stamp: 'J.S 6/23/2019 17:28:10'!
test13CannotAddItemsNotSoldByTheStore
	
	| createdCartId  |
	createdCartId := cartInterface registerCartFor: validClient key with: validClient value.

	self 
		should: [cartInterface add: 1 of: 'otrolibro' to: createdCartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
		self assert: (cartInterface listCart: createdCartId) isEmpty.
		self assert: (anError messageText = Cart invalidItemErrorMessage ) ].
		
! !

!InternalInterfaceTest methodsFor: 'testing' stamp: 'J.S 6/23/2019 17:27:18'!
test14CannotNonPositiveAmountOfItems
	
	| createdCartId  |
	createdCartId := cartInterface registerCartFor: validClient key with: validClient value.

	self 
		should: [cartInterface add: 0 of: book to: createdCartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
		self assert: (cartInterface listCart: createdCartId) isEmpty.
		self assert: (anError messageText = Cart invalidQuantityErrorMessage ) ].
		
! !

!InternalInterfaceTest methodsFor: 'testing' stamp: 'J.S 6/23/2019 17:09:05'!
test15CannotCheckoutWithExpiredCreditCard
	
	| createdCartId  expiredCreditCardDate today |
	createdCartId := cartInterface registerCartFor: validClient key with: validClient value.
	cartInterface add: 2 of: book to: createdCartId.
	today := DateAndTime now.
	expiredCreditCardDate := Month month: today monthIndex year: (today yearNumber - 1).
	
	self should: [cartInterface checkoutCartWithId: createdCartId 
					withCreditCardNumber: creditCardNumber
					withCreditCardExpiringDate: expiredCreditCardDate
					withCreditCardOwner: validClient key.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: (anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage )].
					
	self assert: (cartInterface cartsSessions keys includes: createdCartId)
! !


!InternalInterfaceTest methodsFor: 'setUp/tearDown' stamp: 'J.S 6/23/2019 16:47:08'!
setUp
	| today |
	today := DateAndTime now.
	book := 'bookisbn'.
	aPricelist := Dictionary new.
	aPricelist add: book->5.
	validClient := 'pepe'->'passwordpepe'.
	clients := Dictionary new.
	clients add: validClient.
	invalidClient := 'pedro'->'passwordpedro'.
	creditCardNumber := 5555555555555555.
	creditCardExpiringDate := Month month: today monthIndex year: (today yearNumber + 1).
	time := DateAndTime now.
	cartInterface := InternalInterface for: clients with: aPricelist with: self with: self.
	! !


!InternalInterfaceTest methodsFor: 'clock protocol' stamp: 'J.S 6/20/2019 16:03:24'!
moveForward: anAmountOfMinutes
	time := time + (Duration minutes: anAmountOfMinutes)! !

!InternalInterfaceTest methodsFor: 'clock protocol' stamp: 'J.S 6/20/2019 14:42:37'!
now
	^time! !


!InternalInterfaceTest methodsFor: 'merchant processor protocol' stamp: 'J.S 6/20/2019 19:04:57'!
debit: anAmount from: aCreditCard! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!Cart methodsFor: 'assertions' stamp: 'J.S 6/23/2019 17:28:59'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'J.S 6/23/2019 17:29:12'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'J.S 6/16/2019 11:36:40'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Dictionary new.! !


!Cart methodsFor: 'queries' stamp: 'J.S 6/16/2019 11:50:55'!
items
	^items! !

!Cart methodsFor: 'queries' stamp: 'J.S 6/16/2019 11:46:03'!
occurrencesOf: anItem

	^items at: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'J.S 6/16/2019 11:45:45'!
includes: anItem

	^items includesKey: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'J.S 6/16/2019 11:48:56'!
total

	^ items keys sum: [ :anItem | (catalog at: anItem) * (items at: anItem)]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'J.S 6/16/2019 11:38:31'!
add: aQuantity of: anItem

	| currentQuantity |
	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.
	currentQuantity := items at: anItem ifAbsent: [0].
	1 to: aQuantity do: [ :aNumber | items add: anItem->( currentQuantity + aQuantity) ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'errors' stamp: 'J.S 6/23/2019 17:26:26'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'errors' stamp: 'J.S 6/23/2019 17:26:36'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!classDefinition: #CartSession category: #TusLibros!
Object subclass: #CartSession
	instanceVariableNames: 'cart client lastOperationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'initialization' stamp: 'J.S 6/21/2019 23:57:54'!
initializeFor: aClient with: aPricelist at: aCreationDateTime 
	client := aClient.
	cart := Cart acceptingItemsOf: aPricelist.
	lastOperationDate := aCreationDateTime ! !


!CartSession methodsFor: 'getters and setters' stamp: 'J.S 6/16/2019 11:04:46'!
cart
	
	^cart! !

!CartSession methodsFor: 'getters and setters' stamp: 'J.S 6/21/2019 23:57:54'!
lastOperationDate: aDate

	lastOperationDate  := aDate.! !


!CartSession methodsFor: 'cart management' stamp: 'J.S 6/21/2019 23:57:54'!
isExpiredOn: aDateAndTime
	^(lastOperationDate < (aDateAndTime - (Duration minutes: 30)))! !

!CartSession methodsFor: 'cart management' stamp: 'J.S 6/16/2019 11:50:34'!
itemsList
	^cart items! !


!CartSession methodsFor: 'purchases' stamp: 'J.S 6/16/2019 19:28:31'!
add: anAmount of: aBook 
	cart add: anAmount of: aBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #TusLibros!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'instance creation' stamp: 'J.S 6/19/2019 00:18:37'!
initializeFor: aClient with: aPricelist at: aCreationDateTime 
	^(self new initializeFor: aClient with: aPricelist at:  aCreationDateTime).! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration owner number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'J.S 6/20/2019 19:38:53'!
initializeExpiringOn: aMonth with: aCardNumber from: anOwner
	
	expiration := aMonth .
	number := aCardNumber.
	owner := anOwner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'J.S 6/20/2019 19:39:13'!
expiringOn: aMonth with: aCardNumber from: anOwner
	
	^self new initializeExpiringOn: aMonth with: aCardNumber from: anOwner! !


!classDefinition: #InternalInterface category: #TusLibros!
Object subclass: #InternalInterface
	instanceVariableNames: 'clients pricelist cartsSessions clock merchantProcessor salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalInterface methodsFor: 'initialization' stamp: 'J.S 6/20/2019 21:44:02'!
initializeFor: aClientsList with: aPricelist  with: aClock with: aMerchantProcessor 
	clients := aClientsList.
	pricelist := aPricelist.
	clock := aClock.
	cartsSessions := Dictionary new.
	merchantProcessor := aMerchantProcessor .
	salesBook := Dictionary new.! !


!InternalInterface methodsFor: 'carts creation' stamp: 'J.S 6/19/2019 23:03:21'!
registerCartFor: aClient with: aPassword 
	| aCartSession |
	self assertValid: aClient with: aPassword.
	aCartSession := CartSession initializeFor: aClient with: pricelist at: clock now.
	cartsSessions add: (aCartSession identityHash) -> aCartSession.
	^ aCartSession identityHash ! !


!InternalInterface methodsFor: 'private - assertions' stamp: 'J.S 6/23/2019 16:47:08'!
assertValid: aClient with: aPassword
	((clients includesKey: aClient ) and: [(clients at: aClient)  = aPassword]) ifFalse:
		[ self error: InternalInterface cannotCreateCartForInvalidClientErrorMessage]! !


!InternalInterface methodsFor: 'private - carts management' stamp: 'J.S 6/21/2019 23:53:12'!
assertNotExpired: aCartSessionId

	(self isSessionWithId: aCartSessionId expiredOn: clock now)
	ifTrue: [
		cartsSessions removeKey: aCartSessionId.
		^self error: (self class cartSessionExpiredErrorMessage )
	] ! !

!InternalInterface methodsFor: 'private - carts management' stamp: 'J.S 6/16/2019 00:09:00'!
cartsSessions
	^ cartsSessions! !

!InternalInterface methodsFor: 'private - carts management' stamp: 'J.S 6/21/2019 23:49:12'!
refreshSessionWithId: aSessionId

	(cartsSessions at: aSessionId) lastOperationDate: clock now. ! !


!InternalInterface methodsFor: 'carts management' stamp: 'J.S 6/21/2019 23:49:54'!
add: anAmount of: aBook to: aCartId 
	| cart |
	self assertNotExpired: aCartId.
	self refreshSessionWithId: aCartId.
		
	cart := cartsSessions at: aCartId.
	cart add: anAmount of: aBook

	! !

!InternalInterface methodsFor: 'carts management' stamp: 'J.S 6/21/2019 23:50:05'!
listCart: aCartId 
	self assertNotExpired: aCartId.
	self refreshSessionWithId: aCartId.
	
	^(cartsSessions at: aCartId) itemsList.! !


!InternalInterface methodsFor: 'purchases' stamp: 'J.S 6/22/2019 00:19:42'!
checkoutCartWithId: aCartId withCreditCardNumber: creditCardNumber withCreditCardExpiringDate: anExpirationDate withCreditCardOwner: aClientName 
	| card cart cashier salesBookForClient |
	self assertNotExpired: aCartId.
	card := CreditCard expiringOn: anExpirationDate with:  creditCardNumber from: aClientName.
	cart := (cartsSessions at: aCartId) cart.
	salesBookForClient := self salesBookForClient: aClientName.
	
	
	cashier := Cashier toCheckout: cart charging: card throught:  merchantProcessor on: (clock now date) registeringOn: salesBookForClient.
	cashier checkOut.
	
	cartsSessions removeKey: aCartId.! !

!InternalInterface methodsFor: 'purchases' stamp: 'J.S 6/20/2019 23:16:50'!
listPurchasesFrom: aClient 
	^self salesBookForClient: aClient.! !


!InternalInterface methodsFor: 'private - getter' stamp: 'J.S 6/20/2019 23:09:14'!
salesBookForClient: aClientName 
	^salesBook at: aClientName ifAbsentPut: [
			OrderedCollection new
		]! !


!InternalInterface methodsFor: 'testing' stamp: 'J.S 6/21/2019 23:36:07'!
isSessionWithId: aSessionId expiredOn: aDate

	| aCartSession |
	aCartSession := cartsSessions at: aSessionId ifAbsent:[self error: self class inexistentCartError].
	^ aCartSession isExpiredOn: aDate! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternalInterface class' category: #TusLibros!
InternalInterface class
	instanceVariableNames: ''!

!InternalInterface class methodsFor: 'instance creation' stamp: 'J.S 6/20/2019 19:03:21'!
for: aClientsList with: aPricelist with: aClock with: aMerchantProcessor 
	^(self new initializeFor: aClientsList with: aPricelist with: aClock with: aMerchantProcessor)! !


!InternalInterface class methodsFor: 'errors' stamp: 'J.S 6/21/2019 23:53:45'!
cannotCreateCartForInvalidClientErrorMessage
	^'cannot create cart for invalid client'! !

!InternalInterface class methodsFor: 'errors' stamp: 'J.S 6/21/2019 23:53:12'!
cartSessionExpiredErrorMessage
	^'cart is expired after 30 minutes'! !

!InternalInterface class methodsFor: 'errors' stamp: 'J.S 6/20/2019 17:15:56'!
inexistentCartError
	^'cart id does not exist'! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'J.S 6/16/2019 19:34:10'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'J.S 6/20/2019 19:39:41'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1) with: 555 from: 'pepe'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'J.S 6/20/2019 19:39:50'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1) with: 555 from: 'pepe'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
