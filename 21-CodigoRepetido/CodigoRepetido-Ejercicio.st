!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'J.S 4/4/2019 20:05:29'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertDoesNotTakeMoreThan: 50 * millisecond toRun: [customerBook addCustomerNamed: 'John Lennon'].
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'J.S 4/4/2019 20:05:10'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  
	self assertDoesNotTakeMoreThan: 100 * millisecond toRun: [customerBook removeCustomerNamed: paulMcCartney].
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'J.S 4/4/2019 21:07:25'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
		
	self 
		assertThatBlock: [customerBook addCustomerNamed: ''.]
		throwsError: Error 
		andExecuteAfterError:  [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'J.S 4/4/2019 21:07:30'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self 
		assertThatBlock: [ customerBook removeCustomerNamed: 'Paul McCartney'.]
		throwsError: NotFound 
		andExecuteAfterError: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'J.S 4/7/2019 23:22:27'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.

	self addAndSuspendCustomer: paulMcCartney toCustomerBook: customerBook.
	
	self assertFromCustomerBook: customerBook activesCount: 0 suspendedCount: 1 totalCount: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'J.S 4/7/2019 23:22:45'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.

	self addAndSuspendCustomer: paulMcCartney toCustomerBook: customerBook.
	customerBook removeCustomerNamed: paulMcCartney.
	
	
	self assertFromCustomerBook: customerBook activesCount: 0 suspendedCount: 0 totalCount: 0.

	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'J.S 4/4/2019 21:11:27'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.

	self 
		assertThatBlock: [ customerBook suspendCustomerNamed: 'Paul McCartney'.]
		throwsError: CantSuspend 
		andExecuteAfterError: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'J.S 4/7/2019 23:43:29'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	self addAndSuspendCustomer: johnLennon toCustomerBook: customerBook.
	
	self 
		assertThatBlock: [ customerBook suspendCustomerNamed: johnLennon.]
		throwsError: CantSuspend 
		andExecuteAfterError: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!CustomerBookTest methodsFor: 'assertions' stamp: 'J.S 4/7/2019 23:39:23'!
assertDoesNotTakeMoreThan: anAmountOfTime toRun: aClosure
	self assert: (aClosure timeToRun) < anAmountOfTime
! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'J.S 4/7/2019 23:22:04'!
assertFromCustomerBook: aCustomerBook activesCount: anExpectedCountOfActiveCustomers
suspendedCount: anExpectedCountOfSuspendedCustomers totalCount: anExpectedTotalCountOfCustomers
	
	self assert: anExpectedCountOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: anExpectedCountOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: anExpectedTotalCountOfCustomers equals: aCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'J.S 4/4/2019 21:07:02'!
assertThatBlock: aClosure throwsError: anError andExecuteAfterError: postExecutionClosure
	
	[aClosure value. 
	self fail]
		on: anError
		do: postExecutionClosure! !


!CustomerBookTest methodsFor: 'customer management' stamp: 'J.S 4/4/2019 21:38:55'!
addAndSuspendCustomer: aCustomer toCustomerBook: aCustomerBook

	aCustomerBook addCustomerNamed: aCustomer.
	aCustomerBook suspendCustomerNamed: aCustomer.! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'J.S 4/7/2019 21:41:24'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'J.S 4/6/2019 17:27:44'!
numberOfCustomers
	
	^ self numberOfActiveCustomers + self numberOfSuspendedCustomers.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'J.S 4/6/2019 17:42:30'!
removeCustomerNamed: aName 
	
	active remove: aName ifAbsent: [
		suspended remove: aName ifAbsent: [
			^NotFound signal
		]
	].
	^ aName.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/3/2019 10:16:22'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/3/2019 10:16:31'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
