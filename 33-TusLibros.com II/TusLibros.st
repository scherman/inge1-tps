!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'J.S 6/9/2019 22:30:13'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSoldByTheStore key ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'J.S 6/9/2019 22:30:06'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSoldByTheStore key.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'J.S 6/9/2019 22:29:57'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSoldByTheStore key ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'JS 6/9/2019 23:28:13'!
test05CanNotAddMoreThanOneItemNotSoldByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSoldByTheStore key ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'J.S 6/9/2019 22:29:36'!
test06CartContainsItemWhenAdded

	| cart |
	
	cart := self createCart.
	
	cart add: (self itemSoldByTheStore key).
	
	self assert: (cart includes: (self itemSoldByTheStore key)).
	self assert: cart items size = 1.! !

!CartTest methodsFor: 'tests' stamp: 'J.S 6/9/2019 22:03:53'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: (self itemSoldByTheStore key))! !

!CartTest methodsFor: 'tests' stamp: 'J.S 6/9/2019 22:29:07'!
test08CartContainsQuantityOfAddedItem

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: (self itemSoldByTheStore key).
	
	self assert: (cart occurrencesOf: (self itemSoldByTheStore key)) = 2! !

!CartTest methodsFor: 'tests' stamp: 'J.S 6/9/2019 22:29:19'!
test09CartValueEqualsToValueOfItsItems

	| cart |
	
	cart := self createCart.
	
	cart add: 3 of: (self itemSoldByTheStore key).
	
	self assert: cart value = (3 * self itemSoldByTheStore value).! !

!CartTest methodsFor: 'tests' stamp: 'JS 6/9/2019 23:50:56'!
test10CannotHaveNonPositivePrices

	| pricelist |
	
	pricelist := Dictionary new.
	pricelist add: ('a book'->0).
	self should:
	 	[Cart acceptingItemsOf: pricelist] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: 
		[:anError | self assert: (anError messageText = Cart cannotHaveFreeBooksError).]! !


!CartTest methodsFor: 'support' stamp: 'J.S 6/9/2019 22:03:34'!
createCart
	
	^ Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'J.S 6/9/2019 22:30:22'!
defaultCatalog
	| pricelist |
	
	pricelist := Dictionary new.
	
	pricelist add: self itemSoldByTheStore.
	^pricelist! !

!CartTest methodsFor: 'support' stamp: 'J.S 6/9/2019 14:27:09'!
itemNotSoldByTheStore
	
	^('invalidBook' -> 5)! !

!CartTest methodsFor: 'support' stamp: 'J.S 6/9/2019 22:03:53'!
itemSoldByTheStore
	
	^ ('validBook' -> 7)! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'book priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'setUp/tearDown' stamp: 'J.S 6/9/2019 22:14:53'!
setUp

	book := 'el secreto de sus ojos'.
	priceList := OrderedCollection with: book.! !


!CashierTest methodsFor: 'testing' stamp: 'J.S 6/9/2019 22:40:40'!
test01CheckoutOfAnEmptyCartShouldRaiseException
	| objectsProvider cashier creditCard cart |
	
	objectsProvider := TestObjectSamples new.
	
	cart := objectsProvider emptyCart.
	creditCard := objectsProvider validCard.
	cashier := Cashier for: cart payingWith: creditCard paymentProcessor: SuccessfullPaymentSimulator new.
	
	self 
		should: [cashier checkout] 
		raise: Error - MessageNotUnderstood  
		withMessageText: Cart cannotCheckoutEmptyCartErrorMessage ! !

!CashierTest methodsFor: 'testing' stamp: 'J.S 6/9/2019 22:39:49'!
test02CheckoutOfACartWithExpiredCreditCardRaisesAnException
	| tusLibrosObjectsProvider cart cashier creditCard |
	
	tusLibrosObjectsProvider := TestObjectSamples new.
	
	cart := tusLibrosObjectsProvider cartWithOneElement.
	creditCard := tusLibrosObjectsProvider expiredCard.
	cashier := Cashier for: cart payingWith: creditCard paymentProcessor: SuccessfullPaymentSimulator new.
	
	self 
		should: [cashier checkout] 
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier invalidCreditCardException! !

