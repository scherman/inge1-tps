!classDefinition: #TusLibrosWindow category: #'TusLibros-Web'!
Panel subclass: #TusLibrosWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosWindow methodsFor: 'initialization' stamp: 'J.S 7/8/2019 15:36:34'!
defaultExtent

	^ 630@435
	! !

!TusLibrosWindow methodsFor: 'initialization' stamp: 'J.S 7/8/2019 15:42:45'!
initializeWith: aTitle and: aModel

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: aModel.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
	! !


!classDefinition: #TusLibrosCheckoutWindow category: #'TusLibros-Web'!
TusLibrosWindow subclass: #TusLibrosCheckoutWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosCheckoutWindow methodsFor: 'GUI building' stamp: 'J.S 7/8/2019 18:53:25'!
build1stRow
		
	| firstRowLayout cartList |
	cartList  := PluggableListMorph model: self model listGetter: #cartItems indexGetter: #cartItemsIndex indexSetter: #cartItemsIndex:.
	cartList  borderColor: Color skyBlue.
	cartList  borderWidth: 1.

	firstRowLayout := LayoutMorph newRow.
	firstRowLayout separation: 5;
	padding: #center;
	addMorph: cartList;
	addMorph: (StringMorph contents:'Total:');
	addMorph: (StringMorph contents: self model totalToPay asString).

		
	^ firstRowLayout 
! !

!TusLibrosCheckoutWindow methodsFor: 'GUI building' stamp: 'J.S 7/8/2019 18:54:30'!
build2ndRow
		
	| secondRowLayout creditCardOwnerBox |

	creditCardOwnerBox  := TextModelMorph textProvider: self model textGetter: #creditCardOwner textSetter: #creditCardOwner:. 
	creditCardOwnerBox textMorph setProperty: #keyStroke: toValue: [ :key | creditCardOwnerBox textMorph acceptContents ] .
	creditCardOwnerBox  borderWidth: 1; borderColor: Color skyBlue.
	creditCardOwnerBox morphWidth: 300;
	morphHeight:30.
	
	secondRowLayout := LayoutMorph newRow.
	secondRowLayout separation: 25;
	padding: #left;
	addMorph: (StringMorph contents:'Credit card owner:');
	addMorph: creditCardOwnerBox.
	
	^ secondRowLayout.
	! !

!TusLibrosCheckoutWindow methodsFor: 'GUI building' stamp: 'J.S 7/8/2019 18:54:35'!
build3rdRow
		
	| thirdRowLayout creditCardNumberBox |

	creditCardNumberBox  := TextModelMorph textProvider: self model textGetter: #creditCardNumber textSetter: #creditCardNumber:. 
	creditCardNumberBox textMorph setProperty: #keyStroke: toValue: [ :key | creditCardNumberBox textMorph acceptContents ] .
	creditCardNumberBox  borderWidth: 1; borderColor: Color skyBlue.
	creditCardNumberBox morphWidth: 300;
	morphHeight:30.
	
	thirdRowLayout := LayoutMorph newRow.
	thirdRowLayout separation: 25;
	padding: #left;
	addMorph: (StringMorph contents:'Credit card number:');
	addMorph: creditCardNumberBox .
	
	^ thirdRowLayout.
	! !

!TusLibrosCheckoutWindow methodsFor: 'GUI building' stamp: 'J.S 7/8/2019 18:54:41'!
build4rdRow
		
	| fourthRowLayout expirationDateBox |

	expirationDateBox  := TextModelMorph textProvider: self model textGetter: #expirationDate textSetter: #expirationDate:. 
	expirationDateBox textMorph setProperty: #keyStroke: toValue: [ :key | expirationDateBox textMorph acceptContents ] .
	expirationDateBox  borderWidth: 1; borderColor: Color skyBlue.
	expirationDateBox morphWidth: 300;
	morphHeight:30.
	
	fourthRowLayout := LayoutMorph newRow.
	fourthRowLayout separation: 25;
	padding: #left;
	addMorph: (StringMorph contents:'Expiration month of year:');
	addMorph: expirationDateBox .
	
	^ fourthRowLayout.
	! !

!TusLibrosCheckoutWindow methodsFor: 'GUI building' stamp: 'J.S 7/8/2019 18:54:20'!
build5thRow
		
	| fifthRowLayout processPaymentButton |
	
	processPaymentButton := PluggableButtonMorph model: self model stateGetter: nil  action: #sendCheckoutRequest  label: 'Process payment'.
	
	fifthRowLayout := LayoutMorph newRow.
	fifthRowLayout separation: 25;
	padding: #center;
	addMorph: processPaymentButton.
	
	^ fifthRowLayout.
	! !

!TusLibrosCheckoutWindow methodsFor: 'GUI building' stamp: 'J.S 7/8/2019 16:32:29'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 15;
	padding: #left;
	addMorph: self build1stRow;
	addMorph: self build2ndRow;
	addMorph: self build3rdRow;
	addMorph: self build4rdRow;
	addMorph: self build5thRow.! !


!TusLibrosCheckoutWindow methodsFor: 'initialization' stamp: 'J.S 7/8/2019 15:57:17'!
initializeWith: aTitle and: someCookies
		
	super initializeWith: aTitle and: (TusLibrosCheckoutWindowModel with: someCookies ).	
		
	"self model when: #cartItemsUpdated send: #refreshCartItemsList to: self."! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosCheckoutWindow class' category: #'TusLibros-Web'!
TusLibrosCheckoutWindow class
	instanceVariableNames: ''!

!TusLibrosCheckoutWindow class methodsFor: 'instance creation' stamp: 'J.S 7/8/2019 16:00:38'!
openWith: someCookies

	^self new initializeWith: 'TusLibros-Service Checkout Window' and: someCookies .! !


!classDefinition: #TusLibrosClientWindow category: #'TusLibros-Web'!
TusLibrosWindow subclass: #TusLibrosClientWindow
	instanceVariableNames: 'cartList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosClientWindow methodsFor: 'initialization' stamp: 'J.S 7/8/2019 15:44:41'!
