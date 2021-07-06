!classDefinition: #PortfolioTests category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'FVF 7/6/2021 12:04:36'!
test01EmptyPortfolioHasBalanceZero

	| portfolio |
	portfolio := Portfolio new.
	
	self assert: 0 * peso equals: portfolio balance.
	
	! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'FVF 7/6/2021 12:05:46'!
test02PortfolioWithOnlyOneAccountBalanceEqualsAccountBalance

	| portfolio account |
	account := ReceptiveAccount new.
	Deposit register: 50 * peso  on: account.
	portfolio := Portfolio new.
	portfolio addAccount: account.
	
	self assert: 50 * peso equals: portfolio balance .
	
	! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'FVF 7/6/2021 12:07:09'!
test03PortfolioWithMultipleAccountsBalanceEqualsSumOfAccountsBalance

	| portfolio account1 account2 |
	account1 := ReceptiveAccount new.
	Deposit register: 100 * peso  on: account1.
	account2 := ReceptiveAccount new.
	Deposit register: 200 * peso  on: account2.
	portfolio := Portfolio new.
	portfolio addAccount: account1.
	portfolio addAccount: account2.
	
	self assert: 300 * peso equals: portfolio balance.
	
	! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'FVF 7/6/2021 12:14:50'!
test04PortfolioCanFindTransactionsInAccount

	| portfolio account1 account2 deposit1 deposit2 withdraw |
	account1 := ReceptiveAccount new.
	 deposit1 := Deposit register: 100 * peso  on: account1.
	account2 := ReceptiveAccount new.
	deposit2 :=Deposit register: 200 * peso  on: account2.
	withdraw := Withdraw register: 200 * peso  on: account2.
	portfolio := Portfolio new.
	portfolio addAccount: account1.
	portfolio addAccount: account2.
	
	self assert:  (portfolio hasRegistered: deposit1).
	self assert:  (portfolio hasRegistered: deposit2).
	self assert:  (portfolio hasRegistered: withdraw).
	
	! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'FVF 7/6/2021 12:12:32'!
test05PortfolioCantFindTransactionThatIsntInAccount

	| portfolio account1 account2 deposit1 deposit2 withdraw |
	account1 := ReceptiveAccount new.
	 deposit1 := Deposit register: 100 * peso  on: account1.
	account2 := ReceptiveAccount new.
	deposit2 :=Deposit register: 200 * peso  on: account2.
	withdraw := Withdraw register: 200 * peso  on: account2.
	portfolio := Portfolio new.

	portfolio addAccount: account2.
	
	self deny: (portfolio hasRegistered: deposit1).
	self assert:  (portfolio hasRegistered: deposit2).
	self assert:  (portfolio hasRegistered: withdraw).
	
	! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'FVF 7/6/2021 12:16:08'!
test06PortfolioWithOneAccountTransactionsEqualsAccountTransactions

	| portfolio account1 deposit1 |
	account1 := ReceptiveAccount new.
	 deposit1 := Deposit register: 100 * peso  on: account1.
	portfolio := Portfolio new.
	portfolio addAccount: account1.
	
	
	self assert: (OrderedCollection with: deposit1) equals: (portfolio transactions).

	
	! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'FVF 7/6/2021 12:17:13'!
test07PortfolioWithManyAccountsTransactionsEqualsConcatenationOfAccountsTransactions

	| portfolio account1 account2 deposit1 deposit2 withdraw |
	account1 := ReceptiveAccount new.
	 deposit1 := Deposit register: 100 * peso  on: account1.
	account2 := ReceptiveAccount new.
	deposit2 :=Deposit register: 200 * peso  on: account2.
	withdraw := Withdraw register: 200 * peso  on: account2.
	portfolio := Portfolio new.
	portfolio addAccount: account1.
	portfolio addAccount: account2.
	
	self assert: (OrderedCollection with: deposit1 with: deposit2 with: withdraw) equals: (portfolio transactions).
	

	
	! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'FVF 7/6/2021 12:18:04'!
