!classDefinition: #PortfolioTests category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTests methodsFor: 'tests' stamp: 'FVF 7/6/2021 12:04:36'!
test01EmptyPortfolioHasBalanceZero

	| portfolio |
	portfolio := Portfolio new.
	
	self assert: 0 * peso equals: portfolio balance.
	
	! !

!PortfolioTests methodsFor: 'tests' stamp: 'FVF 7/6/2021 12:05:46'!
test02PortfolioWithOnlyOneAccountBalanceEqualsAccountBalance

	| portfolio account |
	account := ReceptiveAccount new.
	Deposit register: 50 * peso  on: account.
	portfolio := Portfolio new.
	portfolio addAccount: account.
	
	self assert: 50 * peso equals: portfolio balance .
	
	! !

!PortfolioTests methodsFor: 'tests' stamp: 'FVF 7/6/2021 12:07:09'!
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

!PortfolioTests methodsFor: 'tests' stamp: 'FVF 7/6/2021 12:14:50'!
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

!PortfolioTests methodsFor: 'tests' stamp: 'FVF 7/6/2021 12:12:32'!
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

!PortfolioTests methodsFor: 'tests' stamp: 'FVF 7/6/2021 12:16:08'!
test06PortfolioWithOneAccountTransactionsEqualsAccountTransactions

	| portfolio account1 deposit1 |
	account1 := ReceptiveAccount new.
	 deposit1 := Deposit register: 100 * peso  on: account1.
	portfolio := Portfolio new.
	portfolio addAccount: account1.
	
	
	self assert: (OrderedCollection with: deposit1) equals: (portfolio transactions).

	
	! !

!PortfolioTests methodsFor: 'tests' stamp: 'FVF 7/6/2021 12:17:13'!
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

!PortfolioTests methodsFor: 'tests' stamp: 'FVF 7/6/2021 12:18:04'!
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

!ReceptiveAccountTest methodsFor: 'helpers' stamp: 'jb 7/8/2021 17:13:49'!
assertAccount: anAccount hasBalance: aBalance
	
	self assert: aBalance equals: anAccount balance! !


!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jb 7/8/2021 17:14:15'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assertAccount: account hasBalance: 0.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jb 7/8/2021 17:14:38'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	
	self assertAccount: account hasBalance: 100 * peso.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jb 7/8/2021 17:14:56'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
	
	self assertAccount: account hasBalance: 50 * peso.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jb 7/8/2021 17:15:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue withdraw |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	withdraw := Withdraw register: withdrawValue on: account.
	
	self assert: withdrawValue equals: withdraw value
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jb 7/8/2021 17:18:49'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account anotherAccount deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
	
	anotherAccount := ReceptiveAccount new.
		
	self deny: (anotherAccount hasRegistered: deposit).
	self deny: (anotherAccount hasRegistered: withdraw).
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
	instanceVariableNames: 'receptiveAccountWith50Pesos emptyReceptiveAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTests methodsFor: 'helpers' stamp: 'jb 7/8/2021 17:04:03'!
assertAccountHasNoTransactions: anAccount

	self assert: (0 * peso) equals: (anAccount balance).
	self assert: OrderedCollection new equals: anAccount transactions.! !


!TransferTests methodsFor: 'tests' stamp: 'jb 7/8/2021 17:08:47'!
test01CanTransferMoneyBetweenTwoAccounts

	| account1 account2 |
	account1 := receptiveAccountWith50Pesos.
	account2 := emptyReceptiveAccount.
	
	Transfer register: 50 * peso from: account1 to: account2.
	
	self assert: 0 * peso equals: (account1 balance).
	self assert: 50 * peso equals: (account2 balance). 
	 

	
! !

!TransferTests methodsFor: 'tests' stamp: 'jb 7/8/2021 17:20:50'!
test02TransferValueCanBeKnown

	| account1 account2 transfer |
	account1 := receptiveAccountWith50Pesos.
	account2 := ReceptiveAccount new.
	
	transfer := Transfer register: 50 * peso from: account1 to: account2.
	
	self assert: 50 * peso equals: transfer value.
	
	 

	