initializeWith: aTitle and: someCookies

	super initializeWith: aTitle and: (TusLibrosClientWindowModel with: someCookies ).
		
	self model when: #cartItemsUpdated send: #refreshCartItemsList to: self.! !


!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'J.S 6/28/2019 01:38:30'!
build1stRow
		
	| firstRowLayout |
	firstRowLayout := LayoutMorph newRow.
	firstRowLayout separation: 25;
	padding: #left;
	addMorph: self build1stRow1ndColumn;
	addMorph: self build1stRow2ndColumn.
	
	^ firstRowLayout.
	! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'J.S 7/8/2019 18:51:31'!
build1stRow1ndColumn
		
	| firstRowFirstColumnLayout addButton catalogList quantityBox |
	catalogList  := PluggableListMorph model: self model listGetter: #catalog indexGetter: #catalogIndex indexSetter: #catalogIndex:.
	catalogList  borderColor: Color skyBlue.
	catalogList  borderWidth: 1.
	
	addButton := PluggableButtonMorph model: self model stateGetter: nil  action: #sendAddItemRequest  label: 'Add Book'.

	quantityBox  := TextModelMorph textProvider: self model textGetter: #itemQuantity textSetter: #itemQuantity:. 
	quantityBox textMorph setProperty: #keyStroke: toValue: [ :key | quantityBox textMorph acceptContents ] .
	quantityBox  borderWidth: 1; borderColor: Color skyBlue.
	quantityBox morphWidth: 70;
	morphHeight:30.
	
	firstRowFirstColumnLayout := LayoutMorph newColumn.
	firstRowFirstColumnLayout separation: 5;
	padding: #left;
	addMorph: (StringMorph contents:'Catalog:');
	addMorph: catalogList;
	addMorph: (StringMorph contents:'Quantity:');
	addMorph: quantityBox;
	addMorph: addButton .
	
	^ firstRowFirstColumnLayout 
! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'J.S 7/8/2019 18:58:36'!
build1stRow2ndColumn
		
	| firstRowSecondColumnLayout checkoutButton |
	cartList  := PluggableListMorph model: self model listGetter: #cartItems indexGetter: #cartItemsIndex indexSetter: #cartItemsIndex:.
	cartList  borderColor: Color skyBlue.
	cartList  borderWidth: 1.
	
	checkoutButton := PluggableButtonMorph model: self model stateGetter: nil  action: #openCheckoutWindow  label: 'Checkout'.
	
	firstRowSecondColumnLayout := LayoutMorph newColumn.
	firstRowSecondColumnLayout separation: 5;
	padding: #left;
	addMorph: (StringMorph contents:'Cart');
	addMorph: cartList;
	addMorph: checkoutButton.
	
	^ firstRowSecondColumnLayout 
! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'J.S 6/28/2019 01:34:53'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 15;
	padding: #left;
	addMorph: self build1stRow.! !


!TusLibrosClientWindow methodsFor: 'access' stamp: 'J.S 7/8/2019 18:51:40'!
refreshCartItemsList

	cartList updateList.
	cartList setSelectionIndex: 0.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindow class' category: #'TusLibros-Web'!
TusLibrosClientWindow class
	instanceVariableNames: ''!

!TusLibrosClientWindow class methodsFor: 'instance creation' stamp: 'J.S 7/8/2019 15:14:48'!
openWith: someCookies
	
	^self new initializeWith: 'TusLibros-Service Client Window' and: someCookies .! !


!classDefinition: #TusLibrosLoginWindow category: #'TusLibros-Web'!
TusLibrosWindow subclass: #TusLibrosLoginWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosLoginWindow methodsFor: 'initialization' stamp: 'J.S 7/8/2019 18:39:24'!
initializeWith: aTitle

	super initializeWith: aTitle and: TusLibrosLoginWindowModel new.
			
	"self model when: #loginSucceeded send: #openClientWindow to: self."! !


!TusLibrosLoginWindow methodsFor: 'GUI building' stamp: 'J.S 7/8/2019 18:52:44'!
build1stRow
		
	| firstRowLayout userBox |

	userBox  := TextModelMorph textProvider: self model textGetter: #user textSetter: #user:. 
	userBox textMorph setProperty: #keyStroke: toValue: [ :key | userBox textMorph acceptContents ] .
	userBox  borderWidth: 1; borderColor: Color skyBlue.
	userBox morphWidth: 300;
	morphHeight:30.
	
	firstRowLayout := LayoutMorph newRow.
	firstRowLayout separation: 25;
	padding: #left;
	addMorph: (StringMorph contents:'User');
	addMorph: userBox.
	
	^ firstRowLayout.
	! !

!TusLibrosLoginWindow methodsFor: 'GUI building' stamp: 'J.S 7/8/2019 18:52:52'!
build2stRow
		
	| secondRowLayout passwordBox |
	
	passwordBox  := TextModelMorph textProvider: self model textGetter: #password textSetter: #password:. 
	passwordBox textMorph setProperty: #keyStroke: toValue: [ :key | passwordBox textMorph acceptContents ] .
	passwordBox borderWidth: 1; borderColor: Color skyBlue.
	passwordBox morphWidth: 300;
	morphHeight:30.
	
	secondRowLayout := LayoutMorph newRow.
	secondRowLayout separation: 25;
	padding: #left;
	addMorph: (StringMorph contents:'Password:');
	addMorph: passwordBox.
	
	^ secondRowLayout.
	! !

!TusLibrosLoginWindow methodsFor: 'GUI building' stamp: 'J.S 7/8/2019 18:46:00'!
build3stRow
		
	| thirdRowLayout loginButton |
	
	loginButton := PluggableButtonMorph model: self model stateGetter: nil  action: #sendLoginRequest  label: 'Login'.
	
	thirdRowLayout := LayoutMorph newRow.
	thirdRowLayout separation: 25;
	padding: #left;
	addMorph: loginButton.
	
	^ thirdRowLayout.
	! !

