!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolio account deposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'setUp' stamp: 'J.S 5/25/2019 01:23:51'!
setUp
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit for: 50.
	account register: deposit.
	! !

!PortfolioTest methodsFor: 'setUp' stamp: 'J.S 5/23/2019 20:53:59'!
test01AnEmptyPortfolioShouldHaveNoTransactionsAndBalanceZero

	| aPortfolio |
	
	aPortfolio := Portfolio new.
	self assert: (aPortfolio balance = 0).
	self assert: (aPortfolio transactions isEmpty)
	! !

!PortfolioTest methodsFor: 'setUp' stamp: 'J.S 5/25/2019 00:26:54'!
test02APortfolioCanHaveASingleAccountAndTheBalanceIsTheSame
	|anEmptyAccount|
	anEmptyAccount := ReceptiveAccount new.
	portfolio addAccount: anEmptyAccount.
	self assert: (portfolio balance = 0).
	self assert: (portfolio transactions isEmpty)
	! !

!PortfolioTest methodsFor: 'setUp' stamp: 'J.S 5/25/2019 00:25:51'!
test03APortfolioCanHaveASingleNonEmptyAccountAndTheBalanceIsTheSame

	portfolio addAccount: account.
	self assert: (portfolio balance = 50).
	self assert: (portfolio transactions isEmpty not)
	! !

!PortfolioTest methodsFor: 'setUp' stamp: 'J.S 5/25/2019 00:26:23'!
test04APortfolioCanHaveAnotherPortfolio

	| anotherPortfolio|
	
	anotherPortfolio := Portfolio new.
	
	anotherPortfolio addAccount: account.
	portfolio addPortfolio: anotherPortfolio.
	self assert: (portfolio balance = 50).
	self assert: (portfolio transactions isEmpty not)
	! !

!PortfolioTest methodsFor: 'setUp' stamp: 'J.S 5/26/2019 23:25:50'!
test05APortfolioCannotHaveTheSameAccountTwice
	
	portfolio addAccount: account.
	self should: [ portfolio addAccount: account]  raise: Error withMessageText: (Portfolio cannotAddFinantialRegisterError) .
	self assert: ((portfolio accounts) size = 1).
	! !

!PortfolioTest methodsFor: 'setUp' stamp: 'J.S 5/26/2019 23:25:50'!
test06APortfolioCannotHaveAnotherPortfolioWithTheSameAccount

	| anotherPortfolio |
	
	anotherPortfolio := Portfolio new.
	anotherPortfolio addAccount: account.
	portfolio addAccount: account.
	self should: [ portfolio addPortfolio: anotherPortfolio]  raise: Error withMessageText: (Portfolio cannotAddFinantialRegisterError) .
	self assert: ((portfolio accounts) size = 1).
	! !

!PortfolioTest methodsFor: 'setUp' stamp: 'J.S 5/25/2019 00:27:18'!
test07APortfolioCanHaveMoreThanOneAccount

	| anotherAccount |
	
	anotherAccount := ReceptiveAccount new.
	portfolio addAccount: account.
	portfolio addAccount: anotherAccount .
	self assert: (portfolio accounts size = 2).
	self assert: (portfolio accounts includes: account).
	self assert: (portfolio accounts includes: anotherAccount)
	! !

!PortfolioTest methodsFor: 'setUp' stamp: 'J.S 5/25/2019 00:27:27'!
test08APortfolioCanHaveMoreThanOnePortfolio

	| aPortfolioToPutInsideAPortfolio anotherPortfolioToPutInsideAPortfolio |
	
	aPortfolioToPutInsideAPortfolio := Portfolio new.
	anotherPortfolioToPutInsideAPortfolio := Portfolio new.
	portfolio addPortfolio: aPortfolioToPutInsideAPortfolio.
	portfolio addPortfolio: anotherPortfolioToPutInsideAPortfolio.
	self assert: (portfolio accounts size = 0).
	self assert: (portfolio portfolios size = 2).
	self assert: (portfolio portfolios includes: aPortfolioToPutInsideAPortfolio ).
	self assert: (portfolio portfolios includes: anotherPortfolioToPutInsideAPortfolio ).
	! !

!PortfolioTest methodsFor: 'setUp' stamp: 'J.S 5/25/2019 00:27:34'!
test09APortfolioCanHaveAPortfolioWithAnAccount

	| aPortfolioToPutInsideAPortfolio |
	
	aPortfolioToPutInsideAPortfolio := Portfolio new.
	aPortfolioToPutInsideAPortfolio addAccount: account.
	portfolio addPortfolio: aPortfolioToPutInsideAPortfolio.
	self assert: (portfolio accounts size = 0).
	self assert: (aPortfolioToPutInsideAPortfolio accounts size = 1).
	self assert: (portfolio portfolios size = 1).
	self assert: (portfolio portfolios includes: aPortfolioToPutInsideAPortfolio).
	! !

