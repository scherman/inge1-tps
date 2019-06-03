!classDefinition: #PortfolioTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:15'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

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


!classDefinition: #ReporterTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReporterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!classDefinition: #AccountSummaryReporterTests category: #'Portfolio-Solucion'!
ReporterTest subclass: #AccountSummaryReporterTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:19:38'!
test01ReportOfEmptyTransactionsIsCorrect

	| account report |
	account := ReceptiveAccount new.
	
	report := account generateReport: AccountSummaryReporter new.
	self assert: (report sameAs:  'Balance = 0').

	! !

!AccountSummaryReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:19:30'!
test02ReportOfDepositIsCorrect

	| account report |
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	
	report := account generateReport: AccountSummaryReporter new.
	self assert: (report sameAs: 'Deposito por 100. Balance = 100').

	
	! !

!AccountSummaryReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:19:23'!
test03ReportOfWithdrawIsCorrect

	| account report |
	account := ReceptiveAccount new.
	
	Withdraw register: 100 on: account.
	
	report := account generateReport: AccountSummaryReporter new.
	self assert: (report sameAs: 'Extraccion por 100. Balance = -100').

	
	! !

!AccountSummaryReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:19:15'!
test04ReportOfDepositByTransferIsCorrect

	| aSourceAccount aDestinationAccount report |
	aSourceAccount := ReceptiveAccount new.
	aDestinationAccount := ReceptiveAccount new.
	
	Transfer registerFor: 50 from: aSourceAccount to: aDestinationAccount.
	
	report := aDestinationAccount generateReport: AccountSummaryReporter new.
	self assert: (report sameAs: 'Entrada por transferencia de 50. Balance = 50').

	
	! !

!AccountSummaryReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:20:09'!
test05ReportOfWithdrawByTransferIsCorrect

	| aSourceAccount aDestinationAccount report |
	aSourceAccount := ReceptiveAccount new.
	aDestinationAccount := ReceptiveAccount new.
	
	Transfer registerFor: 50 from: aSourceAccount to: aDestinationAccount.
	
	report := aSourceAccount generateReport: AccountSummaryReporter new.
	self assert: (report sameAs: 'Salida por transferencia de 50. Balance = -50').

	
	! !

!AccountSummaryReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:20:46'!
test06ReportOfMultipleTransactionsIsCorrect

	| aSourceAccount aDestinationAccount report |
	aSourceAccount := ReceptiveAccount new.
	aDestinationAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: aSourceAccount.
	Deposit register: 100 on: aSourceAccount.
	Transfer registerFor: 50 from: aSourceAccount to: aDestinationAccount.
	Withdraw register: 50 on: aSourceAccount.
	
	report := aSourceAccount generateReport: AccountSummaryReporter new.
	self assert: ( report sameAs: 'Deposito por 100. Deposito por 100. Salida por transferencia de 50. Extraccion por 50. Balance = 100').

	
	! !

!AccountSummaryReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:21:47'!
test07ReportOfPortfolioParentOfAccountIsCorrect

	| portfolio account report |
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	report := portfolio generateReport: AccountSummaryReporter new.
	self assert: (report sameAs: 'Deposito por 100. Balance = 100').

	
	! !

!AccountSummaryReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:23:34'!
test08ReportOfPortfolioParentOfPortfolioIsCorrect

	| portfolio account simplePortfolioAccount2 parentPortfolio report |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	parentPortfolio := Portfolio with: portfolio.
	
	report := parentPortfolio generateReport: AccountSummaryReporter new.
	self assert: (report sameAs: 'Deposito por 100. Balance = 100').

	
	! !

!AccountSummaryReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:27:12'!
test09ReportOfPortfolioParentOfBothIsCorrect

	| portfolio account1 parentPortfolio report account2 |
	
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	portfolio := Portfolio with: account1.
	
	account2 := ReceptiveAccount new.
	Transfer registerFor: 20 from: account1 to: account2.
	
	parentPortfolio := Portfolio with: portfolio with: account2.
	
	report := parentPortfolio generateReport: AccountSummaryReporter new.
	self assert: (report sameAs: 'Deposito por 100. Salida por transferencia de 20. Entrada por transferencia de 20. Balance = 100').

	
	! !


!classDefinition: #SpecialSummaryReporterTests category: #'Portfolio-Solucion'!
ReporterTest subclass: #SpecialSummaryReporterTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SpecialSummaryReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:37:21'!
test01ReportOfEmptyTransactionsIsCorrect

	| account report expectedResult name |
	name := 'Cuenta de Juan'.
	account := ReceptiveAccount named: name.
	
	report := account generateReport: SpecialSummaryReporter new.
	expectedResult := name, String newLineString, '    Balance = 0'.

	self assert: (report sameAs:  expectedResult).

	! !

!SpecialSummaryReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:38:06'!
test02ReportOfDepositByTransferIsCorrect

	| aSourceAccount report expectedResult aDestinationAccount |
	aSourceAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	aDestinationAccount := ReceptiveAccount named: 'Cuenta de Miguel'.
	
	Transfer registerFor: 100 from: aSourceAccount to: aDestinationAccount.
	
	report := aDestinationAccount generateReport: SpecialSummaryReporter new.
	expectedResult := aDestinationAccount name
		, (String newLineString), '    Entrada por transferencia de 100'
		, (String newLineString), '    Balance = 100'.
	self assert: (report sameAs: expectedResult).

	
	! !

!SpecialSummaryReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:38:37'!
test03ReportOfDepositIsCorrect

	| account report expectedResult name |
	name := 'Cuenta de Juan'.
	account := ReceptiveAccount named: name.
	
	Deposit register: 100 on: account.
	
	report := account generateReport: SpecialSummaryReporter new.
	expectedResult := name
		, (String newLineString), '    Deposito por 100'
		, (String newLineString), '    Balance = 100'.
	self assert: (report sameAs: expectedResult).

	
	! !

!SpecialSummaryReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:39:00'!
test04ReportOfWithdrawByTransferIsCorrect

	| aSourceAccount report expectedResult aDestinationAccount |
	aSourceAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	aDestinationAccount := ReceptiveAccount named: 'Cuenta de Miguel'.
	
	Transfer registerFor: 100 from: aSourceAccount to: aDestinationAccount.
	
	report := aSourceAccount generateReport: SpecialSummaryReporter new.
	expectedResult := aSourceAccount name
		, (String newLineString), '    Salida por transferencia de 100'
		, (String newLineString), '    Balance = -100'.
	self assert: (report sameAs: expectedResult).

	
	! !

!SpecialSummaryReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:39:22'!
test05ReportOfWithdrawIsCorrect

	| account report expectedResult name |
	name := 'Cuenta de Juan'.
	account := ReceptiveAccount named: name.
	
	Withdraw register: 100 on: account.
	
	report := account generateReport: SpecialSummaryReporter new.
	expectedResult := name
		, (String newLineString), '    Extraccion por 100'
		, (String newLineString), '    Balance = -100'.
	self assert: (report sameAs: expectedResult).

	
	! !

!SpecialSummaryReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:43:24'!
test06ReportOfMultipleTransactionsIsCorrect
	
	| aSourceAccount report expectedResult name aDestinationAccount |
	name := 'Cuenta de Juan'.
	aSourceAccount := ReceptiveAccount named: name.
	aDestinationAccount := ReceptiveAccount named: 'Cuenta de Jonas'.
	
	Deposit register: 100 on: aSourceAccount.
	Deposit register: 100 on: aSourceAccount.
	Transfer registerFor: 50 from: aSourceAccount to: aDestinationAccount.
	Withdraw register: 50 on: aSourceAccount.
	
	report := aSourceAccount generateReport: SpecialSummaryReporter new.
	expectedResult := name
		, (String newLineString), '    Deposito por 100'
		, (String newLineString), '    Deposito por 100'
		, (String newLineString), '    Salida por transferencia de 50'
		, (String newLineString), '    Extraccion por 50'
		, (String newLineString), '    Balance = 100'.
	self assert: (report sameAs: expectedResult).

	
	! !

!SpecialSummaryReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:44:31'!
test07ReportOfPortfolioParentOfAccountIsCorrect

	| account report expectedResult portfolio |
	account := ReceptiveAccount named: 'Cuenta de Juan'.
	portfolio := Portfolio named: 'Cuenta de Romina' with: account.
	
	Deposit register: 100 on: account.
	
	report := portfolio generateReport: SpecialSummaryReporter new.
	expectedResult := portfolio name
		, (String newLineString), '    ', account name
		, (String newLineString), '        Deposito por 100'
		, (String newLineString), '        Balance = 100'
		, (String newLineString), '    Balance = 100'.
		
	self assert: (report sameAs: expectedResult).

	
	! !

!SpecialSummaryReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:44:55'!
test08ReportOfPortfolioParentOfPortfolioIsCorrect

	| account report expectedResult portfolio parentPortfolio |
	
	account := ReceptiveAccount named: 'Cuenta de Juan'.
	portfolio := Portfolio named: 'Cuenta de Romina' with: account.
	parentPortfolio := Portfolio named: 'Cuenta de Berta' with: portfolio.
	
	Deposit register: 100 on: account.
	
	report := parentPortfolio generateReport: SpecialSummaryReporter new.
	expectedResult := parentPortfolio name
		, (String newLineString), '    ', portfolio name
		, (String newLineString), '        ', account name
		, (String newLineString), '            Deposito por 100'
		, (String newLineString), '            Balance = 100'
		, (String newLineString), '        Balance = 100'
		, (String newLineString), '    Balance = 100'.
		
	self assert: (report sameAs: expectedResult).

	
	! !


!classDefinition: #TransferNetReporterTests category: #'Portfolio-Solucion'!
ReporterTest subclass: #TransferNetReporterTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:28:38'!
test01EmptyTransactionsReports0NetValue
	
	| anAccount report |
	anAccount := ReceptiveAccount new.
	
	report := anAccount generateReport: TransferNetReporter new.
	self assert: ( report = 'Valor neto transferencias: 0. ').

	
	! !

!TransferNetReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:29:26'!
test02DepositReports0NetValue
	
	| account report |
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	
	report := account generateReport: TransferNetReporter new.
	self assert: ( report = 'Valor neto transferencias: 0. ').

	
	! !

!TransferNetReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:29:59'!
test03WithdrawReports0NetValue
	
	| account report |
	account := ReceptiveAccount new.
	
	Withdraw register: 100 on: account.
	
	report := account generateReport: TransferNetReporter new.
	self assert: ( report = 'Valor neto transferencias: 0. ').

	
	! !

!TransferNetReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:30:33'!
test04DepositByTransferAddsToNetValue
	
	| aSourceAccount aDestinationAccount report |
	aSourceAccount := ReceptiveAccount new.
	aDestinationAccount := ReceptiveAccount new.
	
	Transfer registerFor: 50 from: aDestinationAccount to: aSourceAccount.
	
	report := aSourceAccount generateReport: TransferNetReporter new.
	self assert: (report  = 'Valor neto transferencias: 50. ').

	
	! !

!TransferNetReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:31:24'!
test05WithdrawByTransferSubstractsToNetValue
	
	| aSourceAccount aDestinationAccount report |
	aSourceAccount := ReceptiveAccount new.
	aDestinationAccount := ReceptiveAccount new.
	
	Transfer registerFor: 50 from: aSourceAccount to: aDestinationAccount.
	
	report := aSourceAccount generateReport: TransferNetReporter new.
	self assert: (report  = 'Valor neto transferencias: -50. ').

	
	! !

!TransferNetReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:32:28'!
test06OnlyTransactionsByTransferAreConsideredToNetValue
	
	| aSourceAccount aDestinationAccount report |
	aSourceAccount := ReceptiveAccount new.
	aDestinationAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: aSourceAccount.
	Transfer registerFor: 50 from: aSourceAccount to: aDestinationAccount.
	Withdraw register: 50 on: aSourceAccount.
	Transfer registerFor: 25 from: aDestinationAccount to: aSourceAccount.
	Deposit register: 10 on: aSourceAccount.
	
	report := aSourceAccount generateReport: TransferNetReporter new.
	self assert: (report  = 'Valor neto transferencias: -25. ').

	
	! !

!TransferNetReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:34:57'!
test07ReportOfPortfolioParentOfAccountIsCorrect

	| simplePortfolio aSourceAccount aDestinationAccount report |
	aSourceAccount := ReceptiveAccount new.
	aDestinationAccount := ReceptiveAccount new.
	Transfer registerFor: 100 from: aSourceAccount to: aDestinationAccount.
	Transfer registerFor: 50 from: aDestinationAccount to: aSourceAccount.
	simplePortfolio := Portfolio with: aSourceAccount.
	
	report := simplePortfolio generateReport: TransferNetReporter new.
	self assert: (report  = 'Valor neto transferencias: -50. ').! !

!TransferNetReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:36:22'!
test08ReportOfPortfolioParentOfPortfolioIsCorrect

	| portfolio aSourceAccount aDestinationAccount report parentPortfolio |
	aSourceAccount := ReceptiveAccount new.
	aDestinationAccount := ReceptiveAccount new.
	Transfer registerFor: 100 from: aSourceAccount to: aDestinationAccount.
	Transfer registerFor: 50 from: aDestinationAccount to: aSourceAccount.
	portfolio := Portfolio with: aSourceAccount.
	parentPortfolio := Portfolio with: portfolio.
	
	report := parentPortfolio generateReport: TransferNetReporter new.
	self assert: (report  = 'Valor neto transferencias: -50. ').! !


