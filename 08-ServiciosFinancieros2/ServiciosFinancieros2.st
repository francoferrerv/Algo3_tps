!classDefinition: #PortfolioTest category: 'ServiciosFinancieros2'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
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


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros2'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #ReportsTest category: 'ServiciosFinancieros2'!
TestCase subclass: #ReportsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!ReportsTest methodsFor: 'portfolio tree printer tests' stamp: 'jb 7/15/2021 11:36:59'!
test10PortfolioTreePrinterWithOneReceptiveAccountPrintsAccountName
	| johnsAccount |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.

	 self assert: (OrderedCollection with: 'Cuenta de Juan') equals: (PortfolioTreePrinter forAccount: johnsAccount) make! !

!ReportsTest methodsFor: 'portfolio tree printer tests' stamp: 'jb 7/15/2021 11:37:35'!
test11PortfolioTreePrinterWithOneEmptyPortfolioPrintsPortfolioName
	| childrenPortfolio |
	
	childrenPortfolio := Portfolio named: 'Portfolio de hijos'.

	 self assert: (OrderedCollection with: 'Portfolio de hijos') equals: (PortfolioTreePrinter forAccount: childrenPortfolio) make! !

!ReportsTest methodsFor: 'portfolio tree printer tests' stamp: 'jb 7/15/2021 12:22:07'!
test12PortfolioTreePrinterWithPortfolioWithMultipleAccountsAndPortfoliosPrintsTheirNamesProperlyIndented
	| childrenPortfolio angiesAccount expectedAnswer familyPortfolio johnsAccount myAccount |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'. 
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount. 
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	expectedAnswer := OrderedCollection
		with: 'Portfolio de la familia'
		with: String tab, 'Cuenta mia'
		with: String tab, 'Portfolio de hijos'
		with: String tab, String tab, 'Cuenta de Juan'
		with: String tab, String tab, 'Cuenta de Angeles'.
		
	self assert: expectedAnswer equals: (PortfolioTreePrinter forAccount: familyPortfolio) make! !

!ReportsTest methodsFor: 'portfolio tree printer tests' stamp: 'jb 7/15/2021 12:20:34'!
test13PortfolioTreePrinterOfUnnamedReceptiveAccountPrintsDefaultName
	| aReceptiveAccount |
	
	aReceptiveAccount := ReceptiveAccount new.

	 self assert: (OrderedCollection with: 'A ReceptiveAccount') equals: (PortfolioTreePrinter forAccount: aReceptiveAccount) make! !

!ReportsTest methodsFor: 'portfolio tree printer tests' stamp: 'jb 7/15/2021 12:20:24'!
test14PortfolioTreePrinterOfUnnamedPortfolioPrintsDefaultName
	| aPortfolio |
	
	aPortfolio := Portfolio new.

	 self assert: (OrderedCollection with: 'A Portfolio') equals: (PortfolioTreePrinter forAccount: aPortfolio) make! !


!ReportsTest methodsFor: 'transfer net tests' stamp: 'jb 7/15/2021 12:11:36'!
test06TransferNetOfEmptyAccountReturnsZeroBalance

	| account |
	account := ReceptiveAccount new.
	
	self assert: 0 equals: ((TransferNet forAccount: account) make).! !

!ReportsTest methodsFor: 'transfer net tests' stamp: 'jb 7/15/2021 12:13:53'!
test07TransferNetOfAccountWithTransferDepositLegReturnsTransferDepositLegValue

	| account anotherAccount |
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer amount: 50 * peso from: anotherAccount to: account.
	
	self assert: 50 * peso equals: (TransferNet forAccount: account) make.! !

!ReportsTest methodsFor: 'transfer net tests' stamp: 'jb 7/15/2021 12:14:24'!
test08TransferNetOfAccountWithTransferWithdrawLegReturnsTransferWithdrawLegValueNegated

	| account anotherAccount |
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer amount: 50 * peso from: account to: anotherAccount.
	
	self assert: -50 * peso equals: (TransferNet forAccount: account) make.! !