test08PortfolioCanContainAnotherPortfolio

	| portfolio1 portfolio2 account1 account2 deposit1 deposit2 withdraw |
	
	account1 := ReceptiveAccount new.
	 deposit1 := Deposit register: 100 * peso  on: account1.
	
	account2 := ReceptiveAccount new.
	deposit2 :=Deposit register: 200 * peso  on: account2.
	withdraw := Withdraw register: 200 * peso  on: account2.
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new. 
	
	portfolio1 addAccount: account1.
	portfolio1 addAccount: account2.
	portfolio2 addAccount: portfolio1.
	
	
	self assert: (OrderedCollection with: deposit1 with: deposit2 with: withdraw) equals: (portfolio2 transactions).
	

	
	! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

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


!classDefinition: #TransferTests category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTests methodsFor: 'as yet unclassified' stamp: 'FVF 7/6/2021 11:59:24'!
test01CanTransferMoneyBetweenTwoAccounts

	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 50 * peso on: account1.
	Transfer register: 50 * peso from: account1 to: account2.
	
	self assert: 0 * peso equals: (account1 balance).
	self assert: 50 * peso equals: (account2 balance). 
	 

	
! !

!TransferTests methodsFor: 'as yet unclassified' stamp: 'FVF 7/6/2021 11:59:48'!
test02TransferValueCanBeKnown

	| account1 account2 transfer|
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 50 * peso on: account1.
	transfer := Transfer register: 50 * peso from: account1 to: account2.
	
	self assert: 50 * peso equals: transfer value.
	
	 

	
! !

!TransferTests methodsFor: 'as yet unclassified' stamp: 'FVF 7/6/2021 12:00:50'!
test03TransferPartCanKnowCounterpart

	| account1 account2 transfer|
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 50 * peso on: account1.
	transfer := Transfer register: 50 * peso from: account1 to: account2.
	
	self assert: transfer deposit equals: ((account1 transactions at: 2) counterpart).
	self assert: transfer withdraw equals: ((account2 transactions at: 1) counterpart). 
	 

	
! !

!TransferTests methodsFor: 'as yet unclassified' stamp: 'FVF 7/6/2021 12:03:22'!
test04CantTransferZeroMoney

	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	self should: [Transfer register: (0 * peso) from: account1 to: account2.]
	 raise: Error
	withExceptionDo: [:exception| 
		self assert:  (Transfer cantTransferZeroMoneyErrorMessage) equals: exception messageText.
		self assert: (0 * peso) equals: (account1 balance).
		self assert: (0 * peso) equals: (account2 balance).
		self assert: OrderedCollection new equals: account1 transactions.
		self assert: OrderedCollection new equals: account2 transactions]. 
	
	


	! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'FV 7/2/2021 15:26:03'!
transactionBalance

	^self subclassResponsibility
! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'jb 7/6/2021 10:54:50'!
valueForBalance: aPartialBalance

	^self subclassResponsibility
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 15:26:32'!
transactionBalance

	^self value! !

!Deposit methodsFor: 'as yet unclassified' stamp: 'jb 7/6/2021 10:55:18'!
valueForBalance: aPartialBalance

	^aPartialBalance + self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'FV 7/2/2021 15:18:06'!
value

	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 15:26:42'!
transactionBalance

	^self value * -1! !

!Withdraw methodsFor: 'as yet unclassified' stamp: 'jb 7/6/2021 10:55:42'!
valueForBalance: aPartialBalance

	^aPartialBalance - self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'FVF 7/5/2021 21:06:53'!
addAccount: anAccount

	accounts add: anAccount.

	

	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'FVF 7/5/2021 21:15:01'!
balance
	
	accounts ifEmpty:[^0* peso].
	
	^accounts sum:[:account| account balance].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'FVF 7/5/2021 21:28:31'!