!classDefinition: #TreeSummaryReporterTests category: #'Portfolio-Solucion'!
ReporterTest subclass: #TreeSummaryReporterTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TreeSummaryReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 01:50:52'!
test01ReportOfEmptyTransactionsIsCorrect

	| account report expectedResult name |
	name := 'Cuenta de Juan'.
	account := ReceptiveAccount named: name.
	
	report := account generateReport: TreeSummaryReporter new.
	expectedResult := name.

	self assert: (report sameAs:  expectedResult).

	! !

!TreeSummaryReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 02:00:28'!
test02ReportOfNonEmptyTransactionsIsCorrect

	| account report expectedResult name |
	name := 'Cuenta de Juan'.
	account := ReceptiveAccount named: name.
	
	Deposit register: 100 on: account.
	Withdraw register: 20 on: account.
	
	report := account generateReport: TreeSummaryReporter new.
	expectedResult := name.
	self assert: (report sameAs:  expectedResult).

	! !

!TreeSummaryReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 02:06:16'!
test03ReportOfPortfolioParentOfAccountIsCorrect

	| account report expectedResult portfolio anotherAccount |
	account := ReceptiveAccount named: 'Cuenta de Juan'.
	anotherAccount := ReceptiveAccount named: 'Cuenta del Loro'.
	portfolio := Portfolio named: 'Cuenta de Romina' with: account with: anotherAccount .
	
	report := portfolio generateReport: TreeSummaryReporter new.
	expectedResult := portfolio name
		, (String newLineString), '    ', account name
		, (String newLineString), '    ', anotherAccount name.
	self assert: (report sameAs: expectedResult).

	
	! !

!TreeSummaryReporterTests methodsFor: 'tests' stamp: 'js 6/3/2019 02:11:15'!
test04ReportOfPortfolioParentOfPortfolioIsCorrect

	| account report expectedResult portfolio anotherAccount parentPortfolio |
	account := ReceptiveAccount named: 'Cuenta de Juan'.
	anotherAccount := ReceptiveAccount named: 'Cuenta del Loro'.
	portfolio := Portfolio named: 'Cuenta de Romina' with: account with: anotherAccount .
	parentPortfolio := Portfolio named: 'Cuenta de Dios' with: portfolio.
	
	report := parentPortfolio generateReport: TreeSummaryReporter new.
	expectedResult := parentPortfolio name
		, (String newLineString), '    ', portfolio name
		, (String newLineString), '        ', account name
		, (String newLineString), '        ', anotherAccount name.
	self assert: (report sameAs: expectedResult).

	
	! !


!classDefinition: #TransferTest category: #'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'setUp' stamp: 'J.S 6/2/2019 15:31:17'!
setUp
	"anAmountOfPesos := 100.
	transfer := Transfer for: anAmountOfPesos."
	! !


!TransferTest methodsFor: 'tests' stamp: 'J.S 6/2/2019 17:53:28'!
test01BalanceChangesWhenAccountTransfersToAnother

	| srcAccount deposit transfer dstAccount |
	
	srcAccount := ReceptiveAccount new.
	dstAccount := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: srcAccount.
	transfer := Transfer registerFor: 50 from: srcAccount to: dstAccount.
	
	self assert: 50 equals: srcAccount balance.
	self assert: 50 equals: dstAccount balance.! !

!TransferTest methodsFor: 'tests' stamp: 'J.S 6/2/2019 17:53:45'!
test02RegistersTransactionsWhenAccountTransfersToAnother

	| srcAccount deposit transfer dstAccount |
	
	srcAccount := ReceptiveAccount new.
	dstAccount := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: srcAccount.
	transfer := Transfer registerFor: 100 from: srcAccount to: dstAccount.
	.
	self assert: (srcAccount transactions size = 2). 
	self assert: (srcAccount hasRegistered: deposit).
	self assert: (srcAccount hasRegistered: transfer withdrawLeg).
	
	self assert: (dstAccount transactions size = 1). 
	self assert: (dstAccount hasRegistered: transfer depositLeg ).! !

!TransferTest methodsFor: 'tests' stamp: 'J.S 6/2/2019 17:53:57'!
test03TransferLegsPointToTranferWhenRegisteringTransfer

	| srcAccount transfer dstAccount |
	
	srcAccount := ReceptiveAccount new.
	dstAccount := ReceptiveAccount new.
	
	transfer := Transfer registerFor: 100 from: srcAccount to: dstAccount.
	self assert: ( transfer withdrawLeg transfer = transfer).
	self assert: ( transfer depositLeg transfer = transfer).! !

