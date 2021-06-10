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
	instanceVariableNames: 'stack nonStringStack sentenceFinderByPrefix emptyStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'jb 6/9/2021 12:00:26'!
test01PrefixIsNotAString

	self should: [sentenceFinderByPrefix find: 10 inStackOfStrings: stack]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: SentenceFinderByPrefix prefixIsNotAStringErrorDescription.
		]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'jb 6/9/2021 12:00:47'!
test02PrefixIsEmpty

	self should: [sentenceFinderByPrefix find: '' inStackOfStrings: stack]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: SentenceFinderByPrefix prefixIsEmptyErrorDescription.
			]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'jb 6/9/2021 12:00:52'!
test03PrefixStartsWithSpace

	self should: [sentenceFinderByPrefix find: '   ' inStackOfStrings: stack]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: SentenceFinderByPrefix prefixCannotStartWithSpaceErrorDescription .
			]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'jb 6/9/2021 12:22:16'!
test04StackIsNotAnOOStack
	|validPrefix nonStack|
	
	validPrefix := 'win'.
	nonStack := OrderedCollection new.

	self should: [sentenceFinderByPrefix find: validPrefix inStackOfStrings: nonStack]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: SentenceFinderByPrefix stackIsNotAnOOStackErrorDescription.
			]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'jb 6/9/2021 12:25:51'!
test05StackIsEmpty
	|validPrefix|
	
	validPrefix := 'win'.

	self assert: (sentenceFinderByPrefix find: validPrefix inStackOfStrings: emptyStack) equals: OrderedCollection new! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'jb 6/9/2021 12:28:32'!
test06StackContainsNonStringElements
	|validPrefix|
	
	validPrefix := 'win'.

	self should: [sentenceFinderByPrefix find: validPrefix inStackOfStrings: nonStringStack]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: SentenceFinderByPrefix stackElementIsNotAStringErrorDescription.
		]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'jb 6/9/2021 12:38:37'!
test07CanFindASentenceWithPrefix

	self assert: (sentenceFinderByPrefix find: 'The' inStackOfStrings: stack)
		equals: (OrderedCollection with: 'The winds of Winter')! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'jb 6/9/2021 12:38:06'!
test08CanFindMultipleSentenceWithPrefix

	self assert: (sentenceFinderByPrefix find: 'win' inStackOfStrings: stack)
		equals: (OrderedCollection with: 'winning is everything' with: 'winter is coming')! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'jb 6/9/2021 12:38:01'!
test09SentenceFinderIsCaseSensitive
	
	self assert: (sentenceFinderByPrefix find: 'Win' inStackOfStrings: stack)
		equals: (OrderedCollection with: 'Winter is here').
		
	self assert: (sentenceFinderByPrefix find: 'win' inStackOfStrings: stack)
		equals: (OrderedCollection with: 'winning is everything' with: 'winter is coming')! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'jb 6/9/2021 12:49:16'!
test10StackIsUnalteredAfterFind
			
	self assert: (sentenceFinderByPrefix find: 'win' inStackOfStrings: stack)
		equals: (OrderedCollection with: 'winning is everything' with: 'winter is coming').
	
	self assert: (stack pop) equals: 'Winter is here'.
	self assert: (stack pop) equals: 'The winds of Winter'.
	self assert: (stack pop) equals: 'winning is everything'.
	self assert: (stack pop) equals: 'winter is coming'.
		
	! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'jb 6/9/2021 12:47:51'!
setUp	
	stack := OOStack new.
	stack push: 'winter is coming'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	stack push: 'Winter is here'.
	
	nonStringStack := OOStack new.
	nonStringStack push: 'winter is coming'.
	nonStringStack push: 23.
	nonStringStack push: 'winning is everything'.
	
	emptyStack := OOStack new.
	
	sentenceFinderByPrefix := SentenceFinderByPrefix new.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'operations' stamp: 'jb 6/8/2021 11:50:18'!
