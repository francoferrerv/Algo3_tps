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


!classDefinition: #TransactionTests category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransactionTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransactionTests methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 15:39:23'!
test01Caso0

	


	! !

!TransactionTests methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 15:50:40'!
test02

	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 50 * peso on: account1.
	Transfer register: 50 * peso from: account1 to: account2.
	
	self assert:(account1 balance) equals: 0 * peso.
	self assert:(account2 balance) equals: 50 * peso. 
	 

	
! !

!TransactionTests methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 16:37:12'!
test03

	| account1 account2 transfer|
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 50 * peso on: account1.
	transfer := Transfer register: 50 * peso from: account1 to: account2.
	
	self assert: transfer value equals: 50 * peso
	
	 

	
! !

!TransactionTests methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 21:40:54'!
test04

	| account1 account2 transfer|
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 50 * peso on: account1.
	transfer := Transfer register: 50 * peso from: account1 to: account2.
	
	self assert:((account1 transactions at: 2) counterpart) equals: transfer deposit.
	self assert:((account2 transactions at: 1) counterpart) equals: transfer withdraw. 
	 

	
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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Transfer
	instanceVariableNames: 'value accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 21:37:53'!
deposit

	^(accounts at: 2 ) transactions detect: [
		:transaction| (transaction isKindOf: TransferDeposit) 
		and:[transaction transfer = self ]].! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 20:52:46'!
initializeFor: anAmount from: anAccount1 to: anAccount2
	
	value := anAmount.
	accounts := OrderedCollection with: anAccount1 with: anAccount2.
	^self! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 16:46:03'!
value

	^value.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 21:38:27'!
withdraw

	^(accounts at: 1 ) transactions detect: [
		:transaction| (transaction isKindOf: TransferWithdraw) 
		and:[transaction transfer = self ]]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 20:20:43'!
register: anAmount from: anAccount1 to: anAccount2

	| transfer |
	
	transfer := self new initializeFor: anAmount from: anAccount1 to: anAccount2.
	
	TransferWithdraw register: anAmount on: anAccount1 withTransfer: transfer.
	TransferDeposit register: anAmount on: anAccount2 withTransfer: transfer.
	
	^transfer

! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 21:44:31'!
register: aValue on: account withTransfer: aTransfer

	| transaction |
	
	transaction := self for: aValue withTransfer: aTransfer. 
	account register: transaction.
		
	^transaction
	
	

! !


!classDefinition: #TransferDeposit category: 'ServiciosFinancieros-Ejercicio'!
Transfer subclass: #TransferDeposit
	instanceVariableNames: 'transfer'
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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: 'ServiciosFinancieros-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 21:43:04'!
for: anAmount withTransfer: aTransfer

	^self new initializeFor: anAmount withTransfer: aTransfer.! !


!classDefinition: #TransferWithdraw category: 'ServiciosFinancieros-Ejercicio'!
Transfer subclass: #TransferWithdraw
	instanceVariableNames: 'transfer'
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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: 'ServiciosFinancieros-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'as yet unclassified' stamp: 'FV 7/2/2021 21:43:22'!
for: anAmount withTransfer: aTransfer

	^self new initializeFor: anAmount withTransfer: aTransfer.! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'FV 7/2/2021 15:27:01'!
balance

	^transactions sum: [ :aTransaction | aTransaction transactionBalance ] ifEmpty: [ 0 ]! !

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