!TusLibrosLoginWindow methodsFor: 'GUI building' stamp: 'J.S 7/8/2019 18:46:34'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 15;
	padding: #left;
	addMorph: self build1stRow;
	addMorph: self build2stRow;
	addMorph: self build3stRow.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosLoginWindow class' category: #'TusLibros-Web'!
TusLibrosLoginWindow class
	instanceVariableNames: ''!

!TusLibrosLoginWindow class methodsFor: 'instance creation' stamp: 'J.S 6/28/2019 23:19:59'!
open
	
	^self new initializeWith: 'Substrings-Service Client Window'.! !


!classDefinition: #TusLibrosServerControllerTests category: #'TusLibros-Web'!
TestCase subclass: #TusLibrosServerControllerTests
	instanceVariableNames: 'serverController priceList validBook validUser validPassword url systemFacade webClient validBookPrice'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosServerControllerTests methodsFor: 'tests' stamp: 'J.S 7/10/2019 23:26:21'!
test01RegistersCorrectCartSessionWhenLogin

	| cartId |
	cartId := webClient login: validUser with: validPassword.
	
	self assert: (systemFacade cartSessions size = 1).
	self assert: (systemFacade cartSessions at: cartId asNumber) owner = validUser.
		! !

!TusLibrosServerControllerTests methodsFor: 'tests' stamp: 'J.S 7/10/2019 23:27:52'!
test02CartSessionsAreNotModifiedWhenLoginWithInvalidCredentials
		
	| initialSessionsQuantity |
	initialSessionsQuantity := systemFacade cartSessions size.

	self 
		should: [webClient login: 'invalidCredential' with: validPassword.]
		raise: Error
		withExceptionDo: [:anErrorMessage | 
			self assert: anErrorMessage messageText = systemFacade invalidUserAndOrPasswordErrorDescription .
			self assert: systemFacade cartSessions size = initialSessionsQuantity]
! !

!TusLibrosServerControllerTests methodsFor: 'tests' stamp: 'J.S 7/10/2019 22:18:03'!
test03ServerRetrievesCorrectPriceList

	self assert: webClient getPriceList = priceList.
! !

!TusLibrosServerControllerTests methodsFor: 'tests' stamp: 'J.S 7/10/2019 23:34:10'!
test04AddsCorrectItemAndQuantityToCartSession

	| cartId actualCartContent initialCartContent |
	cartId := webClient login: validUser with: validPassword.
	
	initialCartContent := (systemFacade cartSessions at: cartId asNumber) cartContent contents.
	
	webClient add: 2 of: validBook toCartIdentifiedAs: cartId.
	actualCartContent := (systemFacade cartSessions at: cartId asNumber) cartContent contents.
	
	initialCartContent add: validBook->2.
	self assert: initialCartContent = actualCartContent.! !

!TusLibrosServerControllerTests methodsFor: 'tests' stamp: 'J.S 7/10/2019 23:34:27'!
test05DoesntAddAnythingWhenAddingItemToCartSessionFails

	| cartId initialCartContent actualCartContent |
	cartId := webClient login: validUser with: validPassword.
	
	initialCartContent := (systemFacade cartSessions at: cartId asNumber) cartContent.
	
	self 
		should:  [webClient add: 2 of: 'invalidBook' toCartIdentifiedAs: cartId.]
		raise:  Error
		withExceptionDo: [:anErrorMessage |
				self assert: anErrorMessage messageText = systemFacade invalidItemErrorMessage.
				
				actualCartContent := (systemFacade cartSessions at: cartId asNumber) cartContent.
				self assert: initialCartContent = actualCartContent.
			]
! !

!TusLibrosServerControllerTests methodsFor: 'tests' stamp: 'J.S 7/10/2019 23:34:52'!
test06ListCartRetrievesCartItemsOfSession

	| cartId cartContent obtainedCartContent |
	cartId := webClient login: validUser with: validPassword.
	
	cartContent := (systemFacade cartSessions at: cartId asNumber) cartContent contents.
	obtainedCartContent := webClient listCartIdentifiedAs: cartId.
	
	self assert: obtainedCartContent = cartContent.
! !

!TusLibrosServerControllerTests methodsFor: 'tests' stamp: 'J.S 7/10/2019 22:43:10'!
test07ListPurchasesRetrievesPurchasesOfUser

	| cartId purchases obtainedPurchases |
	cartId := webClient login: validUser with: validPassword.
	
	purchases := systemFacade listPurchasesOf: validUser authenticatingWith: validPassword.
	obtainedPurchases := webClient listPurchasesOf: validUser authenticatingWith: validPassword .
	
	self assert: obtainedPurchases = purchases.
! !

!TusLibrosServerControllerTests methodsFor: 'tests' stamp: 'J.S 7/10/2019 23:37:11'!
test08EffectivesDebitWhenCheckingOut

	| cartId initialSalesBookSize |
	cartId := webClient login: validUser with: validPassword.
	webClient add: 1 of: validBook toCartIdentifiedAs: cartId .
	
	initialSalesBookSize := systemFacade salesBook size.
	webClient checkOutCartIdentifiedAs: cartId withCreditCardNumbered: '1235664623' ownedBy: 'pepe' expiringOn: '10/24'.
	
	self assert: (initialSalesBookSize + 1) = systemFacade salesBook size.
	self assert: systemFacade salesBook last total = validBookPrice .! !

!TusLibrosServerControllerTests methodsFor: 'tests' stamp: 'J.S 7/10/2019 23:38:30'!
test09DoesntEffectivesDebitWhenCheckOutFails

	| cartId initialSalesBookSize |
	cartId := webClient login: validUser with: validPassword.
	
	initialSalesBookSize := systemFacade salesBook size.
	
	self 
		should:  [webClient checkOutCartIdentifiedAs: cartId withCreditCardNumbered: '1235664623' ownedBy: 'pepe' expiringOn: '10/24'.]
		raise:  Error
		withExceptionDo: [:anErrorMessage | 
			self assert: anErrorMessage messageText  = systemFacade cartCanNotBeEmptyErrorMessage . 
			self assert: systemFacade salesBook size = initialSalesBookSize]
	
	