pop
	|lastElement|
	
	lastElement := self top.
	topElement := topElement previousStackableElement.
	
	^lastElement! !

!OOStack methodsFor: 'operations' stamp: 'jb 6/8/2021 11:50:58'!
push: anElement	
	topElement := StackableElement containing: anElement withPrevious: topElement.! !


!OOStack methodsFor: 'initialization' stamp: 'jb 6/8/2021 11:46:48'!
initialize
	topElement := Base new.! !


!OOStack methodsFor: 'checks' stamp: 'jb 6/8/2021 11:46:35'!
isEmpty
	^topElement isEmpty ! !


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



!classDefinition: #Sentence category: 'Stack-Exercise'!
Object subclass: #Sentence
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Sentence methodsFor: 'as yet unclassified' stamp: 'jb 6/10/2021 15:13:04'!
addToOrderedCollection: aCollection
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sentence class' category: 'Stack-Exercise'!
Sentence class
	instanceVariableNames: ''!

!Sentence class methodsFor: 'as yet unclassified' stamp: 'jb 6/10/2021 15:54:28'!
from: aSentence withPrefix: aPrefix
	^(Sentence subclasses detect: [:aSubclass| aSubclass canHandlePrefix: aPrefix withText: aSentence]) new initializeWithSentence: aSentence.! !


!classDefinition: #SentenceWithPrefix category: 'Stack-Exercise'!
Sentence subclass: #SentenceWithPrefix
	instanceVariableNames: 'content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceWithPrefix methodsFor: 'as yet unclassified' stamp: 'jb 6/9/2021 13:24:37'!
addToOrderedCollection: aCollection
	aCollection add: content! !

!SentenceWithPrefix methodsFor: 'as yet unclassified' stamp: 'jb 6/9/2021 13:17:44'!
initializeWithSentence: aSentence
	content := aSentence! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceWithPrefix class' category: 'Stack-Exercise'!
SentenceWithPrefix class
	instanceVariableNames: ''!

!SentenceWithPrefix class methodsFor: 'as yet unclassified' stamp: 'jb 6/9/2021 13:28:35'!
canHandlePrefix: aPrefix withText: aText
	^(aText isString) and: [aText beginsWith: aPrefix]! !


!classDefinition: #SentenceWithoutPrefix category: 'Stack-Exercise'!
Sentence subclass: #SentenceWithoutPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceWithoutPrefix methodsFor: 'as yet unclassified' stamp: 'jb 6/9/2021 13:24:04'!
addToOrderedCollection: aCollection! !

!SentenceWithoutPrefix methodsFor: 'as yet unclassified' stamp: 'jb 6/9/2021 13:18:33'!
initializeWithSentence: aSentence
	content := aSentence! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceWithoutPrefix class' category: 'Stack-Exercise'!
SentenceWithoutPrefix class
	instanceVariableNames: ''!

!SentenceWithoutPrefix class methodsFor: 'as yet unclassified' stamp: 'jb 6/9/2021 13:14:35'!
canHandlePrefix: aPrefix withText: aText
	^(aText beginsWith: aPrefix) not! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'jb 6/10/2021 15:54:28'!
find: aPrefix inStackOfStrings: aStackOfStrings
	| analysedElementsStack answers |
	
	self checkForFindWithPrefix: aPrefix withStackOfStrings: aStackOfStrings.
	
	answers := OrderedCollection new.
	analysedElementsStack := OOStack new.

	self moveElementsFrom: aStackOfStrings to: analysedElementsStack forEachElementDo: [:element |
		"Sanity check for non string elements in stack"
		self checkElementIsString: element.			
		
		(Sentence from: element withPrefix: aPrefix) addToOrderedCollection: answers.
	].

	self moveElementsFrom: analysedElementsStack to: aStackOfStrings.

	^answers! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'jb 6/9/2021 13:27:34'!