!TransferTest methodsFor: 'tests' stamp: 'J.S 6/2/2019 17:52:20'!
test04CannotTransferToSameAccount

	| account1 transfer |
	
	account1 := ReceptiveAccount new.
	
	self should: [transfer := Transfer registerFor: 100 from: account1 to: account1. self fail.]
		raise: Error
		withMessageText: Transfer cannotTransferToSameAccountErrorMessage.
		
	self assert: ( account1 transactions isEmpty).
	self assert: ( account1 balance = 0).

	! !


!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'reports' stamp: 'J.S 6/2/2019 20:22:39'!
generateReport: aReporter

	self subclassResponsibility .! !


!Account methodsFor: 'initialization' stamp: 'js 6/2/2019 22:57:18'!
initializeWith: aName
	name := aName! !


!Account methodsFor: 'getters' stamp: 'js 6/2/2019 22:57:48'!
name
	^name! !


!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'js 6/2/2019 22:56:58'!
initializeWith: aName
	
	super initializeWith: aName.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'reports' stamp: 'js 6/2/2019 23:44:26'!
generateReport: aReporter
	
	^ aReporter reportPortfolio: self.! !


!Portfolio methodsFor: 'getters' stamp: 'js 6/3/2019 00:27:10'!
accounts

	^ accounts .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'js 6/2/2019 22:52:00'!
named: aName with: anAccount

	^(self new initializeWith: aName)
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'js 6/2/2019 22:52:36'!
named: aName with: anAccount with: anotherAccount

	^(self new initializeWith: aName) 
		add: anAccount;
		add: anotherAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!Portfolio class methodsFor: 'error' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'js 6/2/2019 22:56:46'!
initializeWith: aName

	super initializeWith: aName.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'J.S 6/2/2019 16:44:06'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'js 6/2/2019 23:44:33'!
generateReport: aReporter
	
	^ aReporter reportReceptiveAccount: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: #'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'js 6/2/2019 23:16:48'!
named: aName

	^ self new initializeWith: aName.
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reporting' stamp: 'js 6/2/2019 22:33:43'!
accept: aReporter

	^ aReporter reportWithdrawByTransfer: self. ! !


!classDefinition: #RegularTransaction category: #'Portfolio-Solucion'!
AccountTransaction subclass: #RegularTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!RegularTransaction methodsFor: 'initialization' stamp: 'js 6/2/2019 22:41:24'!
initializeFor: aValue

	value := aValue ! !


!RegularTransaction methodsFor: 'getters' stamp: 'js 6/2/2019 22:41:57'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RegularTransaction class' category: #'Portfolio-Solucion'!
RegularTransaction class
	instanceVariableNames: ''!

!RegularTransaction class methodsFor: 'instance creation' stamp: 'js 6/2/2019 22:40:49'!
for: aValue

	^ self new initializeFor: aValue ! !

!RegularTransaction class methodsFor: 'instance creation' stamp: 'js 6/2/2019 22:38:50'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'Portfolio-Solucion'!
RegularTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'visiting' stamp: 'js 6/2/2019 22:33:33'!
accept: aReporter

	^ aReporter reportDeposit: self.! !


!classDefinition: #Withdraw category: #'Portfolio-Solucion'!
RegularTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'visiting' stamp: 'js 6/2/2019 22:34:20'!
accept: aReporter

	^ aReporter reportWithdraw: self.! !


!classDefinition: #TransactionByTransfer category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransactionByTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransactionByTransfer methodsFor: 'getters' stamp: 'J.S 6/2/2019 18:04:06'!
transfer

	^ transfer.! !


!TransactionByTransfer methodsFor: 'initialization' stamp: 'J.S 6/2/2019 18:04:25'!
initializeWith: aTransfer

	transfer := aTransfer.! !


!TransactionByTransfer methodsFor: 'comparing' stamp: 'J.S 6/2/2019 18:05:00'!
= aTransfer

	^ (self class = aTransfer class) and: (transfer = aTransfer transfer)! !


!TransactionByTransfer methodsFor: 'value' stamp: 'J.S 6/2/2019 18:06:15'!
value

	^ transfer value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransactionByTransfer class' category: #'Portfolio-Solucion'!
TransactionByTransfer class
	instanceVariableNames: ''!

!TransactionByTransfer class methodsFor: 'instance creation' stamp: 'J.S 6/2/2019 18:06:57'!
of: aTransfer

	^ self new initializeWith: aTransfer.! !


!classDefinition: #DepositByTransfer category: #'Portfolio-Solucion'!
TransactionByTransfer subclass: #DepositByTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DepositByTransfer methodsFor: 'balance' stamp: 'J.S 6/2/2019 16:21:06'!
affectBalance: aBalance

	^aBalance + transfer value.! !