! !


!TusLibrosServerControllerTests methodsFor: 'setup' stamp: 'J.S 7/10/2019 23:47:25'!
killActiveServers

	WebServer allInstancesDo: [:webServer | 
		webServer ifNotNil:[webServer destroy].
		webServer stopListener.
	].! !

!TusLibrosServerControllerTests methodsFor: 'setup' stamp: 'J.S 7/10/2019 23:50:52'!
setUp

	| clients |
	url := 'http://localhost:8080'.
	
	validBook := 'bookisbn1'.
	validBookPrice := 2.
	priceList := Dictionary new.
	priceList add: validBook->validBookPrice.
	
	validUser := 'pepe'.
	validPassword := 'passwordpepe'.
	clients := Dictionary new.
	clients add: validUser -> validPassword.
	
	systemFacade := TusLibrosSystemFacade
		authenticatingWith: clients
		acceptingItemsOf: priceList
		registeringOn: OrderedCollection new
		debitingThrought: self
		measuringTimeWith: DateAndTime.
		
	self killActiveServers.
	
	serverController := TusLibrosServerController with: systemFacade.
	webClient := TusLibrosWebClient new.! !

!TusLibrosServerControllerTests methodsFor: 'setup' stamp: 'J.S 7/9/2019 23:00:59'!
tearDown

	serverController stopListening. 
	serverController destroy.! !


!TusLibrosServerControllerTests methodsFor: 'merchant processor protocol' stamp: 'J.S 7/10/2019 23:05:00'!
debit: anAmount from: aCreditCard
! !


!classDefinition: #TusLibrosWebClientTests category: #'TusLibros-Web'!
TestCase subclass: #TusLibrosWebClientTests
	instanceVariableNames: 'errorMessage cartId user password creditCardNumber creditCardOwner expirationMonthOfYear'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosWebClientTests methodsFor: 'tests' stamp: 'J.S 7/9/2019 03:48:49'!
test01ReturnsCartIdWhenRegisteringCart

	| client webClient receivedCartId |
	
	webClient := WebClientSimulator withRequestDo: [self buildResponseWith: 200 content:  cartId].
	client := TusLibrosWebClient with: webClient .

	receivedCartId := client login: user with: password.
	self assert: receivedCartId = cartId.! !

!TusLibrosWebClientTests methodsFor: 'tests' stamp: 'J.S 7/9/2019 03:48:28'!
test02ThrowsCorrectErrorWhenRegisteringCartFails

	| client webClient |
	
	webClient := WebClientSimulator withRequestDo: [self buildResponseWith: 400 content:  errorMessage].
	client := TusLibrosWebClient with: webClient .
	
	self 
		should: [client login: user with: password.] 
		raise:  Error
		withExceptionDo: [:anErrorMessage | anErrorMessage messageText = errorMessage ]! !

!TusLibrosWebClientTests methodsFor: 'tests' stamp: 'J.S 7/9/2019 03:33:05'!
test03RetrievesPriceList

	| client webClient receivedPriceList priceList priceListAsJson |
	
	priceList := Dictionary with: 'bookisbn1'->32 with: 'bookisbn2'->15. 
	priceListAsJson := String streamContents:[:s| WebUtils jsonMap: priceList on: s]. "'{bookisbn1: 32,bookisbn2: 15}'."
	webClient := WebClientSimulator withRequestDo: [self buildResponseWith: 200 content: priceListAsJson].
	client := TusLibrosWebClient with: webClient .

	receivedPriceList := client getPriceList.
	self assert: receivedPriceList = priceList.! !

!TusLibrosWebClientTests methodsFor: 'tests' stamp: 'J.S 7/9/2019 03:49:12'!
test04ReturnsCartItemsWhenListingCart

	| client webClient receivedCartItems cartItems cartItemsAsJson |
	
	cartItems := Dictionary with: 'bookisbn1'->32 with: 'bookisbn2'->15. 
	cartItemsAsJson := String streamContents:[:s| WebUtils jsonMap: cartItems on: s]. "'{bookisbn1: 32,bookisbn2: 15}'."
	webClient := WebClientSimulator withRequestDo: [self buildResponseWith: 200 content:  cartItemsAsJson ].
	client := TusLibrosWebClient with: webClient .

	receivedCartItems := client listCartIdentifiedAs: cartId.
	self assert: receivedCartItems = cartItems .! !

!TusLibrosWebClientTests methodsFor: 'tests' stamp: 'J.S 7/9/2019 03:54:26'!
test05ThrowsCorrectErrorWhenListingCartFails

	| client webClient receivedCartId |
	
	webClient := WebClientSimulator withRequestDo: [self buildResponseWith: 400 content:  errorMessage].
	client := TusLibrosWebClient with: webClient .
	
	self 
		should: [client listCartIdentifiedAs: cartId .] 
		raise:  Error
		withExceptionDo: [:anErrorMessage | anErrorMessage messageText = errorMessage ]! !

!TusLibrosWebClientTests methodsFor: 'tests' stamp: 'J.S 7/9/2019 03:44:38'!
test06AddsItemToCart

	| client webClient receivedCartItems |
	
	webClient := WebClientSimulator withRequestDo: [self buildResponseWith: 200 content:  'OK' ].
	client := TusLibrosWebClient with: webClient .

	receivedCartItems := client add: 2  of: 'bookisbn1' toCartIdentifiedAs: cartId.
	self assert: receivedCartItems = 'OK' .! !

!TusLibrosWebClientTests methodsFor: 'tests' stamp: 'J.S 7/9/2019 03:46:37'!
test07ThrowsCorrectErrorWhenAddingItemToCartFails

	| client webClient receivedCartItems |
	
	webClient := WebClientSimulator withRequestDo: [self buildResponseWith: 400 content:  errorMessage ].
	client := TusLibrosWebClient with: webClient .

	self 
		should: [client add: 2  of: 'bookisbn1' toCartIdentifiedAs: cartId.] 
		raise:  Error
		withExceptionDo: [:anErrorMessage | anErrorMessage messageText = errorMessage ]! !