!ReportsTest methodsFor: 'transfer net tests' stamp: 'jb 7/15/2021 12:15:02'!
test09TransferNetOfAccountWithMultipleTransferencesReturnsCorrectValue

	| account anotherAccount |
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer amount: 20 * peso from: account to: anotherAccount.
	Transfer amount: 30 * peso from: anotherAccount to: account.
	
	self assert: 10 * peso equals: (TransferNet forAccount: account) make.! !

!ReportsTest methodsFor: 'transfer net tests' stamp: 'jb 7/15/2021 12:15:26'!
test09bisTransferNetOfAccountWithDepositReturnsZero

	| account |
	account := ReceptiveAccount new.
	
	Deposit register: 10 * peso on: account.
	
	self assert: 0 equals: (TransferNet forAccount: account) make.! !

!ReportsTest methodsFor: 'transfer net tests' stamp: 'jb 7/15/2021 12:15:44'!
test09bisbisTransferNetOfAccountWithWithdrawReturnsZero

	| account |
	account := ReceptiveAccount new.
	
	Withdraw register: 10 * peso on: account.
	
	self assert: 0 equals: (TransferNet forAccount: account) make.! !


!ReportsTest methodsFor: 'account summary tests' stamp: 'jb 7/15/2021 12:06:46'!
test01SummaryOfEmptyAccountReturns0BalanceMessage
	| account |
	
	account := ReceptiveAccount new.
	
	self assert: (OrderedCollection with: 'Balance = 0 pesos') equals: (Summary forAccount: account) make.! !

!ReportsTest methodsFor: 'account summary tests' stamp: 'jb 7/15/2021 12:10:49'!
test02SummaryOfAccountWithDepositReturnsCorrectMessage
	| account expectedAnswer |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	
	expectedAnswer := OrderedCollection
		with: 'Depósito por 100 pesos'
		with: 'Balance = 100 pesos'.
	
	self assert: expectedAnswer equals: (Summary forAccount: account) make.! !

!ReportsTest methodsFor: 'account summary tests' stamp: 'jb 7/15/2021 12:10:03'!
test03SummaryOfAccountWithWithdrawReturnsCorrectMessage
	| account |
	
	account := ReceptiveAccount new.
	Withdraw register: 50 * peso on: account.
	
	self assert: (OrderedCollection with: 'Extracción por 50 pesos' with: 'Balance = -50 pesos') equals: (Summary forAccount: account) make.! !

!ReportsTest methodsFor: 'account summary tests' stamp: 'jb 7/15/2021 12:10:15'!
test04SummaryOfAccountWithTransferWithdrawLegReturnsCorrectMessage
	| account anotherAccount |
	
	account := ReceptiveAccount new.
	
	anotherAccount := ReceptiveAccount new.
	Transfer amount: 20 * peso from: account to: anotherAccount.
	
	self assert: (OrderedCollection with: 'Salida por transferencia de 20 pesos' with: 'Balance = -20 pesos') equals: (Summary forAccount: account) make.! !

!ReportsTest methodsFor: 'account summary tests' stamp: 'jb 7/15/2021 12:10:24'!
test05SummaryOfAccountWithMultipleTransactionsReturnsCorrectMessage
	| account anotherAccount expectedAnswer |
	
	account := ReceptiveAccount new.
	
	anotherAccount := ReceptiveAccount new.
	
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
	Transfer amount: 20 * peso from: account to: anotherAccount.
	Transfer amount: 30 * peso from: anotherAccount to: account.
	
	expectedAnswer := OrderedCollection
		with: 'Depósito por 100 pesos'
		with: 'Extracción por 50 pesos'
		with: 'Salida por transferencia de 20 pesos'
		with: 'Entrada por transferencia de 30 pesos'
		with: 'Balance = 60 pesos'.
	
	self assert: expectedAnswer equals: (Summary forAccount: account) make.! !


!ReportsTest methodsFor: 'portfolio detailed tree printer tests' stamp: 'jb 7/15/2021 11:55:11'!
test15PortfolioDetailedTreePrinterWithOneReceptiveAccountPrintsAccountNameAndZeroBalanceProperly
	| johnsAccount expectedAnswer |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	
	expectedAnswer := OrderedCollection
		with: 'Cuenta de Juan'
		with: String tab, 'Balance = 0 pesos'.

	 self assert: expectedAnswer equals: (PortfolioDetailedTreePrinter forAccount: johnsAccount) make! !