!DepositByTransfer methodsFor: 'visiting' stamp: 'js 6/2/2019 22:33:58'!
accept: aReporter

	^ aReporter reportDepositByTransfer: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DepositByTransfer class' category: #'Portfolio-Solucion'!
DepositByTransfer class
	instanceVariableNames: 'transfer'!


!classDefinition: #WithdrawByTransfer category: #'Portfolio-Solucion'!
TransactionByTransfer subclass: #WithdrawByTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WithdrawByTransfer methodsFor: 'balance' stamp: 'J.S 6/2/2019 16:22:02'!
affectBalance: aBalance 
	^(aBalance - (transfer value)).! !


!WithdrawByTransfer methodsFor: 'visiting' stamp: 'js 6/2/2019 22:34:05'!
accept: aReporter

	^ aReporter reportWithdrawByTransfer: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WithdrawByTransfer class' category: #'Portfolio-Solucion'!
WithdrawByTransfer class
	instanceVariableNames: 'transfer'!


!classDefinition: #Reporter category: #'Portfolio-Solucion'!
Object subclass: #Reporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Reporter methodsFor: 'reporting' stamp: 'js 6/2/2019 22:31:49'!
reportDeposit: aDeposit

	self subclassResponsibility ! !

!Reporter methodsFor: 'reporting' stamp: 'js 6/2/2019 22:31:55'!
reportDepositByTransfer: aDepositByTransfer

	self subclassResponsibility ! !

!Reporter methodsFor: 'reporting' stamp: 'js 6/3/2019 01:53:57'!
reportPortfolio: aPortfolio

	self subclassResponsibility ! !

!Reporter methodsFor: 'reporting' stamp: 'js 6/3/2019 01:53:49'!
reportReceptiveAccount: aReceptiveAccount

	self subclassResponsibility ! !

!Reporter methodsFor: 'reporting' stamp: 'js 6/2/2019 22:32:27'!
reportTransaction: aTransaction

	^ aTransaction accept: self.! !

!Reporter methodsFor: 'reporting' stamp: 'js 6/2/2019 22:32:12'!
reportWithdraw: aWithdraw

	self subclassResponsibility ! !

!Reporter methodsFor: 'reporting' stamp: 'js 6/2/2019 22:32:05'!
reportWithdrawByTransfer: aWithdrawByTransfer

	self subclassResponsibility ! !


!Reporter methodsFor: 'formatting' stamp: 'js 6/3/2019 01:57:39'!
generateIndentationWith: aNumberOfIndents

	^ String streamContents: [:result | 
		aNumberOfIndents timesRepeat: [result nextPutAll: ' ']].! !


!classDefinition: #AccountSummaryReporter category: #'Portfolio-Solucion'!
Reporter subclass: #AccountSummaryReporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryReporter methodsFor: 'reporting' stamp: 'js 6/2/2019 23:37:24'!
reportAccount: anAccount

	^ String streamContents: [:result |
		
		anAccount transactions do: [:aTransaction | result nextPutAll: (self reportTransaction: aTransaction) ].
		
		result nextPutAll: 'Balance = ', anAccount balance asString].! !

!AccountSummaryReporter methodsFor: 'reporting' stamp: 'J.S 6/2/2019 20:05:18'!
reportDeposit: aDeposit

	^ 'Deposito por ', aDeposit value asString, '. '.
	! !

!AccountSummaryReporter methodsFor: 'reporting' stamp: 'J.S 6/2/2019 20:05:26'!
reportDepositByTransfer: aDepositByTransfer 

	^ 'Entrada por transferencia de ', aDepositByTransfer value asString, '. '. ! !

!AccountSummaryReporter methodsFor: 'reporting' stamp: 'js 6/2/2019 23:43:08'!
reportPortfolio: aPortfolio

	^ self reportAccount: aPortfolio! !

!AccountSummaryReporter methodsFor: 'reporting' stamp: 'js 6/2/2019 23:43:28'!
reportReceptiveAccount: aReceptiveAccount

	^ self reportAccount: aReceptiveAccount! !

!AccountSummaryReporter methodsFor: 'reporting' stamp: 'J.S 6/2/2019 20:05:35'!
reportWithdraw: aWithdraw 

	^ 'Extraccion por ', aWithdraw value asString, '. '.! !

!AccountSummaryReporter methodsFor: 'reporting' stamp: 'J.S 6/2/2019 20:05:45'!
reportWithdrawByTransfer: aWithdrawByTransfer 
	
	^ 'Salida por transferencia de ', aWithdrawByTransfer value asString, '. '.! !


!classDefinition: #SpecialSummaryReporter category: #'Portfolio-Solucion'!
Reporter subclass: #SpecialSummaryReporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SpecialSummaryReporter methodsFor: 'reporting' stamp: 'js 6/3/2019 00:21:52'!
reportDeposit: aDeposit

	^ 'Deposito por ', aDeposit value asString.
	! !