!PortfolioTest methodsFor: 'setUp' stamp: 'J.S 5/25/2019 00:29:31'!
test10APortfolioWithAnAccountHasTheSameTransactionsAsTheAccount

	portfolio addAccount: account.
	self assert: (portfolio balance = 50).
	self assert: (portfolio hasRegistered: deposit).
	! !

!PortfolioTest methodsFor: 'setUp' stamp: 'J.S 5/25/2019 00:29:45'!
test11APortfolioWithAPortfolioWithAnAccountHasTheSameTransactionsAsTheAccount

	| aPortfolioInsideThePortfolio|
	
	aPortfolioInsideThePortfolio := Portfolio new.
	portfolio := Portfolio new.
	
	aPortfolioInsideThePortfolio addAccount: account.
	portfolio addPortfolio: aPortfolioInsideThePortfolio.
	self assert: (portfolio balance = 50).
	self assert: (portfolio hasRegistered: deposit).
	! !

!PortfolioTest methodsFor: 'setUp' stamp: 'J.S 5/25/2019 00:30:20'!
test12APortfolioWithTwoAccountsContainsTheTransactionsOfBoth

	| anotherAccount aTransaction |
	
	anotherAccount := ReceptiveAccount new.
	aTransaction := Withdraw for: 100.
	
	anotherAccount register: aTransaction.
	portfolio addAccount: account.
	portfolio addAccount: anotherAccount.
	
	self assert: (portfolio balance = -50).
	self assert: (portfolio hasRegistered: deposit).
	self assert: (portfolio hasRegistered: aTransaction ).
	! !

!PortfolioTest methodsFor: 'setUp' stamp: 'J.S 5/26/2019 23:25:50'!
test13WhenAddingAPortfolioItsAccountsShouldNotBePresent
	| portfolioA portfolioB portfolioC anAccount aTransaction |
	
	portfolioA := Portfolio new.
	portfolioB := Portfolio new.
	portfolioC := Portfolio new.
	anAccount := ReceptiveAccount new.
	aTransaction := Withdraw for: 100.
	
	anAccount register: aTransaction.
	portfolio addAccount: anAccount.
	portfolio addAccount: account.
	
	portfolioA addAccount: account.
	portfolioB addPortfolio: portfolioA.
	portfolioC addPortfolio: portfolioB.
	
	self should: [ portfolio addPortfolio: portfolioC]  raise: Error withMessageText: (Portfolio cannotAddFinantialRegisterError) .! !

!PortfolioTest methodsFor: 'setUp' stamp: 'J.S 5/26/2019 16:07:19'!
test14WhenAddingAPortfolioItShouldHaveANewParent
	| parentPortfolio aPortfolio |
	 
	parentPortfolio := Portfolio new.
	aPortfolio := Portfolio new.
	
	self assert: (aPortfolio parents size = 1).
	parentPortfolio addPortfolio: aPortfolio.
	
	self assert: (aPortfolio parents includes: parentPortfolio).
	self assert: ((aPortfolio parents includes: aPortfolio) not).! !

!PortfolioTest methodsFor: 'setUp' stamp: 'J.S 5/26/2019 23:25:50'!
test15WhenAddingAnAccountItShouldNotBeInAParentPortfolio
	| parentPortfolio aPortfolio anAccount |
	 
	parentPortfolio := Portfolio new.
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	parentPortfolio addAccount: anAccount.
	parentPortfolio addPortfolio: aPortfolio.
	
	self should: [ aPortfolio addAccount: anAccount]  raise: Error withMessageText: (Portfolio cannotAddFinantialRegisterError) .! !

!PortfolioTest methodsFor: 'setUp' stamp: 'J.S 5/26/2019 23:25:50'!
test16WhenAddingAPortfolioItShouldNotBeInAParentPortfolio
	| parentPortfolio aPortfolio |
	 
	parentPortfolio := Portfolio new.
	aPortfolio := Portfolio new.
	
	aPortfolio addPortfolio: portfolio.
	parentPortfolio addPortfolio: portfolio.
	
	self should: [ parentPortfolio addPortfolio: aPortfolio]  raise: Error withMessageText: (Portfolio cannotAddFinantialRegisterError ) .! !