!TusLibrosWebClientTests methodsFor: 'tests' stamp: 'J.S 7/9/2019 03:52:50'!
test08CheckoutsCart

	| client webClient checkoutResponse |
	
	webClient := WebClientSimulator withRequestDo: [self buildResponseWith: 200 content:  'OK' ].
	client := TusLibrosWebClient with: webClient .

	checkoutResponse := client checkOutCartIdentifiedAs: cartId withCreditCardNumbered: creditCardNumber ownedBy: creditCardOwner expiringOn: expirationMonthOfYear.
		
	self assert: checkoutResponse = 'OK' .! !

!TusLibrosWebClientTests methodsFor: 'tests' stamp: 'J.S 7/9/2019 03:54:16'!
test09ThrowsCorrectErrorWhenCheckoutOfCartFails

	| client webClient |
	
	webClient := WebClientSimulator withRequestDo: [self buildResponseWith: 400 content:  errorMessage ].
	client := TusLibrosWebClient with: webClient .

	self 
		should: [client checkOutCartIdentifiedAs: cartId withCreditCardNumbered: creditCardNumber ownedBy: creditCardOwner expiringOn: expirationMonthOfYear] 
		raise:  Error
		withExceptionDo: [:anErrorMessage | anErrorMessage messageText = errorMessage ]! !

!TusLibrosWebClientTests methodsFor: 'tests' stamp: 'J.S 7/9/2019 03:58:35'!
test10RetrievesListPurchases

	| client webClient purchasesReceived listPurchases listPurchasesAsJson |
	
	listPurchases := Dictionary with: 'bookisbn1'->32 with: 'bookisbn2'->15. 
	listPurchasesAsJson := String streamContents:[:s| WebUtils jsonMap: listPurchases on: s]. "'{bookisbn1: 32,bookisbn2: 15}'."
	webClient := WebClientSimulator withRequestDo: [self buildResponseWith: 200 content:  listPurchasesAsJson ].
	client := TusLibrosWebClient with: webClient .

	purchasesReceived := client listPurchasesOf: user authenticatingWith: password.
	self assert: purchasesReceived = listPurchases ! !

!TusLibrosWebClientTests methodsFor: 'tests' stamp: 'J.S 7/9/2019 03:59:15'!
test11ThrowsCorrectErrorWhenListingPurchasesFails

	| client webClient |
	
	webClient := WebClientSimulator withRequestDo: [self buildResponseWith: 400 content:  errorMessage ].
	client := TusLibrosWebClient with: webClient .

	self 
		should: [client listPurchasesOf: user authenticatingWith: password ] 
		raise:  Error
		withExceptionDo: [:anErrorMessage | anErrorMessage messageText = errorMessage ]! !


!TusLibrosWebClientTests methodsFor: 'setup' stamp: 'J.S 7/9/2019 03:53:26'!
setUp

	errorMessage := 'this is an error message'.
	cartId := '3'.
	user := 'pepe'.
	password := '123'.
	creditCardNumber := '20125981259'.
	creditCardOwner := 'pepe'.
	expirationMonthOfYear := '10/25'.! !


!TusLibrosWebClientTests methodsFor: 'webresponse protocol' stamp: 'J.S 7/9/2019 03:01:21'!
buildResponseWith: aStatusCode content:  aContent

	^ (WebResponse protocol: 'HTTP/1.1' code: aStatusCode) content: aContent .! !


!classDefinition: #TusLibrosCheckoutWindowModel category: #'TusLibros-Web'!
Object subclass: #TusLibrosCheckoutWindowModel
	instanceVariableNames: 'webClient cookies creditCardNumber creditCardOwner cartItemsIndex cartItems expirationDate totalToPay'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosCheckoutWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'J.S 7/8/2019 16:07:22'!
creditCardNumber

	^ creditCardNumber! !

!TusLibrosCheckoutWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'J.S 7/8/2019 16:08:01'!
creditCardNumber: aCreditCardNumber

	creditCardNumber := aCreditCardNumber.
	^ true! !

!TusLibrosCheckoutWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'J.S 7/8/2019 16:08:33'!
creditCardOwner

	^ creditCardOwner! !

!TusLibrosCheckoutWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'J.S 7/8/2019 16:08:21'!
creditCardOwner: aCreditCardOwner

	creditCardOwner := aCreditCardOwner.
	^ true! !

!TusLibrosCheckoutWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'J.S 7/8/2019 16:22:56'!
expirationDate

	^ expirationDate! !

!TusLibrosCheckoutWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'J.S 7/8/2019 16:23:22'!
expirationDate: aMonthOfYear

	expirationDate := aMonthOfYear .
	^ true! !


!TusLibrosCheckoutWindowModel methodsFor: 'initialization' stamp: 'J.S 7/8/2019 17:01:48'!
initializeWith: someCookies

	| listCart priceList|
	cookies := someCookies.

	webClient := TusLibrosWebClient new.
	creditCardNumber := ''.
	creditCardOwner := ''.
	expirationDate := ''.
	
	cartItemsIndex := 0.
	cartItems := OrderedCollection new.
	
	totalToPay := 0.
	priceList := webClient getPriceList.
	listCart := webClient listCartIdentifiedAs: (cookies at: 'cartId').
	listCart keysAndValuesDo: [:aKey :aValue | | itemPrice |  
		itemPrice := (priceList at: aKey) * aValue.
		totalToPay := totalToPay + itemPrice.
		cartItems add: (aValue asString, 'x ', aKey, ': $', itemPrice asString) ]! !


!TusLibrosCheckoutWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'J.S 7/8/2019 18:10:42'!
sendCheckoutRequest
	| purchasesList |
	
	webClient 
		checkOutCartIdentifiedAs:  (cookies at: 'cartId') 
		withCreditCardNumbered:  creditCardNumber 
		ownedBy: creditCardOwner 
		expiringOn: expirationDate.
	
	purchasesList := webClient 
		listPurchasesOf:  (cookies at: 'user')
		authenticatingWith: (cookies at: 'password').
		
	TranscriptWindow openTranscript.
			Transcript clear.
			Transcript show: ('$', totalToPay asString, ' has been successfuly debited from credit card with number ', creditCardNumber) ; newLine .
			Transcript show: 'TusLibros history for user ', (cookies at: 'user'), ':' ; newLine .
			purchasesList keysAndValuesDo: [:aKey :aValue |
				Transcript show: (aKey, ': $', aValue asString); newLine .
				]! !


!TusLibrosCheckoutWindowModel methodsFor: 'PluggableListMorphs' stamp: 'J.S 7/8/2019 16:18:41'!
cartItems

	^ cartItems.! !

!TusLibrosCheckoutWindowModel methodsFor: 'PluggableListMorphs' stamp: 'J.S 7/8/2019 16:18:31'!
cartItemsIndex

	^ cartItemsIndex! !

!TusLibrosCheckoutWindowModel methodsFor: 'PluggableListMorphs' stamp: 'J.S 7/8/2019 16:18:20'!
cartItemsIndex: anIndex

	cartItemsIndex := anIndex.
	^ true.! !


!TusLibrosCheckoutWindowModel methodsFor: 'accessing' stamp: 'J.S 7/8/2019 17:02:33'!
totalToPay

	^ totalToPay .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosCheckoutWindowModel class' category: #'TusLibros-Web'!
TusLibrosCheckoutWindowModel class
	instanceVariableNames: ''!

!TusLibrosCheckoutWindowModel class methodsFor: 'instance creation' stamp: 'J.S 7/8/2019 15:34:32'!
with: someCookies
	
	^ self new initializeWith: someCookies.! !


!classDefinition: #TusLibrosClientWindowModel category: #'TusLibros-Web'!
Object subclass: #TusLibrosClientWindowModel
	instanceVariableNames: 'webClient cartItems cartItemsIndex catalog catalogIndex itemQuantity cookies'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosClientWindowModel methodsFor: 'initialization' stamp: 'J.S 7/8/2019 15:12:33'!
initializeWith: someCookies

	cookies := someCookies.
	
	catalogIndex := 0.
	cartItemsIndex := 0.
	itemQuantity := ''.
	webClient := TusLibrosWebClient new.
	
	catalog := webClient getPriceList keys.
	cartItems := (webClient listCartIdentifiedAs: (cookies at: 'cartId')) keys.! !


!TusLibrosClientWindowModel methodsFor: 'PluggableListMorphs' stamp: 'J.S 6/29/2019 16:54:43'!
cartItems

	^ cartItems.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListMorphs' stamp: 'J.S 6/29/2019 16:55:02'!
cartItemsIndex

	^ cartItemsIndex.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListMorphs' stamp: 'J.S 6/29/2019 16:56:00'!
cartItemsIndex: anIndex

	cartItemsIndex := anIndex.
	^ true.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListMorphs' stamp: 'J.S 6/29/2019 16:56:49'!
catalog

	^ catalog.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListMorphs' stamp: 'J.S 6/29/2019 16:56:54'!
catalogIndex

	^ catalogIndex.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListMorphs' stamp: 'J.S 6/29/2019 16:57:10'!
catalogIndex: anIndex

	catalogIndex := anIndex.
	^ true.! !


!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'J.S 6/29/2019 17:56:28'!
itemQuantity

	^ itemQuantity! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'J.S 7/8/2019 14:53:34'!
itemQuantity: aQuantity
	
	itemQuantity := aQuantity .
	^ true.! !


!TusLibrosClientWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'J.S 7/8/2019 15:17:19'!
sendAddItemRequest
		
	webClient 
		add: itemQuantity asNumber 
		of: (catalog at: catalogIndex) 
		toCartIdentifiedAs: (cookies at: 'cartId').
		
	self sendListCartRequest.
	! !

!TusLibrosClientWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'J.S 7/8/2019 15:18:37'!
sendListCartRequest
	| cartId |
	
	cartId := cookies at: 'cartId'.	
	cartItems := (webClient listCartIdentifiedAs: cartId) keys.
	
	self triggerEvent: #cartItemsUpdated with: self.
	! !


!TusLibrosClientWindowModel methodsFor: 'private - accessing' stamp: 'J.S 7/8/2019 16:47:49'!
cookies

	^ cookies.! !


!TusLibrosClientWindowModel methodsFor: 'checkout' stamp: 'J.S 7/8/2019 18:57:46'!
openCheckoutWindow
	
	TusLibrosCheckoutWindow openWith: cookies .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindowModel class' category: #'TusLibros-Web'!
TusLibrosClientWindowModel class
	instanceVariableNames: ''!

!TusLibrosClientWindowModel class methodsFor: 'instance creation' stamp: 'J.S 7/8/2019 15:10:42'!
with: someCookies
	
	^ self new initializeWith: someCookies.! !


!classDefinition: #TusLibrosLoginWindowModel category: #'TusLibros-Web'!
Object subclass: #TusLibrosLoginWindowModel
	instanceVariableNames: 'selectedIndex webClient user password sessionID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosLoginWindowModel methodsFor: 'initialize' stamp: 'J.S 7/9/2019 23:41:44'!
initialize
	
	user := ''.
	password := ''.
	selectedIndex:=0.
	webClient := TusLibrosWebClient new.! !


!TusLibrosLoginWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'J.S 6/29/2019 01:01:15'!
password

	^ password.! !

!TusLibrosLoginWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'J.S 6/29/2019 01:16:36'!
password: aPassword

	password := aPassword.
	^true! !

!TusLibrosLoginWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'J.S 6/29/2019 01:00:26'!
user

	^ user.! !

!TusLibrosLoginWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'J.S 6/29/2019 01:16:17'!
user: anUser

	user := anUser.
	^true! !


!TusLibrosLoginWindowModel methodsFor: 'PluggableButtonMorphs' stamp: 'J.S 7/8/2019 18:44:35'!
sendLoginRequest
		
	sessionID := webClient login: user with: password.
	
	"self triggerEvent: #loginSucceeded with: self."
	self openClientWindow.
	! !


!TusLibrosLoginWindowModel methodsFor: 'access' stamp: 'J.S 6/29/2019 19:02:43'!
sessionId

	^ sessionID 
	
	! !


!TusLibrosLoginWindowModel methodsFor: 'login' stamp: 'J.S 7/8/2019 18:42:21'!
openClientWindow
	
	| cookies |
	cookies := Dictionary new.
	cookies add: 'cartId' -> sessionID .
	cookies add: 'user' -> user.
	cookies add: 'password' -> password.
	
	TusLibrosClientWindow openWith: cookies .! !


!classDefinition: #TusLibrosServerController category: #'TusLibros-Web'!
Object subclass: #TusLibrosServerController
	instanceVariableNames: 'webServer port priceList cartInterface clients systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosServerController methodsFor: 'initialization' stamp: 'J.S 7/9/2019 20:16:18'!
initialize
	
	priceList := Dictionary new.
	priceList add: 'bookisbn1'->1.
	priceList add: 'bookisbn2'->2.
	priceList add: 'bookisbn3'->3.
	priceList add: 'bookisbn4'->4.
	
	clients := Dictionary new.
	clients add: 'pepe'->'passwordpepe'.
	
	systemFacade := TusLibrosSystemFacade
		authenticatingWith: clients
		acceptingItemsOf: priceList
		registeringOn: OrderedCollection new
		debitingThrought: self
		measuringTimeWith: DateAndTime.
	
	self initializeWith: systemFacade .
! !

!TusLibrosServerController methodsFor: 'initialization' stamp: 'J.S 7/9/2019 22:21:40'!
initializeWith: aSystemFacade
	
	systemFacade := aSystemFacade .
		
	webServer := WebServer new listenOn: self port.

	webServer addService: '/login' action:[:request | self login: request].
	webServer addService: '/priceList' action:[:request | self priceList: request].
	webServer addService: '/listCart' action:[:request | self listCart: request].
	webServer addService: '/addItem' action:[:request | self addItem: request].
	webServer addService: '/checkout' action:[:request |self checkout: request].
	webServer addService: '/listPurchases' action:[:request | self listPurchases: request ].
	
! !

!TusLibrosServerController methodsFor: 'initialization' stamp: 'J.S 6/28/2019 00:20:32'!
port
	"Use a random port to minimise chances of concurrently running test suites clashing."
	"^ port
		ifNil: [port := (10000 to: 50000) atRandom]"
	
	^port ifNil: [port:=8080].! !


!TusLibrosServerController methodsFor: 'enabling services' stamp: 'J.S 6/28/2019 00:20:54'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !

!TusLibrosServerController methodsFor: 'enabling services' stamp: 'J.S 6/28/2019 00:21:15'!
startListening
	
	webServer startListener ! !

!TusLibrosServerController methodsFor: 'enabling services' stamp: 'J.S 6/28/2019 00:21:25'!
stopListening
	
	webServer stopListener! !


!TusLibrosServerController methodsFor: 'merchant processor protocol' stamp: 'J.S 6/29/2019 00:09:29'!
debit: anAmount from: aCreditCard! !


!TusLibrosServerController methodsFor: 'actions' stamp: 'J.S 7/9/2019 23:37:44'!
addItem: aRequest
		
	self execute: [  | bookId cartId quantity cartItems| 	
			bookId := aRequest fields at: 'book'.
			cartId := (aRequest fields at: 'cartId') asNumber .
			quantity := (aRequest fields at: 'quantity') asNumber .
			systemFacade add: quantity of: bookId toCartIdentifiedAs: cartId.
			'OK'.] 
		sendStatusTo: aRequest.! !

!TusLibrosServerController methodsFor: 'actions' stamp: 'J.S 7/9/2019 23:37:00'!
checkout: aRequest
		
			
	self execute: [ | bookId cartId creditCardNumber creditCardExpirationMonthOfYear creditCardOwner | 	
			cartId := (aRequest fields at: 'cartId') asNumber .
			creditCardNumber := aRequest fields at: 'creditCardNumber'.
			creditCardOwner := aRequest fields at: 'owner'.
			creditCardExpirationMonthOfYear := Month readFrom: (aRequest fields at: 'expiringAt') readStream.

			systemFacade checkOutCartIdentifiedAs: cartId withCreditCardNumbered: creditCardNumber ownedBy: creditCardOwner expiringOn: creditCardExpirationMonthOfYear.
			'OK'.] 
		sendStatusTo: aRequest.
		
! !

!TusLibrosServerController methodsFor: 'actions' stamp: 'J.S 7/9/2019 23:28:27'!
execute: aBlockToExecute sendStatusTo: aRequest
	
	[ | responseContent |
	responseContent := aBlockToExecute value.
	aRequest send200Response: responseContent asString] 
		on: Error 
		do: [ :anError |
			aRequest send404Response: (anError messageText) ]! !

!TusLibrosServerController methodsFor: 'actions' stamp: 'J.S 7/9/2019 23:33:43'!
listCart: aRequest

	self execute: [ | cartItemsAsJson cartItems |
			cartItems := systemFacade listCartIdentifiedAs: (aRequest fields at: 'cartId') asNumber .
			cartItemsAsJson := String streamContents:[:s| WebUtils jsonMap: cartItems contents on: s]] 
		sendStatusTo: aRequest.! !