!CashierTest methodsFor: 'testing' stamp: 'J.S 6/9/2019 22:40:40'!
test03CartShouldNotBeModifiedWhenPaymentFails
	| tusLibrosObjectsProvider initialItems cart cashier creditCard |
	
	tusLibrosObjectsProvider := TestObjectSamples new.
	
	cart := tusLibrosObjectsProvider cartWithOneElement.
	creditCard := tusLibrosObjectsProvider validCard.
	cashier := Cashier for: cart payingWith: creditCard paymentProcessor: FailedPaymentSimulator new.
	
	initialItems := cart items copy.
	self 
		should: [cashier checkout] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anErrorMessage |
			self assert: anErrorMessage messageText = FailedPaymentSimulator paymentFailedErrorMessage.
			self assert: (cart items = initialItems)]
		
		
	
		! !

!CashierTest methodsFor: 'testing' stamp: 'J.S 6/9/2019 22:40:40'!
test04MerchantProcessorDebitsValueOfCartWhenCheckouts
	| tusLibrosObjectsProvider cartValue merchantProcessorAdapterSimulator cart cashier creditCard |
	
	tusLibrosObjectsProvider := TestObjectSamples new.
	merchantProcessorAdapterSimulator := SuccessfullPaymentSimulator new.
	
	cart := tusLibrosObjectsProvider cartWithOneElement.
	creditCard := tusLibrosObjectsProvider validCard.
	cashier := Cashier for: cart payingWith: creditCard paymentProcessor: merchantProcessorAdapterSimulator.
	cartValue := cart value.
	
	cashier checkout.
	
	self assert: (merchantProcessorAdapterSimulator transactionsAmount size = 1).
	self assert: (merchantProcessorAdapterSimulator transactionsAmount last = cartValue).	
	
		! !


!classDefinition: #CreditCardTest category: #TusLibros!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'validCard invalidCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'J.S 6/9/2019 22:47:30'!
test01CannotCreateCreditCardWithInvalidNumber

	| samples |
	samples := TestObjectSamples new.

	self 
		should: [samples cardWithInvalidNumber]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidCreditCardNumberErrorMessage.! !

!CreditCardTest methodsFor: 'tests' stamp: 'J.S 6/9/2019 23:01:45'!
test02CanCreateCreditCardWithValidNumber

	| samples |
	samples := TestObjectSamples new.

	samples validCard.! !

!CreditCardTest methodsFor: 'tests' stamp: 'J.S 6/9/2019 23:01:54'!
test03CreditCardIsExpiredAfterExpirationDate

	| samples card |
	samples := TestObjectSamples new.
	card := samples expiredCard.
	
	self assert: (card isExpiredOn: Date today).! !

!CreditCardTest methodsFor: 'tests' stamp: 'J.S 6/9/2019 23:02:10'!
test04CreditCardIsNotExpiredBeforeExpirationDate

	| samples card |
	samples := TestObjectSamples new.
	card := samples validCard.
	
	self deny: (card isExpiredOn: Date today).! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'J.S 6/9/2019 14:35:16'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: Cart invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'J.S 6/8/2019 19:23:39'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: Cart invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'JS 6/9/2019 23:51:45'!
initializeAcceptingItemsOf: aCatalog
	self assertPositivePricesOf: aCatalog.
	catalog := aCatalog.
	state := CartEmpty of: self.! !


!Cart methodsFor: 'testing' stamp: 'J.S 6/8/2019 17:03:01'!
includes: anItem

	^state includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'J.S 6/8/2019 17:02:47'!
isEmpty
	
	^state isEmpty ! !


!Cart methodsFor: 'getters and setters' stamp: 'J.S 6/9/2019 19:46:18'!
items

	^ state items.! !

!Cart methodsFor: 'getters and setters' stamp: 'J.S 6/8/2019 17:05:41'!
state: aCartState 
	state _ aCartState! !


!Cart methodsFor: 'checkout' stamp: 'J.S 6/9/2019 22:03:00'!
prepareForCheckout

	^ state prepareForCheckout! !


!Cart methodsFor: 'accessing' stamp: 'J.S 6/8/2019 17:06:03'!
occurrencesOf: anItem

	^state occurrencesOf: anItem  ! !

!Cart methodsFor: 'accessing' stamp: 'J.S 6/9/2019 20:35:48'!
value

	^ self items sum: [:anItem | catalog at: anItem].! !


!Cart methodsFor: 'adding' stamp: 'J.S 6/9/2019 23:19:50'!
add: anItem

	self assertIsValidItem: anItem.
	
	^ state add: anItem.! !