! !

!TransferTests methodsFor: 'tests' stamp: 'jb 7/8/2021 17:10:17'!
test03TransferPartCanKnowCounterpart

	| account1 account2 transfer |
	account1 := receptiveAccountWith50Pesos.
	account2 := ReceptiveAccount new.
	
	transfer := Transfer register: 50 * peso from: account1 to: account2.
	
	self assert: transfer deposit equals: ((account1 transactions at: 2) counterpart).
	self assert: transfer withdraw equals: ((account2 transactions at: 1) counterpart). 
	 

	
! !

!TransferTests methodsFor: 'tests' stamp: 'jb 7/8/2021 17:06:12'!
test04CantTransferZeroMoney

	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	self should: [Transfer register: (0 * peso) from: account1 to: account2.]
		raise: Error
		withExceptionDo: [:exception| 
			self assert:  (Transfer cantTransferZeroMoneyErrorMessage) equals: exception messageText.
			
			self assertAccountHasNoTransactions: account1.
			self assertAccountHasNoTransactions: account2.].
	


	! !


!TransferTests methodsFor: 'setUp/tearDown' stamp: 'jb 7/8/2021 17:08:31'!
setUp
	
	receptiveAccountWith50Pesos := ReceptiveAccount new.
	Deposit register: 50 * peso on: receptiveAccountWith50Pesos.
	
	emptyReceptiveAccount := ReceptiveAccount new.
	
	! !


!classDefinition: #ValidPortfolioTests category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ValidPortfolioTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ValidPortfolioTests methodsFor: 'tests' stamp: 'jb 7/8/2021 17:11:50'!
test01PortfolioCantAddItself

	| portfolio |
	
	portfolio := Portfolio new.
	
	self should: [portfolio addAccount: portfolio.]
		raise: Error
		withExceptionDo: [:exception | exception messageText = Portfolio invalidAccountAddErrorMessage]! !

!ValidPortfolioTests methodsFor: 'tests' stamp: 'jb 7/8/2021 17:20:11'!
test02PortfolioCantAddAnAccountAlreadyAdded

	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio addAccount: account.
	
	self should: [portfolio addAccount:  account.]
		raise: Error
		withExceptionDo: [:exception | exception messageText = Portfolio invalidAccountAddErrorMessage]! !

!ValidPortfolioTests methodsFor: 'tests' stamp: 'jb 7/8/2021 17:20:16'!
test03PortfolioCantAddAnAccountAlreadyIncludedInAPreviouslyIncludedPortfolio

	| portfolio1 portfolio2 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	portfolio1 addAccount: account.
	portfolio2 addAccount: portfolio1.
	
	self should: [portfolio2 addAccount: account.]
	raise: Error
	withExceptionDo: [:exception | exception messageText = Portfolio invalidAccountAddErrorMessage]! !

!ValidPortfolioTests methodsFor: 'tests' stamp: 'jb 7/8/2021 17:20:21'!
test04CantAddAPortfolioIncludingAnAccountToAnotherPortfolioIncludingTheSameAccount

	| portfolio1 portfolio2 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	portfolio1 addAccount: account.
	portfolio2 addAccount: account.
	
	self should: [portfolio1 addAccount: portfolio2]
	raise: Error
	withExceptionDo: [:exception | exception messageText = Portfolio invalidAccountAddErrorMessage]! !

!ValidPortfolioTests methodsFor: 'tests' stamp: 'jb 7/8/2021 17:20:00'!
test05PortfolioCantAddAnAccountThatAFatherPortfolioAlreadyHas

	| portfolio1 portfolio2 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	portfolio1 addAccount: account.
	portfolio1 addAccount: portfolio2.
	
	self should: [portfolio2 addAccount: account.]
	raise: Error
	withExceptionDo: [:exception | exception messageText = Portfolio invalidAccountAddErrorMessage]! !