!PortfolioTest methodsFor: 'setUp' stamp: 'J.S 5/26/2019 23:25:50'!
test17CannotAddTwoPortfoliosWithTheSameAccount
	| portfolioA portfolioB anAccount |
	 
	portfolioA := Portfolio new.
	portfolioB := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	portfolioA addAccount: anAccount.
	portfolioB addAccount: anAccount.
	portfolio addPortfolio: portfolioA.
	
	self should: [ portfolio addPortfolio: portfolioB]  raise: Error withMessageText: (Portfolio cannotAddFinantialRegisterError ) .! !



!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'J.S 5/23/2019 20:33:17'!
balanceValue
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'J.S 5/23/2019 20:33:05'!
balanceValue
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'J.S 5/23/2019 20:20:55'!
value

	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'J.S 5/23/2019 20:32:38'!
balanceValue
	^value negated! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinantialRegister category: #'Portfolio-Ejercicio'!
Object subclass: #FinantialRegister
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinantialRegister methodsFor: 'functionality' stamp: 'J.S 5/26/2019 23:06:28'!
balance
	^self subclassResponsibility ! !

!FinantialRegister methodsFor: 'functionality' stamp: 'J.S 5/26/2019 23:06:55'!
hasRegistered: aFinantialRegistry
	^self subclassResponsibility ! !

!FinantialRegister methodsFor: 'functionality' stamp: 'J.S 5/26/2019 23:07:08'!
transactions
	^self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
FinantialRegister subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios parentsState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'private - functionality' stamp: 'J.S 5/26/2019 23:10:39'!
addAllTransactionsFrom: aFinantialRegistyCollection To: aTransactionsCollection

	aFinantialRegistyCollection do: [:anAccountOrPotfolio | aTransactionsCollection addAll: (anAccountOrPotfolio transactions)]. ! !

!Portfolio methodsFor: 'private - functionality' stamp: 'J.S 5/26/2019 16:03:30'!
addParent: aPortfolio 

	parentsState addParent: aPortfolio to: self.! !

!Portfolio methodsFor: 'private - functionality' stamp: 'J.S 5/26/2019 23:32:43'!
assertCanAddAccount: anAccount 

	(self getRoots) do: [:aRootPortfolio |   aRootPortfolio assertTreeStructureWhenAddingAccount: anAccount ].! !

!Portfolio methodsFor: 'private - functionality' stamp: 'J.S 5/26/2019 23:32:18'!
assertCanAddPortfolio: aPortfolio 
	
	(self getRoots) do: [:aRootPortfolio |   aRootPortfolio assertTreeStructureWhenAddingPortfolio: aPortfolio ].
	! !

!Portfolio methodsFor: 'private - functionality' stamp: 'J.S 5/26/2019 23:25:50'!
assertTreeStructureWhenAddingAccount: anAccount 

	(self manages: anAccount) ifTrue: [self error: Portfolio cannotAddFinantialRegisterError ].
	! !

!Portfolio methodsFor: 'private - functionality' stamp: 'J.S 5/26/2019 23:25:50'!
assertTreeStructureWhenAddingPortfolio: aPortfolio 

	(self = aPortfolio) ifTrue: [ self error: Portfolio cannotAddFinantialRegisterError ].
	
	portfolios do: [:aSubPortfolio | aSubPortfolio assertTreeStructureWhenAddingPortfolio: aPortfolio].
	
	(aPortfolio accounts) do: [:anAccount | self assertCanAddAccount: anAccount].
	(aPortfolio portfolios) do: [:aSubPortfolio | (self assertTreeStructureWhenAddingPortfolio: aSubPortfolio)].! !

!Portfolio methodsFor: 'private - functionality' stamp: 'J.S 5/26/2019 16:17:10'!
getRoots
	^parentsState getRootsOf: self
	! !

!Portfolio methodsFor: 'private - functionality' stamp: 'J.S 5/26/2019 00:46:26'!
manages: anAccount
	|managesAccount|
	managesAccount := (accounts includes: anAccount).
	portfolios do: [:aPortfolio | managesAccount := (managesAccount or: (aPortfolio manages: anAccount))].
	^managesAccount
	
! !


!Portfolio methodsFor: 'functionality' stamp: 'J.S 5/25/2019 01:12:49'!
addAccount: anAccount 
	self assertCanAddAccount: anAccount.
	accounts add: anAccount! !

!Portfolio methodsFor: 'functionality' stamp: 'J.S 5/25/2019 20:10:15'!
addPortfolio: aPortfolio 
	self assertCanAddPortfolio: aPortfolio.
	portfolios add: aPortfolio.
	aPortfolio addParent: self.! !