!Cart methodsFor: 'adding' stamp: 'J.S 6/8/2019 17:10:05'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	1 to: aQuantity do: [ :aNumber | self add: anItem ]! !



!Cart methodsFor: 'queries' stamp: 'JS 6/9/2019 23:54:44'!
assertPositivePricesOf: aPricelist 
	
	aPricelist do: [:anItem | (anItem value > 0) ifFalse: [self error: (self class cannotHaveFreeBooksError)]].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'errors' stamp: 'J.S 6/9/2019 21:59:43'!
cannotCheckoutEmptyCartErrorMessage
	
	^ 'Cannot checkout empty cart!!'! !

!Cart class methodsFor: 'errors' stamp: 'JS 6/9/2019 23:55:10'!
cannotHaveFreeBooksError
	^'Cannot have free books'! !

!Cart class methodsFor: 'errors' stamp: 'J.S 6/9/2019 21:59:50'!
invalidItemErrorMessage
	
	^ 'Item is not in catalog'! !

!Cart class methodsFor: 'errors' stamp: 'J.S 6/9/2019 21:59:53'!
invalidQuantityErrorMessage
	
	^ 'Invalid number of items'! !


!classDefinition: #CartState category: #TusLibros!
Object subclass: #CartState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartState methodsFor: 'adding' stamp: 'J.S 6/9/2019 23:17:13'!
add: anItem

	^self subclassResponsibility ! !


!CartState methodsFor: 'checkout' stamp: 'J.S 6/9/2019 23:19:14'!
prepareForCheckout

	^self subclassResponsibility ! !


!CartState methodsFor: 'testing' stamp: 'J.S 6/9/2019 23:18:03'!
includes: anItem

	^self subclassResponsibility ! !

!CartState methodsFor: 'testing' stamp: 'J.S 6/9/2019 23:18:07'!
isEmpty

	^self subclassResponsibility ! !


!CartState methodsFor: 'getters and setters' stamp: 'J.S 6/9/2019 23:19:31'!
items

	self subclassResponsibility .! !


!CartState methodsFor: 'accessing' stamp: 'J.S 6/9/2019 23:17:44'!
occurrencesOf: anItem 

	^self subclassResponsibility ! !


!classDefinition: #CartEmpty category: #TusLibros!
CartState subclass: #CartEmpty
	instanceVariableNames: 'cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartEmpty methodsFor: 'checkout' stamp: 'J.S 6/9/2019 22:01:28'!
prepareForCheckout

	self error: Cart cannotCheckoutEmptyCartErrorMessage ! !


!CartEmpty methodsFor: 'accessing' stamp: 'J.S 6/8/2019 17:07:31'!
occurrencesOf: anItem
	^0! !


!CartEmpty methodsFor: 'getters and setters' stamp: 'J.S 6/9/2019 19:45:38'!
items

	^ OrderedCollection new.! !


!CartEmpty methodsFor: 'testing' stamp: 'J.S 6/8/2019 17:03:34'!
includes: anItem
	^false! !

!CartEmpty methodsFor: 'testing' stamp: 'J.S 6/8/2019 17:02:16'!
isEmpty
^true! !


!CartEmpty methodsFor: 'adding' stamp: 'J.S 6/9/2019 23:20:22'!
add: anItem

	cart state: (CartNotEmpty of: cart with: (OrderedCollection with: anItem)).
	
	! !


!CartEmpty methodsFor: 'initialization' stamp: 'J.S 6/9/2019 23:16:35'!
initializeOf: aCart

	cart := aCart.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartEmpty class' category: #TusLibros!
CartEmpty class
	instanceVariableNames: ''!

!CartEmpty class methodsFor: 'instance creation' stamp: 'J.S 6/9/2019 23:16:20'!
of: aCart

	^ self new initializeOf: aCart.! !


!classDefinition: #CartNotEmpty category: #TusLibros!
CartState subclass: #CartNotEmpty
	instanceVariableNames: 'items cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartNotEmpty methodsFor: 'testing' stamp: 'J.S 6/9/2019 23:11:08'!
includes: anItem

	^items includes: anItem! !

!CartNotEmpty methodsFor: 'testing' stamp: 'J.S 6/9/2019 23:11:13'!
isEmpty
	
	^false! !


