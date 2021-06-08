!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:48'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'jb 6/8/2021 11:46:48'!
initialize
	topElement := Base new.! !


!OOStack methodsFor: 'testing' stamp: 'jb 6/8/2021 11:46:35'!
isEmpty
	^topElement isEmpty ! !


!OOStack methodsFor: 'operations' stamp: 'jb 6/8/2021 11:50:18'!
pop
	|lastElement|
	
	lastElement := self top.
	topElement := topElement previousStackableElement.
	
	^lastElement! !

!OOStack methodsFor: 'operations' stamp: 'jb 6/8/2021 11:50:58'!
push: anElement	
	topElement := StackableElement containing: anElement withPrevious: topElement.! !


!OOStack methodsFor: 'accessing' stamp: 'jb 6/8/2021 11:44:12'!
size
	^topElement size! !

!OOStack methodsFor: 'accessing' stamp: 'jb 6/8/2021 11:43:14'!
top
	^topElement content! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !



!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #StackableElement category: 'Stack-Exercise'!
Object subclass: #StackableElement
	instanceVariableNames: 'content previousStackableElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackableElement methodsFor: 'initialization' stamp: 'jb 6/8/2021 11:56:23'!
initializeContaining: aNewElement withPrevious: aPreviousElement
	content := aNewElement.
	previousStackableElement := aPreviousElement.! !


!StackableElement methodsFor: 'testing' stamp: 'jb 6/8/2021 11:46:18'!
isEmpty
	^false! !


!StackableElement methodsFor: 'accessing' stamp: 'jb 6/8/2021 11:49:26'!
content
	^content! !

!StackableElement methodsFor: 'accessing' stamp: 'jb 6/8/2021 11:49:16'!
previousStackableElement
	^previousStackableElement ! !

!StackableElement methodsFor: 'accessing' stamp: 'jb 6/8/2021 11:45:39'!
size
	^1 + previousStackableElement size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackableElement class' category: 'Stack-Exercise'!
StackableElement class
	instanceVariableNames: ''!

!StackableElement class methodsFor: 'as yet unclassified' stamp: 'jb 6/8/2021 11:55:07'!
containing: aNewElement withPrevious: aPreviousElement
	^StackableElement new initializeContaining: aNewElement withPrevious: aPreviousElement.! !


!classDefinition: #Base category: 'Stack-Exercise'!
StackableElement subclass: #Base
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Base methodsFor: 'testing' stamp: 'jb 6/8/2021 11:46:06'!
isEmpty
	^true! !


!Base methodsFor: 'accessing' stamp: 'jb 6/8/2021 11:43:30'!
content
	^self error: OOStack stackEmptyErrorDescription! !

!Base methodsFor: 'accessing' stamp: 'jb 6/8/2021 11:45:52'!
size
	^0! !