!SpecialSummaryReporter methodsFor: 'reporting' stamp: 'js 6/3/2019 00:22:03'!
reportDepositByTransfer: aDepositByTransfer 

	^ 'Entrada por transferencia de ', aDepositByTransfer value asString. ! !

!SpecialSummaryReporter methodsFor: 'reporting' stamp: 'js 6/3/2019 00:22:43'!
reportPortfolio: aPortfolio
	
	^self reportPortfolio: aPortfolio withIndentation: 0! !

!SpecialSummaryReporter methodsFor: 'reporting' stamp: 'js 6/3/2019 02:09:44'!
reportPortfolio: aPortfolio withIndentation: aNumberOfIndents
	
	
	| report indentation |
	indentation :=  self generateIndentationWith: aNumberOfIndents.
	report := String streamContents: [:result | 
		result nextPutAll: indentation, aPortfolio name.
		result newLine.
		
		aPortfolio accounts do: [:anAccount | 
			(anAccount class = ReceptiveAccount)
				ifTrue: [result nextPutAll: (self reportReceptiveAccount: anAccount withIndentation:  (aNumberOfIndents + 4))]
				ifFalse: [result nextPutAll: (self reportPortfolio: anAccount withIndentation: (aNumberOfIndents + 4))].
			result newLine.
			].
		
		result nextPutAll: (indentation, '    ','Balance = ', aPortfolio balance asString).
		].
	^report! !

!SpecialSummaryReporter methodsFor: 'reporting' stamp: 'js 6/2/2019 23:49:48'!
reportReceptiveAccount: aReceptiveAccount
	
	^self reportReceptiveAccount: aReceptiveAccount withIndentation: 0! !

!SpecialSummaryReporter methodsFor: 'reporting' stamp: 'js 6/3/2019 00:35:48'!
reportReceptiveAccount: aReceptiveAccount withIndentation: numberOfIndents
	
	| report indentation |
	indentation :=  self generateIndentationWith: numberOfIndents.
	report := String streamContents: [:result | 
		result nextPutAll: indentation, aReceptiveAccount name.
		result newLine.
		
		aReceptiveAccount transactions do: [:aTransaction | 
			result nextPutAll:  (self reportTransaction: aTransaction withIndentation: (numberOfIndents + 4)).
			].
		
		result nextPutAll: (indentation, '    ','Balance = ', aReceptiveAccount balance asString).
		].
	^report! !

!SpecialSummaryReporter methodsFor: 'reporting' stamp: 'js 6/3/2019 00:20:12'!
reportTransaction: aTransaction withIndentation: numberOfIndents
	^(self generateIndentationWith: numberOfIndents) , (self reportTransaction: aTransaction), String newLineString.! !

!SpecialSummaryReporter methodsFor: 'reporting' stamp: 'js 6/3/2019 00:22:10'!
reportWithdraw: aWithdraw 

	^ 'Extraccion por ', aWithdraw value asString.! !

!SpecialSummaryReporter methodsFor: 'reporting' stamp: 'js 6/3/2019 00:22:15'!
reportWithdrawByTransfer: aWithdrawByTransfer 
	
	^ 'Salida por transferencia de ', aWithdrawByTransfer value asString.! !


!classDefinition: #TransferNetReporter category: #'Portfolio-Solucion'!
Reporter subclass: #TransferNetReporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReporter methodsFor: 'reporting' stamp: 'J.S 6/2/2019 22:28:03'!
reportAccount: anAccount

	| valorNeto |
	valorNeto := anAccount transactions sum: [:aTransaction | self reportTransaction: aTransaction] ifEmpty: [0].
	^ 'Valor neto transferencias: ', valorNeto asString, '. '.

	
! !

!TransferNetReporter methodsFor: 'reporting' stamp: 'J.S 6/2/2019 20:36:51'!
reportDeposit: aDeposit

	^ 0.
	! !

!TransferNetReporter methodsFor: 'reporting' stamp: 'J.S 6/2/2019 20:36:34'!
reportDepositByTransfer: aDepositByTransfer 

	^ aDepositByTransfer value.! !

!TransferNetReporter methodsFor: 'reporting' stamp: 'js 6/2/2019 23:44:06'!
reportPortfolio: aPortfolio

	^self reportAccount: aPortfolio 
	
! !

!TransferNetReporter methodsFor: 'reporting' stamp: 'js 6/2/2019 23:43:53'!
reportReceptiveAccount: aReceptiveAccount

	^self reportAccount: aReceptiveAccount 
	