!CartNotEmpty methodsFor: 'accessing' stamp: 'J.S 6/8/2019 17:07:04'!
occurrencesOf: anItem 
	^items occurrencesOf: anItem! !


!CartNotEmpty methodsFor: 'initialization' stamp: 'J.S 6/9/2019 23:10:47'!
initializeOf: aCart with: aListOfItems

	cart := aCart.
	items := aListOfItems.
	! !


!CartNotEmpty methodsFor: 'getters and setters' stamp: 'J.S 6/9/2019 19:45:48'!
items

	^ items.! !


!CartNotEmpty methodsFor: 'adding' stamp: 'J.S 6/9/2019 23:11:55'!
add: anItem

	items add: anItem.! !


!CartNotEmpty methodsFor: 'checkout' stamp: 'J.S 6/9/2019 22:01:28'!
prepareForCheckout
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartNotEmpty class' category: #TusLibros!
CartNotEmpty class
	instanceVariableNames: ''!

!CartNotEmpty class methodsFor: 'instance creation' stamp: 'J.S 6/9/2019 23:10:23'!
of: aCart with: aListOfItems
	
	^self new initializeOf: aCart with: aListOfItems! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart card merchantProcessorAdapter date'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'J.S 6/9/2019 22:36:37'!
initializeFor: aCart payingWith: aCreditCard paymentProcessor: aMerchantProcessorAdapter

	cart := aCart.
	card := aCreditCard.
	merchantProcessorAdapter := aMerchantProcessorAdapter.! !


!Cashier methodsFor: 'assertions' stamp: 'J.S 6/9/2019 17:34:35'!
assertCreditCardIsNotExpired

	(card isExpiredOn: Date today) ifTrue: [self error: self class invalidCreditCardException ]! !


!Cashier methodsFor: 'checkout' stamp: 'J.S 6/9/2019 22:36:59'!
checkout

	cart prepareForCheckout.
	self assertCreditCardIsNotExpired.
	merchantProcessorAdapter 
		debit: cart value 
		from: card number 
		expiringAt: card expirationDate 
		ownedBy: card owner.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'J.S 6/9/2019 22:36:32'!
for: aCart payingWith: aCreditCard  paymentProcessor: aMerchantProcessorAdapter
	^self new initializeFor: aCart payingWith: aCreditCard paymentProcessor: aMerchantProcessorAdapter! !


!Cashier class methodsFor: 'errors' stamp: 'J.S 6/8/2019 16:09:33'!
invalidCreditCardException
	^'could not process buy because the credit card is invalid'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'owner number expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'J.S 6/9/2019 17:14:02'!
initializeWith: aCreditCardNumber expiringOn: aMonthOfYear from: anOwner
	self assertHasSixteenDigits: aCreditCardNumber. 
	
	number := aCreditCardNumber.
	expirationDate := aMonthOfYear.
	owner := anOwner ! !


!CreditCard methodsFor: 'assertions' stamp: 'J.S 6/9/2019 22:47:30'!
assertHasSixteenDigits: aCreditCardNumber 
	((aCreditCardNumber numberOfDigitsInBase: 10) = 16) ifFalse: [
		self error: (self class invalidCreditCardNumberErrorMessage)
		]! !


!CreditCard methodsFor: 'testing' stamp: 'J.S 6/9/2019 22:58:56'!
isExpiredOn: aDate

	| dateAsMonthOfYear |
	dateAsMonthOfYear := (FixedGregorianDate fromDate: aDate) monthOfYear.
	
	^ expirationDate < dateAsMonthOfYear.
	! !


!CreditCard methodsFor: 'getters' stamp: 'J.S 6/9/2019 19:50:36'!
expirationDate
	
	^ expirationDate .! !

!CreditCard methodsFor: 'getters' stamp: 'J.S 6/9/2019 19:50:30'!
number
	
	^ number.! !

!CreditCard methodsFor: 'getters' stamp: 'J.S 6/9/2019 19:50:15'!
owner
	
	^ owner.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'J.S 6/9/2019 17:14:12'!
with: aCreditCardNumber expiringOn: aMonthOfYear from: anOwner 
	^(self new initializeWith: aCreditCardNumber expiringOn: aMonthOfYear from: anOwner).! !


!CreditCard class methodsFor: 'errors' stamp: 'J.S 6/9/2019 22:47:30'!
invalidCreditCardNumberErrorMessage
	^'invalid credit card number error'! !