!classDefinition: #AccountContainableInPortfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountContainableInPortfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountContainableInPortfolio methodsFor: 'validation' stamp: 'FVF 7/8/2021 12:36:03'!
validateAgainstPortfolio: aPortfolio

	self subclassResponsibility.! !

!AccountContainableInPortfolio methodsFor: 'validation' stamp: 'FVF 7/8/2021 12:35:46'!
validateAgainstReceptiveAccount: aReceptiveAccount

	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
AccountContainableInPortfolio subclass: #Portfolio
	instanceVariableNames: 'accounts containingPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'FVF 7/7/2021 12:54:36'!
initialize

	accounts := OrderedCollection new.
	containingPortfolio := nil.! !


!Portfolio methodsFor: 'operations' stamp: 'FVF 7/8/2021 13:07:13'!
addAccount: anAccount
	
	self accountCanBeAdded: anAccount.
	
	(anAccount isKindOf: Portfolio) ifTrue: [anAccount setContainingPortfolio: self].
	accounts add: anAccount.
	

	

	! !

!Portfolio methodsFor: 'operations' stamp: 'FVF 7/7/2021 12:44:22'!
setContainingPortfolio: aPortfolio

	containingPortfolio := aPortfolio.! !


!Portfolio methodsFor: 'accesing' stamp: 'jb 7/8/2021 16:59:36'!
balance
	
	accounts ifEmpty: [^0* peso].
	
	^accounts sum: [:account | account balance].! !

!Portfolio methodsFor: 'accesing' stamp: 'jb 7/8/2021 17:22:35'!
hasRegistered: aTransaction
	
	^accounts anySatisfy: [:account | account hasRegistered: aTransaction].! !

!Portfolio methodsFor: 'accesing' stamp: 'jb 7/8/2021 16:59:54'!
transactions
	
	^accounts inject: (OrderedCollection new) into: [:acumulator :account | acumulator, account transactions].! !


!Portfolio methodsFor: 'private' stamp: 'FVF 7/7/2021 12:51:31'!
topMostPortfolio

	(containingPortfolio = nil) ifTrue: [^self].
	^containingPortfolio topMostPortfolio.! !


!Portfolio methodsFor: 'validation' stamp: 'jb 7/8/2021 16:59:17'!
accountCanBeAdded: anAccount

	(anAccount validateAgainstPortfolio: self topMostPortfolio) ifTrue: [self error: self class invalidAccountAddErrorMessage].! !

!Portfolio methodsFor: 'validation' stamp: 'jb 7/8/2021 17:00:10'!
validateAgainstPortfolio: aPortfolio

	^(self = aPortfolio ) or: [accounts anySatisfy:[:account | account validateAgainstPortfolio: aPortfolio]].! !

!Portfolio methodsFor: 'validation' stamp: 'jb 7/8/2021 17:00:17'!
validateAgainstReceptiveAccount: aReceptiveAccount
	
	^(self = aReceptiveAccount) or: 
		[accounts anySatisfy: [:account | account validateAgainstReceptiveAccount: aReceptiveAccount]].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error message' stamp: 'FVF 7/8/2021 12:56:42'!
invalidAccountAddErrorMessage

	^'Portfolio cant add an account that already is in portfolio'.! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
AccountContainableInPortfolio subclass: #ReceptiveAccount
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


!ReceptiveAccount methodsFor: 'validation' stamp: 'FVF 7/8/2021 12:17:12'!
validateAgainstPortfolio: aPortfolio
	
	^aPortfolio validateAgainstReceptiveAccount: self.! !

!ReceptiveAccount methodsFor: 'validation' stamp: 'jb 7/8/2021 17:00:55'!
validateAgainstReceptiveAccount: aReceptiveAccount

	^ self = aReceptiveAccount! !


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


!Deposit methodsFor: 'value' stamp: 'jb 7/8/2021 17:01:10'!
value

	^value! !