hasRegistered: aTransaction

	accounts do:[:account| (account hasRegistered: aTransaction) ifTrue: [^true]].
	^false.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'FVF 7/5/2021 21:06:10'!
initialize

	accounts := OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'FVF 7/6/2021 11:22:12'!
transactions

	"^(accounts at: 1) transactions."
	
	^accounts inject: (OrderedCollection new) into: [:acumulator :account| acumulator, account transactions].! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'jb 7/6/2021 10:59:19'!
balance

	^transactions inject: 0 * peso into: [:partialBalance :aTransaction | aTransaction valueForBalance: partialBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdraw deposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'jb 7/5/2021 20:27:57'!
deposit

	^deposit! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'jb 7/5/2021 20:27:31'!
initializeFor: anAmount from: anAccount1 to: anAccount2

	value := anAmount.

	withdraw := TransferWithdraw register: anAmount on: anAccount1 withTransfer: self.
	deposit := TransferDeposit register: anAmount on: anAccount2 withTransfer: self.
	^self! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 16:46:03'!
value

	^value.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'jb 7/5/2021 20:28:03'!
withdraw

	^withdraw! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'FVF 7/6/2021 11:38:34'!
cantTransferZeroMoneyErrorMessage

	^'Cant transfer zero money'.! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'FVF 7/6/2021 11:51:28'!
register: anAmount from: anAccount1 to: anAccount2

	| transfer |
	(anAmount = (0 * peso)) ifTrue: [^self error: self cantTransferZeroMoneyErrorMessage].
	transfer := self new initializeFor: anAmount from: anAccount1 to: anAccount2.
	
	^transfer

! !


!classDefinition: #TransferPart category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #TransferPart
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferPart methodsFor: 'as yet unclassified' stamp: 'jb 7/5/2021 20:19:08'!
value
	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferPart class' category: 'ServiciosFinancieros-Ejercicio'!
TransferPart class
	instanceVariableNames: ''!

!TransferPart class methodsFor: 'as yet unclassified' stamp: 'jb 7/5/2021 20:21:32'!
register: aValue on: account withTransfer: aTransfer

	| transaction |
	
	transaction := self for: aValue withTransfer: aTransfer. 
	account register: transaction.
		
	^transaction! !


!classDefinition: #TransferDeposit category: 'ServiciosFinancieros-Ejercicio'!
TransferPart subclass: #TransferDeposit
	instanceVariableNames: 'transfer value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 21:38:53'!
counterpart
	
	^transfer withdraw.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 21:41:45'!
initializeFor: anAmount withTransfer: aTransfer

	value := anAmount.
	transfer := aTransfer.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 20:15:34'!
transactionBalance

	^self value! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 21:35:02'!
transfer

	^transfer.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'jb 7/5/2021 20:30:02'!
value
	^value! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'jb 7/6/2021 10:59:42'!
valueForBalance: aPartialBalance

	^aPartialBalance + self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: 'ServiciosFinancieros-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 21:43:04'!
for: anAmount withTransfer: aTransfer

	^self new initializeFor: anAmount withTransfer: aTransfer.! !


!classDefinition: #TransferWithdraw category: 'ServiciosFinancieros-Ejercicio'!
TransferPart subclass: #TransferWithdraw
	instanceVariableNames: 'transfer value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 21:39:04'!
counterpart
	
	^transfer deposit.! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 21:42:04'!
initializeFor: anAmount withTransfer: aTransfer

	value := anAmount.
	transfer := aTransfer.! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 20:15:42'!
transactionBalance

	^self value * -1! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 21:35:11'!
transfer

	^transfer.! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'jb 7/5/2021 20:30:10'!
value
	^value! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'jb 7/6/2021 11:00:05'!
valueForBalance: aPartialBalance

	^aPartialBalance - self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: 'ServiciosFinancieros-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 21:43:22'!
for: anAmount withTransfer: aTransfer

	^self new initializeFor: anAmount withTransfer: aTransfer.! !