!classDefinition: #MerchantProcessorAdapterSimulator category: #TusLibros!
Object subclass: #MerchantProcessorAdapterSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorAdapterSimulator methodsFor: 'payment processing' stamp: 'J.S 6/9/2019 19:24:55'!
debit: aTransactionAmount from: aCreditCardNumber expiringAt: aCreditCardExpirationDate ownedBy: aCreditCardOwner

	self subclassResponsibility.

	! !


!classDefinition: #FailedPaymentSimulator category: #TusLibros!
MerchantProcessorAdapterSimulator subclass: #FailedPaymentSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!FailedPaymentSimulator methodsFor: 'payment processing' stamp: 'J.S 6/9/2019 19:55:06'!
debit: aTransactionAmount from: aCreditCardNumber expiringAt: aCreditCardExpirationDate ownedBy: aCreditCardOwner

	self error: self class paymentFailedErrorMessage.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FailedPaymentSimulator class' category: #TusLibros!
FailedPaymentSimulator class
	instanceVariableNames: ''!

!FailedPaymentSimulator class methodsFor: 'errors' stamp: 'J.S 6/9/2019 19:32:41'!
paymentFailedErrorMessage

	^ 'Payment failed!!'! !


!classDefinition: #SuccessfullPaymentSimulator category: #TusLibros!
MerchantProcessorAdapterSimulator subclass: #SuccessfullPaymentSimulator
	instanceVariableNames: 'transactionsAmount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SuccessfullPaymentSimulator methodsFor: 'payment processing' stamp: 'J.S 6/9/2019 20:08:51'!
debit: aTransactionAmount from: aCreditCardNumber expiringAt: aCreditCardExpirationDate ownedBy: aCreditCardOwner

	transactionsAmount add: aTransactionAmount.

	! !


!SuccessfullPaymentSimulator methodsFor: 'initialization' stamp: 'J.S 6/9/2019 20:08:51'!
initialize

	transactionsAmount := OrderedCollection new.! !


!SuccessfullPaymentSimulator methodsFor: 'accessing' stamp: 'J.S 6/9/2019 20:23:28'!
transactionsAmount

	^ transactionsAmount.! !


!classDefinition: #TestObjectSamples category: #TusLibros!
Object subclass: #TestObjectSamples
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestObjectSamples methodsFor: 'cards' stamp: 'J.S 6/9/2019 23:02:46'!
cardWithInvalidNumber
	| aCreditCardNumber anOwner dateToday |
	
	aCreditCardNumber := 5.
	anOwner := 'Jessica Denise Singer'.
	dateToday := Date today.
	
	^ CreditCard with: aCreditCardNumber expiringOn: GregorianMonthOfYear current from: anOwner! !

!TestObjectSamples methodsFor: 'cards' stamp: 'J.S 6/9/2019 23:03:01'!
expiredCard
	| aNumber anOwner expirationDate |
	
	aNumber := 5555444433332222.
	anOwner := 'Jessica Denise Singer'.
	
	expirationDate :=  GregorianMonthOfYear current previous: (TimeUnits month with: 1).
	
	^ CreditCard with: aNumber expiringOn: expirationDate  from: anOwner
! !

!TestObjectSamples methodsFor: 'cards' stamp: 'J.S 6/9/2019 23:03:12'!
validCard
	| aCreditCardNumber anOwner |
	
	aCreditCardNumber := 5555444433332222.
	anOwner := 'Jessica Denise Singer'.
	
	^ CreditCard with: aCreditCardNumber expiringOn: GregorianMonthOfYear current from: anOwner! !


!TestObjectSamples methodsFor: 'cart' stamp: 'J.S 6/9/2019 23:03:40'!
cartWithOneElement
	| anItem aPricelist  aCart|
	
	anItem := 'el secreto de sus ojos'->5.
	aPricelist := Dictionary with: anItem.
	
	aCart :=  Cart acceptingItemsOf: aPricelist.
	aCart add: anItem key.
	
	^ aCart! !

!TestObjectSamples methodsFor: 'cart' stamp: 'J.S 6/9/2019 23:03:27'!
emptyCart
	| aBook aPricelist |
	
	aBook := 'el secreto de sus ojos'.
	aPricelist := Dictionary with: (aBook->5).
	
	^Cart acceptingItemsOf: aPricelist. ! !