!ReportsTest methodsFor: 'portfolio detailed tree printer tests' stamp: 'jb 7/15/2021 12:00:55'!
test16PortfolioDetailedTreePrinterWithOneEmptyPortfolioPrintsPortfolioNameAndZeroBalanceProperly
	| childrenPortfolio expectedAnswer |
	
	childrenPortfolio := Portfolio named: 'Portfolio de hijos'.
	
	expectedAnswer := OrderedCollection
		with: 'Portfolio de hijos'
		with: String tab, 'Balance = 0 pesos'.

	 self assert: expectedAnswer equals: (PortfolioDetailedTreePrinter forAccount: childrenPortfolio) make! !

!ReportsTest methodsFor: 'portfolio detailed tree printer tests' stamp: 'jb 7/15/2021 12:21:57'!
test17PortfolioDetailedTreePrinterWithPortfolioWithMultipleAccountsAndPortfoliosPrintsTheirNamesProperlyIndented
	| childrenPortfolio angiesAccount expectedAnswer familyPortfolio johnsAccount myAccount |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'. 
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount. 
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	Deposit register: 100 * peso on: myAccount.
	Withdraw register: 50 * peso on: myAccount.
	
	Deposit register: 150 * peso on: johnsAccount.
	
	Transfer amount: 75 * peso from: angiesAccount to: johnsAccount.
	
	expectedAnswer := OrderedCollection new.
	expectedAnswer add: 'Portfolio de la familia'.
	expectedAnswer add: String tab, 'Cuenta mia'.
	expectedAnswer add: String tab, String tab, 'Depósito por 100 pesos'.
	expectedAnswer add: String tab, String tab, 'Extracción por 50 pesos'.
	expectedAnswer add: String tab, String tab, 'Balance = 50 pesos'.
	expectedAnswer add: String tab, 'Portfolio de hijos'.
	expectedAnswer add: String tab, String tab, 'Cuenta de Juan'.
	expectedAnswer add: String tab, String tab, String tab, 'Depósito por 150 pesos'.
	expectedAnswer add: String tab, String tab, String tab, 'Entrada por transferencia de 75 pesos'.
	expectedAnswer add: String tab, String tab, String tab, 'Balance = 225 pesos'.
	expectedAnswer add: String tab, String tab, 'Cuenta de Angeles'.
	expectedAnswer add: String tab, String tab, String tab, 'Salida por transferencia de 75 pesos'.
	expectedAnswer add: String tab, String tab, String tab, 'Balance = -75 pesos'.
	expectedAnswer add: String tab, String tab, 'Balance = 150 pesos'.
	expectedAnswer add: String tab, 'Balance = 200 pesos'.
	
	
		
	self assert: expectedAnswer equals: (PortfolioDetailedTreePrinter forAccount: familyPortfolio) make! !

!ReportsTest methodsFor: 'portfolio detailed tree printer tests' stamp: 'jb 7/15/2021 12:21:09'!
test18PortfolioDetailedTreePrinterOfUnnamedReceptiveAccountPrintsDefaultNameAndEmptyBalance
	| aReceptiveAccount expectedAnswer |
	
	aReceptiveAccount := ReceptiveAccount new.
	
	expectedAnswer := OrderedCollection
		with: 'A ReceptiveAccount'
		with: String tab, 'Balance = 0 pesos'.

	 self assert: expectedAnswer equals: (PortfolioDetailedTreePrinter forAccount: aReceptiveAccount) make! !

!ReportsTest methodsFor: 'portfolio detailed tree printer tests' stamp: 'jb 7/15/2021 12:22:41'!
test19PortfolioDetailedTreePrinterOfUnnamedPortfolioPrintsDefaultNameAndEmptyBalance
	| aPortfolio expectedAnswer |
	
	aPortfolio := Portfolio new.
	
	expectedAnswer := OrderedCollection
		with: 'A Portfolio'
		with: String tab, 'Balance = 0 pesos'.

	 self assert: expectedAnswer equals: (PortfolioDetailedTreePrinter forAccount: aPortfolio) make! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros2'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros2'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'private' stamp: 'jb 7/14/2021 14:27:06'!