! !

!TransferNetReporter methodsFor: 'reporting' stamp: 'J.S 6/2/2019 20:37:06'!
reportWithdraw: aWithdraw 

	^ 0.! !

!TransferNetReporter methodsFor: 'reporting' stamp: 'J.S 6/2/2019 20:36:08'!
reportWithdrawByTransfer: aWithdrawByTransfer 
	
	^ aWithdrawByTransfer value negated. ! !


!classDefinition: #TreeSummaryReporter category: #'Portfolio-Solucion'!
Reporter subclass: #TreeSummaryReporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TreeSummaryReporter methodsFor: 'reporting' stamp: 'js 6/3/2019 01:51:35'!
reportDeposit: aDeposit

	^ ''! !

!TreeSummaryReporter methodsFor: 'reporting' stamp: 'js 6/3/2019 01:52:07'!
reportDepositByTransfer: aDepositByTransfer

	^ ''! !

!TreeSummaryReporter methodsFor: 'reporting' stamp: 'js 6/3/2019 02:02:44'!
reportPortfolio: aPortfolio
	
	^self reportPortfolio: aPortfolio withIndentation: 0! !

!TreeSummaryReporter methodsFor: 'reporting' stamp: 'js 6/3/2019 02:09:09'!
reportPortfolio: aPortfolio withIndentation: aNumberOfIndents
	
	| report indentation |
	indentation :=  self generateIndentationWith: aNumberOfIndents.
	report := String streamContents: [:result | 
		result nextPutAll: indentation, aPortfolio name.
		
		aPortfolio accounts do: [:anAccount | 
			result newLine.
			(anAccount class = ReceptiveAccount)
				ifTrue: [result nextPutAll: (self reportReceptiveAccount: anAccount withIndentation:  (aNumberOfIndents + 4))]
				ifFalse: [result nextPutAll: (self reportPortfolio: anAccount withIndentation: (aNumberOfIndents + 4))].
			].
		].
	^report! !

!TreeSummaryReporter methodsFor: 'reporting' stamp: 'js 6/3/2019 01:55:14'!
reportReceptiveAccount: aReceptiveAccount
	
	^self reportReceptiveAccount: aReceptiveAccount withIndentation: 0! !

!TreeSummaryReporter methodsFor: 'reporting' stamp: 'js 6/3/2019 01:58:32'!
reportReceptiveAccount: aReceptiveAccount withIndentation: numberOfIndents
	
	| report indentation |
	indentation :=  self generateIndentationWith: numberOfIndents.
	report := String streamContents: [:result | 
		result nextPutAll: indentation, aReceptiveAccount name.
		].
	^report! !

!TreeSummaryReporter methodsFor: 'reporting' stamp: 'js 6/3/2019 01:51:44'!
reportWithdraw: aWithdraw

	^ ''! !

!TreeSummaryReporter methodsFor: 'reporting' stamp: 'js 6/3/2019 01:51:59'!
reportWithdrawByTransfer: aWithdrawByTransfer

	^ ''! !


!classDefinition: #Transfer category: #'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'J.S 6/2/2019 16:00:13'!
initializeFor: aValue

	value := aValue.! !


!Transfer methodsFor: 'accessing' stamp: 'J.S 6/2/2019 16:18:42'!
depositLeg

	^ DepositByTransfer of: self.! !

!Transfer methodsFor: 'accessing' stamp: 'J.S 6/2/2019 16:04:58'!
withdrawLeg

	^ WithdrawByTransfer of: self.! !


!Transfer methodsFor: 'as yet unclassified' stamp: 'J.S 6/2/2019 16:22:36'!
value
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'J.S 6/2/2019 15:20:46'!
for: aValue

	^ self new initializeFor: aValue ! !

!Transfer class methodsFor: 'instance creation' stamp: 'J.S 6/2/2019 17:42:37'!
registerFor: anAmount from: aSourceAccount to: aDestinationAccount
	
	| transfer |
	(aSourceAccount = aDestinationAccount) ifTrue: [self error: Transfer cannotTransferToSameAccountErrorMessage].
	
	transfer := self new initializeFor: anAmount.
	aSourceAccount register: transfer withdrawLeg.
	aDestinationAccount register: transfer depositLeg.
	^transfer! !


!Transfer class methodsFor: 'Errors' stamp: 'J.S 6/2/2019 16:25:47'!
cannotTransferMoreThanWhatYouHave
	^ 'cannot transfer more than what you have'! !


!Transfer class methodsFor: 'error' stamp: 'J.S 6/2/2019 17:43:07'!
cannotTransferToSameAccountErrorMessage

	^ 'Cannot transfer to same account!!'! !