!Deposit methodsFor: 'value' stamp: 'jb 7/6/2021 10:55:18'!
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

!Withdraw methodsFor: 'value' stamp: 'jb 7/6/2021 10:55:42'!
valueForBalance: aPartialBalance

	^aPartialBalance - self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdraw deposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'accesing' stamp: 'jb 7/5/2021 20:27:57'!
deposit

	^deposit! !

!Transfer methodsFor: 'accesing' stamp: 'FV 7/2/2021 16:46:03'!
value

	^value.! !

!Transfer methodsFor: 'accesing' stamp: 'jb 7/5/2021 20:28:03'!
withdraw

	^withdraw! !


!Transfer methodsFor: 'initialization' stamp: 'jb 7/5/2021 20:27:31'!
initializeFor: anAmount from: anAccount1 to: anAccount2

	value := anAmount.

	withdraw := TransferWithdraw register: anAmount on: anAccount1 withTransfer: self.
	deposit := TransferDeposit register: anAmount on: anAccount2 withTransfer: self.
	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'error message' stamp: 'FVF 7/6/2021 11:38:34'!
cantTransferZeroMoneyErrorMessage

	^'Cant transfer zero money'.! !


!Transfer class methodsFor: 'instance creation' stamp: 'FVF 7/6/2021 11:51:28'!
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

!TransferPart methodsFor: 'accesing' stamp: 'jb 7/5/2021 20:19:08'!
value
	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferPart class' category: 'ServiciosFinancieros-Ejercicio'!
TransferPart class
	instanceVariableNames: ''!

!TransferPart class methodsFor: 'instance creation' stamp: 'jb 7/5/2021 20:21:32'!
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

!TransferDeposit methodsFor: 'initialization' stamp: 'FV 7/2/2021 21:41:45'!
initializeFor: anAmount withTransfer: aTransfer

	value := anAmount.
	transfer := aTransfer.! !


!TransferDeposit methodsFor: 'accesing' stamp: 'FV 7/2/2021 21:38:53'!
counterpart
	
	^transfer withdraw.! !

!TransferDeposit methodsFor: 'accesing' stamp: 'FV 7/2/2021 21:35:02'!
transfer

	^transfer.! !

!TransferDeposit methodsFor: 'accesing' stamp: 'jb 7/5/2021 20:30:02'!
value
	^value! !

!TransferDeposit methodsFor: 'accesing' stamp: 'jb 7/6/2021 10:59:42'!
valueForBalance: aPartialBalance

	^aPartialBalance + self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: 'ServiciosFinancieros-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'instance creation' stamp: 'FV 7/2/2021 21:43:04'!
for: anAmount withTransfer: aTransfer

	^self new initializeFor: anAmount withTransfer: aTransfer.! !


!classDefinition: #TransferWithdraw category: 'ServiciosFinancieros-Ejercicio'!
TransferPart subclass: #TransferWithdraw
	instanceVariableNames: 'transfer value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferWithdraw methodsFor: 'initialization' stamp: 'FV 7/2/2021 21:42:04'!
initializeFor: anAmount withTransfer: aTransfer

	value := anAmount.
	transfer := aTransfer.! !


!TransferWithdraw methodsFor: 'accesing' stamp: 'FV 7/2/2021 21:39:04'!
counterpart
	
	^transfer deposit.! !

!TransferWithdraw methodsFor: 'accesing' stamp: 'FV 7/2/2021 21:35:11'!
transfer

	^transfer.! !

!TransferWithdraw methodsFor: 'accesing' stamp: 'jb 7/5/2021 20:30:10'!
value
	^value! !

!TransferWithdraw methodsFor: 'accesing' stamp: 'jb 7/6/2021 11:00:05'!
valueForBalance: aPartialBalance

	^aPartialBalance - self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: 'ServiciosFinancieros-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'FV 7/2/2021 21:43:22'!
for: anAmount withTransfer: aTransfer

	^self new initializeFor: anAmount withTransfer: aTransfer.! !