!TusLibrosServerController methodsFor: 'actions' stamp: 'J.S 7/9/2019 23:32:58'!
listPurchases: aRequest

	self execute: [ | userPurchasesAsJson userPurchases|
			userPurchases := systemFacade listPurchasesOf: (aRequest fields at: 'user') authenticatingWith: (aRequest fields at: 'password').
			userPurchasesAsJson := String streamContents:[:s| WebUtils jsonMap: userPurchases contents on: s]] 
		sendStatusTo: aRequest.
! !

!TusLibrosServerController methodsFor: 'actions' stamp: 'J.S 7/9/2019 23:30:29'!
login: aRequest
	
	self execute: [
			systemFacade 
				createCartFor: (aRequest fields at: 'user') 
				authenticatedWith: (aRequest fields at: 'password') ] 
		sendStatusTo: aRequest.! !

!TusLibrosServerController methodsFor: 'actions' stamp: 'J.S 7/10/2019 23:57:22'!
priceList: aRequest
	
	self execute: [ | priceListAsJson |
		self halt.
			priceListAsJson := String streamContents:[:s| WebUtils jsonMap: systemFacade catalog on: s]] 
		sendStatusTo: aRequest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosServerController class' category: #'TusLibros-Web'!
TusLibrosServerController class
	instanceVariableNames: ''!

!TusLibrosServerController class methodsFor: 'instance creation' stamp: 'J.S 7/10/2019 23:51:16'!
with: aSystemFacade

	^self basicNew initializeWith: aSystemFacade .! !


!classDefinition: #TusLibrosWebClient category: #'TusLibros-Web'!
Object subclass: #TusLibrosWebClient
	instanceVariableNames: 'port webClient'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosWebClient methodsFor: 'initialization' stamp: 'J.S 7/8/2019 19:14:43'!
initialize

	webClient := WebClient.! !

!TusLibrosWebClient methodsFor: 'initialization' stamp: 'J.S 7/8/2019 19:13:23'!
initializeWith: aWebClient

	webClient := aWebClient.! !

!TusLibrosWebClient methodsFor: 'initialization' stamp: 'J.S 6/28/2019 23:43:59'!
port
	
	^port ifNil: [port:=8080].! !

!TusLibrosWebClient methodsFor: 'initialization' stamp: 'J.S 6/28/2019 23:44:14'!
url
	
	^'http://localhost:', self port asString! !


!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'J.S 7/8/2019 18:32:27'!
add: aQuantity of: aBook toCartIdentifiedAs: aCartId 

	| fields|
	fields := Dictionary new.
	fields add: 'cartId' -> aCartId.
	fields add: 'book' -> aBook.
	fields add: 'quantity' -> aQuantity.
		
	self 
		doRequestTo: self url,'/addItem'
		with: fields 
		withResponseContentDo: [:content | ^ content asString].
! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'J.S 7/8/2019 18:32:41'!
checkOutCartIdentifiedAs: aCartId withCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear
		
	| fields|
	fields := Dictionary new.
	fields add: 'cartId' -> aCartId.
	fields add: 'creditCardNumber' -> aCreditCartNumber .
	fields add: 'owner' -> anOwner .
	fields add: 'expiringAt' -> anExpirationMonthOfYear.
		
	self 
		doRequestTo: self url,'/checkout'
		with: fields 
		withResponseContentDo: [:content | ^ content asString].
! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'J.S 7/9/2019 03:10:05'!
doRequestTo: anUrl with: someFields withResponseContentDo: anActionBlock

	| resp |
	
	resp:= webClient htmlSubmit: anUrl fields: someFields.
	
	resp isSuccess 
		ifTrue: [anActionBlock value: resp content]
		ifFalse:[^self error: resp content].! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'J.S 7/8/2019 18:28:51'!
getPriceList
		
	self 
		doRequestTo: self url,'/priceList'
		with: Dictionary new
		withResponseContentDo: [:content | ^ WebUtils jsonMapFrom: content readStream].! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'J.S 7/8/2019 18:33:30'!
listCartIdentifiedAs: aCartId

	| fields |
	
	fields := Dictionary with: 'cartId' -> aCartId.
		
	self 
		doRequestTo: self url,'/listCart'
		with: fields
		withResponseContentDo: [:content | ^ WebUtils jsonMapFrom: content readStream].! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'J.S 7/8/2019 18:33:12'!
listPurchasesOf: aUser authenticatingWith: aPassword

	| fields |
		
	fields := Dictionary new.
	fields add: 'user' -> aUser.
	fields add: 'password' -> aPassword.

	self 
		doRequestTo: self url,'/listPurchases'
		with: fields 
		withResponseContentDo: [:content | ^ WebUtils jsonMapFrom: content readStream].
! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'J.S 7/8/2019 18:33:17'!
login: anUser with: aPassword

	| fields |
	
	fields := Dictionary new.
	fields add: 'user' -> anUser.
	fields add: 'password' -> aPassword.
	
	self 
		doRequestTo: self url,'/login' 
		with: fields 
		withResponseContentDo: [:content | ^ content].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosWebClient class' category: #'TusLibros-Web'!
TusLibrosWebClient class
	instanceVariableNames: ''!

!TusLibrosWebClient class methodsFor: 'instance creation' stamp: 'J.S 7/10/2019 23:21:07'!
with: aWebClient

	^ self basicNew initializeWith: aWebClient.! !


!classDefinition: #WebClientSimulator category: #'TusLibros-Web'!
Object subclass: #WebClientSimulator
	instanceVariableNames: 'action'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!WebClientSimulator methodsFor: 'nil' stamp: 'J.S 7/8/2019 19:20:29'!
initializeWith: anActionBlock

	action := anActionBlock.! !


!WebClientSimulator methodsFor: 'webclient protocol' stamp: 'J.S 7/8/2019 19:53:09'!
htmlSubmit: anUrl fields: someFields.

	^ action value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WebClientSimulator class' category: #'TusLibros-Web'!
WebClientSimulator class
	instanceVariableNames: ''!

!WebClientSimulator class methodsFor: 'nil' stamp: 'J.S 7/8/2019 19:21:54'!
withRequestDo: anActionBlock

	^self new initializeWith: anActionBlock.! !