checkElementIsString: anElement

	(anElement isString) ifFalse: [ 
		"self rebuild: aStackOfStrings from: analysedElementsStack."
		^self error: SentenceFinderByPrefix stackElementIsNotAStringErrorDescription.
	].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'jb 6/9/2021 12:55:56'!
checkForFindWithPrefix: aPrefix withStackOfStrings: aStackOfStrings

(aPrefix isString) ifFalse: [^self error: SentenceFinderByPrefix prefixIsNotAStringErrorDescription].
(aStackOfStrings isKindOf: OOStack) ifFalse: [^self error: SentenceFinderByPrefix stackIsNotAnOOStackErrorDescription].
aPrefix isEmpty ifTrue: [^self error: SentenceFinderByPrefix prefixIsEmptyErrorDescription ].
(aPrefix beginsWith: ' ') ifTrue: [^self error: SentenceFinderByPrefix prefixCannotStartWithSpaceErrorDescription].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'jb 6/10/2021 15:59:24'!
moveElementsFrom: fromStack to: toStack
	
	self moveElementsFrom: fromStack to: toStack forEachElementDo: [:element|].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'jb 6/10/2021 15:08:29'!
moveElementsFrom: fromStack to: toStack forEachElementDo: aBlock
	|topmostElement|

	(1 to: fromStack size) do: [ :index |
		topmostElement := fromStack pop.
		toStack push: topmostElement.
		
		aBlock value: topmostElement.
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'jb 6/9/2021 11:57:48'!
prefixCannotStartWithSpaceErrorDescription
	^'The prefix cannot start with an empty space'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'jb 6/9/2021 11:45:24'!
prefixIsEmptyErrorDescription
	^'The prefix cannot be empty'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'jb 6/8/2021 12:38:29'!
prefixIsNotAStringErrorDescription
	^'The prefix given is not a string'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'jb 6/9/2021 12:10:58'!
stackElementIsNotAStringErrorDescription
	^'An element of the stack is not a string.'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'jb 6/9/2021 12:24:14'!
stackIsNotAnOOStackErrorDescription
	^'The stack given is not an instance of OOStack'! !


!classDefinition: #StackableElement category: 'Stack-Exercise'!
Object subclass: #StackableElement
	instanceVariableNames: 'content previousStackableElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackableElement methodsFor: 'nil' stamp: 'jb 6/8/2021 11:49:26'!
content
	^content! !

!StackableElement methodsFor: 'nil' stamp: 'jb 6/8/2021 11:56:23'!
initializeContaining: aNewElement withPrevious: aPreviousElement
	content := aNewElement.
	previousStackableElement := aPreviousElement.! !

!StackableElement methodsFor: 'nil' stamp: 'jb 6/8/2021 11:46:18'!
isEmpty
	^false! !

!StackableElement methodsFor: 'nil' stamp: 'jb 6/8/2021 11:49:16'!
previousStackableElement
	^previousStackableElement ! !

!StackableElement methodsFor: 'nil' stamp: 'jb 6/8/2021 11:45:39'!
size
	^1 + previousStackableElement size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackableElement class' category: 'Stack-Exercise'!
StackableElement class
	instanceVariableNames: ''!

!StackableElement class methodsFor: 'nil' stamp: 'jb 6/8/2021 11:55:07'!
containing: aNewElement withPrevious: aPreviousElement
	^StackableElement new initializeContaining: aNewElement withPrevious: aPreviousElement.! !


!classDefinition: #Base category: 'Stack-Exercise'!
StackableElement subclass: #Base
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Base methodsFor: 'as yet unclassified' stamp: 'jb 6/8/2021 11:43:30'!
content
	^self error: OOStack stackEmptyErrorDescription! !

!Base methodsFor: 'as yet unclassified' stamp: 'jb 6/8/2021 11:46:06'!
isEmpty
	^true! !

!Base methodsFor: 'as yet unclassified' stamp: 'jb 6/8/2021 11:45:52'!
size
	^0! !
