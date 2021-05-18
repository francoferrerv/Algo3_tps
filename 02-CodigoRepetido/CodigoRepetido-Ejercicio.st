!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'tests' stamp: 'jb 5/18/2021 12:04:20'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertBlockExecutionTime: [customerBook addCustomerNamed: 'John Lennon'.]
	      doesntTakeMoreThan: 50 * millisecond.
	! !

!CustomerBookTest methodsFor: 'tests' stamp: 'jb 5/18/2021 12:04:20'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	
	self assertBlockExecutionTime: [customerBook removeCustomerNamed: paulMcCartney.]
	      doesntTakeMoreThan: 100 * millisecond.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'jb 5/18/2021 12:10:56'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
		
	self assertThatBlockFails: [customerBook addCustomerNamed: ''.]
	      withErrorType: Error
	      andTestThat: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'tests' stamp: 'jb 5/18/2021 12:10:57'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
		
	self assertThatBlockFails: [ customerBook removeCustomerNamed: 'Paul McCartney'.]
	      withErrorType: NotFound
	      andTestThat: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'jb 5/18/2021 12:02:16'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertNumberOfCustomersIn: customerBook
		active: 0
		suspended: 1
		total: 1.
		
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'jb 5/18/2021 12:02:16'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertNumberOfCustomersIn: customerBook
		active: 0
		suspended: 0
		total: 0.
	
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'jb 5/18/2021 12:10:02'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
		
	self assertThatBook: customerBook
	      failsIftryingToSuspend: 'Ringo Starr'
	      andStillContains: johnLennon
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'jb 5/18/2021 12:10:02'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self assertThatBook: customerBook
	      failsIftryingToSuspend: johnLennon
	      andStillContains: johnLennon
! !


!CustomerBookTest methodsFor: 'helpers' stamp: 'jb 5/18/2021 12:13:35'!
assertBlockExecutionTime: blockToMeasure doesntTakeMoreThan: maxTime
	| measuredTime |

	measuredTime := blockToMeasure timeToRun.
	self assert: measuredTime < maxTime.! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'jb 5/18/2021 12:15:36'!
assertNumberOfCustomersIn: customerBook active: activeNumber suspended: suspendedNumber total: totalNumber
	self assert: activeNumber equals: customerBook numberOfActiveCustomers.
	self assert: suspendedNumber equals: customerBook numberOfSuspendedCustomers.
	self assert: totalNumber equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'jb 5/18/2021 12:15:54'!
assertThatBlockFails: block withErrorType: errorType andTestThat: assertions

	[ block value.
	self fail ]
		on: errorType
		do: assertions! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'jb 5/18/2021 12:16:16'!
assertThatBook: customerBook failsIftryingToSuspend: suspendedPerson andStillContains: personInBook

		
self assertThatBlockFails: [ customerBook suspendCustomerNamed: suspendedPerson]
      withErrorType: CantSuspend
      andTestThat: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: personInBook) ]! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'initialization' stamp: 'LL 10/30/2020 12:22:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'jb 5/18/2021 11:58:01'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName! !

!CustomerBook methodsFor: 'customer management' stamp: 'jb 5/18/2021 11:50:00'!
removeCustomerNamed: aName 
	
	^active remove: aName ifAbsent: [
			suspended remove: aName ifAbsent: [NotFound signal]
		]
! !

!CustomerBook methodsFor: 'customer management' stamp: 'jb 5/18/2021 11:54:04'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	suspended add: aName.

	^nil.	! !


!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'accessing' stamp: 'jb 5/18/2021 11:58:49'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !


!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'jb 5/18/2021 11:54:45'!
isEmpty
	
	^(active isEmpty) and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