computePartForReport: aReport
	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros2'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Portfolio methodsFor: 'initialization' stamp: 'jb 7/13/2021 12:33:03'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := 'A Portfolio'! !

!Portfolio methodsFor: 'initialization' stamp: 'jb 7/13/2021 12:33:13'!
initializedWithName: aName

	self initialize.
	name := aName! !


!Portfolio methodsFor: 'main protocol' stamp: 'jb 7/10/2021 14:47:24'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 * peso ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'jb 7/13/2021 12:34:13'!
name
	^name! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'jb 7/13/2021 12:52:47'!
accounts
	^accounts! !

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


!Portfolio methodsFor: 'reports' stamp: 'jb 7/14/2021 14:27:31'!
computePartForReport: aReport
	^aReport computePortfolioPart: self.! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros2'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'jb 7/13/2021 12:31:25'!
named: aName
	^self new initializedWithName: aName! !

!Portfolio class methodsFor: 'instance creation' stamp: 'jb 7/13/2021 12:40:48'!
named: aName with: anAccount with: anotherAccount

	^self new initializedWithName: aName;
		add: anAccount;
		add: anotherAccount! !

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


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros2'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'jb 7/13/2021 12:20:45'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	name := 'A ReceptiveAccount'! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'jb 7/13/2021 12:19:26'!
initializeWithName: aName

	self initialize.
	name := aName! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'jb 7/10/2021 14:47:13'!
balance

	^transactions 
		inject: 0 * peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'jb 7/13/2021 12:34:20'!
name
	^name! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'jb 7/14/2021 14:27:42'!
computePartForReport: aReport
	^aReport computeReceptiveAccountPart: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros2'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'jb 7/13/2021 12:19:05'!
named: aName

	^self new initializeWithName: aName! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros2'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!classDefinition: #Deposit category: 'ServiciosFinancieros2'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reports' stamp: 'jb 7/12/2021 21:24:21'!
computePartForReport: aReport

	^aReport computeDepositPart: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros2'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros2'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !


!TransferLeg methodsFor: 'reports' stamp: 'jb 7/12/2021 21:24:45'!
computePartForReport: aReport

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros2'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros2'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'reports' stamp: 'jb 7/12/2021 21:25:01'!
computePartForReport: aReport

	^aReport computeTransferDepositPart: self! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros2'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdrawLeg methodsFor: 'reports' stamp: 'jb 7/12/2021 21:25:14'!
computePartForReport: aReport

	^aReport computeTransferWithdrawPart: self! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros2'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reports' stamp: 'jb 7/12/2021 21:25:24'!
computePartForReport: aReport

	^aReport computeWithdrawPart: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros2'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Report category: 'ServiciosFinancieros2'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Report methodsFor: 'main protocol' stamp: 'jb 7/13/2021 12:11:09'!
make
	self subclassResponsibility! !


!Report methodsFor: 'compute account part' stamp: 'jb 7/15/2021 11:32:04'!
computePortfolioPart: aPortfolio
	self subclassResponsibility ! !

!Report methodsFor: 'compute account part' stamp: 'jb 7/15/2021 11:32:29'!
computeReceptiveAccountPart: aReceptiveAccount
	self subclassResponsibility! !


!Report methodsFor: 'compute transaction part' stamp: 'jb 7/15/2021 11:33:09'!
computeDepositPart: aDeposit
	self subclassResponsibility ! !

!Report methodsFor: 'compute transaction part' stamp: 'jb 7/15/2021 11:33:16'!
computeTransferDepositPart: aTransferDeposit
	self subclassResponsibility ! !

!Report methodsFor: 'compute transaction part' stamp: 'jb 7/15/2021 11:33:20'!
computeTransferWithdrawPart: aTransferWithdraw
	self subclassResponsibility ! !