!Portfolio methodsFor: 'functionality' stamp: 'J.S 5/26/2019 23:12:24'!
balance
	^(self finantialRegisters sum: [:aFinancialRegister | aFinancialRegister balance] ifEmpty: [^0])
	! !

!Portfolio methodsFor: 'functionality' stamp: 'J.S 5/26/2019 23:13:20'!
hasRegistered: aTransaction 
	| hasRegiteredDeposit |
	
	hasRegiteredDeposit := false.
	self finantialRegisters do: [:aFinancialRegister | hasRegiteredDeposit := (hasRegiteredDeposit or: (aFinancialRegister hasRegistered: aTransaction)) ].
	^hasRegiteredDeposit ! !

!Portfolio methodsFor: 'functionality' stamp: 'J.S 5/26/2019 12:53:34'!
transactions
	| totalTransactions |
	
	totalTransactions := OrderedCollection new.
	self addAllTransactionsFrom: (accounts union: portfolios) To: totalTransactions.
	^totalTransactions ! !


!Portfolio methodsFor: 'initialization' stamp: 'J.S 5/26/2019 16:06:41'!
initialize
	accounts := OrderedCollection new.
	portfolios := OrderedCollection new.
	parentsState := RootPortfolioState new.! !


!Portfolio methodsFor: 'inspecting' stamp: 'J.S 5/23/2019 21:44:21'!
accounts
	^accounts! !

!Portfolio methodsFor: 'inspecting' stamp: 'J.S 5/26/2019 23:12:24'!
finantialRegisters
	^(accounts union: portfolios)! !

!Portfolio methodsFor: 'inspecting' stamp: 'J.S 5/26/2019 23:09:17'!
parents
	^parentsState parentsOf: self! !

!Portfolio methodsFor: 'inspecting' stamp: 'J.S 5/26/2019 16:05:23'!
parentsState: aParentsState
	parentsState := aParentsState ! !

!Portfolio methodsFor: 'inspecting' stamp: 'J.S 5/23/2019 21:44:27'!
portfolios
	^portfolios! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'J.S 5/26/2019 23:25:50'!
cannotAddFinantialRegisterError
	^'cant repeat accounts or portfolios'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
FinantialRegister subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'J.S 5/23/2019 21:04:13'!
balance

	^transactions sum: [ :aTransaction | aTransaction balanceValue ] ifEmpty: [ 0 ]! !



!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !



!classDefinition: #PortfolioState category: #'Portfolio-Ejercicio'!
Object subclass: #PortfolioState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!classDefinition: #NonRootPortfolioState category: #'Portfolio-Ejercicio'!
PortfolioState subclass: #NonRootPortfolioState
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!NonRootPortfolioState methodsFor: 'as yet unclassified' stamp: 'J.S 5/26/2019 16:03:57'!
addParent: aParentPortfolio to: aPortfolio
	parents add: aParentPortfolio .! !

!NonRootPortfolioState methodsFor: 'as yet unclassified' stamp: 'J.S 5/26/2019 16:13:53'!
getRootsOf: aPortfolio
	| rootsOfPortfolios |
	rootsOfPortfolios := Set new.
	parents do: [:aParentPortfolio | rootsOfPortfolios addAll: (aParentPortfolio getRoots)].

	^rootsOfPortfolios! !

!NonRootPortfolioState methodsFor: 'as yet unclassified' stamp: 'J.S 5/26/2019 16:05:45'!
initialize

	parents := Set new.! !

!NonRootPortfolioState methodsFor: 'as yet unclassified' stamp: 'J.S 5/26/2019 16:16:16'!
parentsOf: aPortfolio
	
	^parents! !


!classDefinition: #RootPortfolioState category: #'Portfolio-Ejercicio'!
PortfolioState subclass: #RootPortfolioState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!RootPortfolioState methodsFor: 'as yet unclassified' stamp: 'J.S 5/26/2019 16:05:04'!
addParent: aParentPortfolio to: aPortfolio
	| aNonRootPortfolioState |
	
	aNonRootPortfolioState := NonRootPortfolioState new.
	aNonRootPortfolioState addParent: aParentPortfolio to: aPortfolio.
	aPortfolio parentsState: aNonRootPortfolioState .
	! !

!RootPortfolioState methodsFor: 'as yet unclassified' stamp: 'J.S 5/26/2019 16:13:36'!
getRootsOf: aPortfolio
	^Set with: aPortfolio! !

!RootPortfolioState methodsFor: 'as yet unclassified' stamp: 'J.S 5/26/2019 16:13:18'!
parentsOf: aPortfolio
	^Set with: aPortfolio.! !