!Report methodsFor: 'compute transaction part' stamp: 'jb 7/15/2021 11:33:24'!
computeWithdrawPart: aWithdraw
	self subclassResponsibility ! !


!Report methodsFor: 'initialization' stamp: 'jb 7/13/2021 12:25:44'!
initializeWithAccount: anAccount
	account := anAccount! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'ServiciosFinancieros2'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'jb 7/13/2021 12:25:14'!
forAccount: anAccount
	^self new initializeWithAccount: anAccount! !


!classDefinition: #PortfolioTreeStyledReports category: 'ServiciosFinancieros2'!
Report subclass: #PortfolioTreeStyledReports
	instanceVariableNames: 'depth'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!PortfolioTreeStyledReports methodsFor: 'private' stamp: 'jb 7/15/2021 11:11:55'!
addAccountChildrensToReport: aReport

	account accounts do: [:anAccount | aReport addAll: (self class forAccount: anAccount withDepth: depth + 1) make		].! !

!PortfolioTreeStyledReports methodsFor: 'private' stamp: 'jb 7/15/2021 11:11:19'!
addItselfToReport: aReport
	
	aReport add: (self string: (account name) withDepth: depth).! !

!PortfolioTreeStyledReports methodsFor: 'private' stamp: 'jb 7/15/2021 11:09:31'!
string: aString withDepth: aDepth
	| output |
	
	output := aString.
	
	(1 to: aDepth) do: [:idx | output := String tab, output].
	
	^output! !


!classDefinition: #PortfolioDetailedTreePrinter category: 'ServiciosFinancieros2'!
PortfolioTreeStyledReports subclass: #PortfolioDetailedTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!PortfolioDetailedTreePrinter methodsFor: 'compute accounts part' stamp: 'jb 7/15/2021 11:18:09'!
computePortfolioPart: aPortfolio
	| report |
		
	report := OrderedCollection new.
	
	self addItselfToReport: report.
	self addAccountChildrensToReport: report.
	self addBalanceToReport: report.
	
	^report! !

!PortfolioDetailedTreePrinter methodsFor: 'compute accounts part' stamp: 'jb 7/15/2021 11:16:21'!
computeReceptiveAccountPart: aReceptiveAccount
	| report |
		
	report := OrderedCollection new.
	
	self addItselfToReport: report.
	self addSummaryToReport: report.
	
	^report! !


!PortfolioDetailedTreePrinter methodsFor: 'initialization' stamp: 'jb 7/15/2021 11:18:25'!
initializeWithAccount: anAccount
	account := anAccount.
	depth := 0.! !

!PortfolioDetailedTreePrinter methodsFor: 'initialization' stamp: 'jb 7/15/2021 11:18:35'!
initializeWithAccount: anAccount withDepth: aDepth
	account := anAccount.
	depth := aDepth.! !


!PortfolioDetailedTreePrinter methodsFor: 'private' stamp: 'jb 7/15/2021 12:04:10'!
addBalanceToReport: aReport
	| balance |
	
	balance := 'Balance = ', ((account balance) asString).
	
	aReport add: (self string: balance withDepth: (depth + 1)).! !

!PortfolioDetailedTreePrinter methodsFor: 'private' stamp: 'jb 7/15/2021 11:16:06'!
addSummaryToReport: aReport
	
	| summary |
	summary := (Summary forAccount: account) make.
	summary := summary collect: [:line | self string: line withDepth: depth + 1].
	
	aReport addAll: summary.! !


!PortfolioDetailedTreePrinter methodsFor: 'main protocol' stamp: 'jb 7/15/2021 11:14:32'!
make
	
	^account computePartForReport: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioDetailedTreePrinter class' category: 'ServiciosFinancieros2'!
PortfolioDetailedTreePrinter class
	instanceVariableNames: ''!

!PortfolioDetailedTreePrinter class methodsFor: 'instance creation' stamp: 'jb 7/15/2021 11:19:18'!
forAccount: anAccount withDepth: aDepth
	^self new initializeWithAccount: anAccount withDepth: aDepth! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros2'!
PortfolioTreeStyledReports subclass: #PortfolioTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!PortfolioTreePrinter methodsFor: 'main protocol' stamp: 'jb 7/14/2021 14:26:35'!
make
	
	^account computePartForReport: self.! !


!PortfolioTreePrinter methodsFor: 'initialization' stamp: 'jb 7/14/2021 14:25:33'!
initializeWithAccount: anAccount
	account := anAccount.
	depth := 0.! !

!PortfolioTreePrinter methodsFor: 'initialization' stamp: 'jb 7/14/2021 14:24:19'!
initializeWithAccount: anAccount withDepth: aDepth
	account := anAccount.
	depth := aDepth.! !


!PortfolioTreePrinter methodsFor: 'compute accounts part' stamp: 'jb 7/15/2021 11:13:06'!
computePortfolioPart: aPortfolio
	| report |
	
	report := OrderedCollection new.
	
	self addItselfToReport: report.
	self addAccountChildrensToReport: report.

	^report! !

!PortfolioTreePrinter methodsFor: 'compute accounts part' stamp: 'jb 7/15/2021 11:13:22'!
computeReceptiveAccountPart: aReceptiveAccount
	| report |
	
	report := OrderedCollection new.
	
	self addItselfToReport: report.
	
	^report! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinter class' category: 'ServiciosFinancieros2'!
PortfolioTreePrinter class
	instanceVariableNames: ''!

!PortfolioTreePrinter class methodsFor: 'instance creation' stamp: 'jb 7/14/2021 14:24:30'!
forAccount: anAccount withDepth: aDepth
	^self new initializeWithAccount: anAccount withDepth: aDepth! !


!classDefinition: #Summary category: 'ServiciosFinancieros2'!
Report subclass: #Summary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Summary methodsFor: 'compute transaction part' stamp: 'jb 7/12/2021 21:27:41'!
computeDepositPart: aDeposit

	^ 'Depósito por ', (aDeposit value) asString.! !

!Summary methodsFor: 'compute transaction part' stamp: 'jb 7/12/2021 21:32:53'!
computeTransferDepositPart: aTransferDeposit

	^ 'Entrada por transferencia de ', (aTransferDeposit value) asString! !

!Summary methodsFor: 'compute transaction part' stamp: 'jb 7/12/2021 21:33:08'!
computeTransferWithdrawPart: aTransferWithdraw
	
	^ 'Salida por transferencia de ', (aTransferWithdraw value) asString! !

!Summary methodsFor: 'compute transaction part' stamp: 'jb 7/12/2021 21:32:24'!
computeWithdrawPart: aWithdraw
	
	^ 'Extracción por ', (aWithdraw value) asString.! !


!Summary methodsFor: 'main protocol' stamp: 'jb 7/12/2021 21:23:47'!
make
	| report |
	
	report := OrderedCollection new.
	account transactions do: [:transaction | 		report add: (transaction computePartForReport: self)].
	
	report add: 'Balance = ', ((account balance) asString).
	^report! !


!classDefinition: #TransferNet category: 'ServiciosFinancieros2'!
Report subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!TransferNet methodsFor: 'transaction messages' stamp: 'jb 7/12/2021 21:30:54'!
computeDepositPart: aDeposit

	^0! !

!TransferNet methodsFor: 'transaction messages' stamp: 'jb 7/12/2021 21:36:45'!
computeTransferDepositPart: aTransferDeposit

	^aTransferDeposit value! !

!TransferNet methodsFor: 'transaction messages' stamp: 'jb 7/12/2021 21:36:12'!
computeTransferWithdrawPart: aTransferWithdraw

	^ (aTransferWithdraw value) negated! !

!TransferNet methodsFor: 'transaction messages' stamp: 'jb 7/12/2021 21:30:47'!
computeWithdrawPart: aWithdraw

	^0! !


!TransferNet methodsFor: 'main protocol' stamp: 'jb 7/12/2021 21:35:33'!
make
	| transactions |

	transactions := account transactions.
	
	^transactions inject: 0 into: [:transferNet :transaction | transferNet + (transaction computePartForReport: self)]! !


!classDefinition: #Transfer category: 'ServiciosFinancieros2'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros2'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
