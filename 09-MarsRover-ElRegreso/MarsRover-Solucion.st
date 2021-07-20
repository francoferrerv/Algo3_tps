!classDefinition: #TestLog category: 'MarsRover-Solucion'!
TestCase subclass: #TestLog
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!TestLog methodsFor: 'tests' stamp: 'FVF 7/20/2021 11:31:11'!
test01

	| log marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	log := Log new.
	marsrover addPositionTracker: log.
	
	
	self assert: OrderedCollection new equals: log asOrderedCollection.! !

!TestLog methodsFor: 'tests' stamp: 'FVF 7/20/2021 11:31:11'!
test02

	| log marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	log := Log new.
	marsrover addPositionTracker: log.
	marsrover processCommands: 'f'.
	
	self assert: (OrderedCollection with: (0@1) asString) equals: log asOrderedCollection.! !

!TestLog methodsFor: 'tests' stamp: 'FVF 7/20/2021 11:31:11'!
test03

	| log marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	log := Log new.
	marsrover addPositionTracker: log.
	marsrover processCommands: 'b'.
	
	self assert: (OrderedCollection with: (0@-1) asString) equals: log asOrderedCollection.! !

!TestLog methodsFor: 'tests' stamp: 'FVF 7/20/2021 11:31:11'!
test04

	| log marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #East.
	log := Log new.
	marsrover addPositionTracker: log.
	marsrover processCommands: 'f'.
	
	self assert: (OrderedCollection with: (1@0) asString) equals: log asOrderedCollection.! !

!TestLog methodsFor: 'tests' stamp: 'FVF 7/20/2021 11:31:11'!
test05

	| log marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #West.
	log := Log new.
	marsrover addPositionTracker: log.
	marsrover processCommands: 'f'.
	
	self assert: (OrderedCollection with: (-1@0) asString) equals: log asOrderedCollection.! !

!TestLog methodsFor: 'tests' stamp: 'FVF 7/20/2021 11:31:41'!
test06

	| log marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	log := Log new.
	marsrover addHeadingTracker: log.
	marsrover processCommands: 'l'.
	
	self assert: (OrderedCollection with: 'West') equals: log asOrderedCollection.! !

!TestLog methodsFor: 'tests' stamp: 'FVF 7/20/2021 11:31:41'!
test07

	| log marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	log := Log new.
	marsrover addHeadingTracker: log.
	marsrover processCommands: 'r'.
	
	self assert: (OrderedCollection with: 'East') equals: log asOrderedCollection.! !

!TestLog methodsFor: 'tests' stamp: 'FVF 7/20/2021 11:31:41'!
test08

	| log marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #East.
	log := Log new.
	marsrover addHeadingTracker: log.
	marsrover processCommands: 'l'.
	
	self assert: (OrderedCollection with: 'North') equals: log asOrderedCollection.! !

!TestLog methodsFor: 'tests' stamp: 'FVF 7/20/2021 11:31:41'!
test09

	| log marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #East.
	log := Log new.
	marsrover addHeadingTracker: log.
	marsrover processCommands: 'r'.
	
	self assert: (OrderedCollection with: 'South') equals: log asOrderedCollection.! !

!TestLog methodsFor: 'tests' stamp: 'FVF 7/20/2021 11:31:41'!
test10

	| log marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	log := Log new.
	marsrover addPositionTracker: log.
	marsrover addHeadingTracker: log.
	marsrover processCommands: 'fblr'.
	
	self assert: (OrderedCollection with: '0@1' with: '0@0' with: 'West' with: 'North') equals: log asOrderedCollection.! !


!classDefinition: #TestMarsRover category: 'MarsRover-Solucion'!
TestCase subclass: #TestMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:42:57'!
test01MarsRoverDoestNotMoveWhenNoCommandsAreSent

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: '' endsAt: 0@0 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:43:05'!
test02RoverFacingNorthCanMoveForward

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'f' endsAt: 0@1 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:43:13'!
test03RoverFacingNorthCanMoveBackward

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'b' endsAt: 0@-1 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:43:24'!
test04RoverFacingNorthHeadsEastAfterTurningRight

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'r' endsAt: 0@0 heading: #East! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:43:55'!
test05RoverFacingNorthHeadsWestAfterTurningLeft
	
	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'l' endsAt: 0@0 heading: #West! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:44:26'!
test06RoverFacingEastHeadsSouthWhenTurningRight
	
	self assertRoverStartingAt: 0@0 heading: #East afterProcessing: 'r' endsAt: 0@0 heading: #South! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:44:43'!
test07RoverFacingSouthHeadsWestWhenTurningRight
	
	self assertRoverStartingAt: 0@0 heading: #South afterProcessing: 'r' endsAt: 0@0 heading: #West! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:45:00'!
test08RoverFacingWestHeadsNorthWhenTurningRight
	
	self assertRoverStartingAt: 0@0 heading: #West afterProcessing: 'r' endsAt: 0@0 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:45:20'!
test09RoverFacingEastHeadsNorthWhenTurningLeft
	
	self assertRoverStartingAt: 0@0 heading: #East afterProcessing: 'l' endsAt: 0@0 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:45:52'!
test10RoverFacingSouthHeadsEastWhenTurningLeft

	self assertRoverStartingAt: 0@0 heading: #South afterProcessing: 'l' endsAt: 0@0 heading: #East! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:46:17'!
test11RoverFacingWestHeadsSouthWhenTurningLeft

	self assertRoverStartingAt: 0@0 heading: #West afterProcessing: 'l' endsAt: 0@0 heading: #South! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:47:36'!
test12RoverFacingEastCanMoveForward
	
	self assertRoverStartingAt: 0@0 heading: #East afterProcessing: 'f' endsAt: 1@0 heading: #East! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:47:55'!
test13RoverFacingEastCanMoveBackwards

	self assertRoverStartingAt: 0@0 heading: #East afterProcessing: 'b' endsAt: -1@0 heading: #East! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:48:20'!
test14RoverFacingSouthCanMoveForward
	
	self assertRoverStartingAt: 0@0 heading: #South afterProcessing: 'f' endsAt: 0@-1 heading: #South! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:48:38'!
test15RoverFacingSouthCanMoveBackward
	
	self assertRoverStartingAt: 0@0 heading: #South afterProcessing: 'b' endsAt: 0@1 heading: #South! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:49:10'!
test16RoverFacingWestCanMoveForward
	
	self assertRoverStartingAt: 0@0 heading: #West afterProcessing: 'f' endsAt: -1@0 heading: #West! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:49:46'!
test17RoverFacingWestCanMoveBackward

	self assertRoverStartingAt: 0@0 heading: #West afterProcessing: 'b' endsAt: 1@0 heading: #West! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:50:56'!
test18RoverCanProcessMultipleCommands

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'ff' endsAt: 0@2 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 6/30/2021 16:05:43'!
test19RoverStopsWhenProcessingAnInvalidCommand

	| marsRover |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	
	self should: [ marsRover processCommands: 'fxf' ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: marsRover invalidCommandErrorMessage.
			self assert: (marsRover isAt: 0@1 heading: #North).
		].
	
	! !


!TestMarsRover methodsFor: 'assertions' stamp: 'LL 7/1/2021 00:42:36'!
assertRoverStartingAt: aPosition heading: aCardinalPoint afterProcessing: aStringOfCommands endsAt: aFinalPosition heading: aFinalCardinalPoint

	| marsRover |
	marsRover := MarsRover startingAt: aPosition heading: aCardinalPoint.
	
	marsRover processCommands: aStringOfCommands.
	
	self assert: (marsRover isAt: aFinalPosition heading: aFinalCardinalPoint)! !


!classDefinition: #TestWindow category: 'MarsRover-Solucion'!
TestCase subclass: #TestWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!TestWindow methodsFor: 'as yet unclassified' stamp: 'FVF 7/20/2021 11:32:08'!
test01

	| window marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	window := Window new.
	marsrover addPositionTracker: window.
	
	self deny: window hasPosition.! !

!TestWindow methodsFor: 'as yet unclassified' stamp: 'FVF 7/20/2021 11:32:08'!
test02

	| window marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	window := Window new.
	marsrover addPositionTracker: window.
	marsrover processCommands: 'f'.
	
	self assert: '0@1' equals: window getPosition.! !

!TestWindow methodsFor: 'as yet unclassified' stamp: 'FVF 7/20/2021 11:32:08'!
test03

	| window marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	window := Window new.
	marsrover addPositionTracker: window.
	marsrover processCommands: 'b'.
	
	self assert: '0@-1' equals: window getPosition.! !

!TestWindow methodsFor: 'as yet unclassified' stamp: 'FVF 7/20/2021 11:33:11'!
test04

	| window marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #East.
	window := Window new.
	marsrover addPositionTracker: window.
	marsrover processCommands: 'f'.
	
	self assert: '1@0' equals: window getPosition .! !

!TestWindow methodsFor: 'as yet unclassified' stamp: 'FVF 7/20/2021 11:33:10'!
test05

	| window marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #West.
	window := Window new.
	marsrover addPositionTracker: window.
	marsrover processCommands: 'f'.
	
	self assert: '-1@0'  equals: window getPosition.! !

!TestWindow methodsFor: 'as yet unclassified' stamp: 'FVF 7/20/2021 11:32:38'!
test06

	| window marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	window := Window new.
	marsrover addHeadingTracker: window.
	marsrover processCommands: 'l'.
	
	self assert:  'West' equals: window getDirection! !

!TestWindow methodsFor: 'as yet unclassified' stamp: 'FVF 7/20/2021 11:32:38'!
test07

	| window marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	window := Window new.
	marsrover addHeadingTracker: window.
	marsrover processCommands: 'r'.
	
	self assert:  'East' equals: window getDirection! !

!TestWindow methodsFor: 'as yet unclassified' stamp: 'FVF 7/20/2021 11:32:38'!
test08

	| window marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #East.
	window := Window new.
	marsrover addHeadingTracker: window.
	marsrover processCommands: 'l'.
	
	self assert:  'North' equals: window getDirection! !

!TestWindow methodsFor: 'as yet unclassified' stamp: 'FVF 7/20/2021 11:32:38'!
test09

	| window marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #East.
	window := Window new.
	marsrover addHeadingTracker: window.
	marsrover processCommands: 'r'.
	
	self assert:  'South' equals: window getDirection! !

!TestWindow methodsFor: 'as yet unclassified' stamp: 'FVF 7/20/2021 11:33:10'!
test10

	| window marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	window := Window new.
	marsrover addPositionTracker: window.
	marsrover addHeadingTracker: window.
	marsrover processCommands: 'fblr'.
	
	self assert: '0@0' equals: window getPosition.
	self assert: 'North' equals: window getDirection .! !


!classDefinition: #Log category: 'MarsRover-Solucion'!
Object subclass: #Log
	instanceVariableNames: 'registers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!Log methodsFor: 'as yet unclassified' stamp: 'FVF 7/17/2021 22:32:15'!
asOrderedCollection

	^registers.
	! !

!Log methodsFor: 'as yet unclassified' stamp: 'FVF 7/17/2021 22:31:37'!
initialize

	registers := OrderedCollection new.! !

!Log methodsFor: 'as yet unclassified' stamp: 'FVF 7/19/2021 21:21:05'!
notifyChangeInHeading: aDirection
	
	(aDirection isKindOf: MarsRoverHeadFacingNorth) ifTrue: [registers add: 'North'.].
	(aDirection isKindOf: MarsRoverHeadFacingWest) ifTrue: [registers add: 'West'.].
	(aDirection isKindOf: MarsRoverHeadFacingSouth) ifTrue: [registers add: 'South'.].
	(aDirection isKindOf: MarsRoverHeadFacingEast) ifTrue: [registers add: 'East'.].
	! !

!Log methodsFor: 'as yet unclassified' stamp: 'FVF 7/17/2021 22:32:40'!
notifyChangeInPosition: aPosition

	registers add: aPosition asString.

	! !


!classDefinition: #MarsRover category: 'MarsRover-Solucion'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head positionTrackers directionTrackers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRover methodsFor: 'initialization' stamp: 'FVF 7/19/2021 21:30:22'!
initializeStartingAt: aPosition heading: aCardinalPoint 
	
	position := aPosition.
	head := MarsRoverHead of: self facing: aCardinalPoint.
	positionTrackers := OrderedCollection new.
	directionTrackers := OrderedCollection new.
	! !


!MarsRover methodsFor: 'process commands' stamp: 'LL 6/30/2021 15:54:14'!
processCommands: aStringWithCommands

	aStringWithCommands do: [ :aCommand | 
		self assertCommandIsValid: aCommand.
		self processCommand: aCommand.
	].
	
! !


!MarsRover methodsFor: 'testing' stamp: 'LL 6/30/2021 19:47:14'!
isAt: aPosition heading: aCardinalPoint

	^ position = aPosition and: [ head isHeading: aCardinalPoint ]! !


!MarsRover methodsFor: 'private - process commands' stamp: 'LL 6/30/2021 15:54:11'!
assertCommandIsValid: aCommand

	^ (self isInvalidCommand: aCommand) ifTrue: [ self error: self invalidCommandErrorMessage ]! !

!MarsRover methodsFor: 'private - process commands' stamp: 'LL 6/30/2021 15:48:06'!
invalidCommandErrorMessage

	^'Invalid command'! !

!MarsRover methodsFor: 'private - process commands' stamp: 'FVF 7/17/2021 22:41:52'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ head movingForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ head movingBackwards ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ head rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ head rotateLeft ].
	
! !


!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:26:42'!
isBackwardCommand: command

	^ command = $b! !

!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:26:27'!
isForwardCommand: command

	^ command = $f! !

!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:51:21'!
isInvalidCommand: aCommand
	^(self isForwardCommand: aCommand) not and: 
		[ (self isBackwardCommand: aCommand) not and: 
			[ (self isRotateRightCommand: aCommand) not and: 
				[ (self isRotateLeftCommand: aCommand) not ] ] ]! !

!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:50:53'!
isRotateLeftCommand: command

	^ command = $l! !

!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:27:33'!
isRotateRightCommand: command

	^ command = $r! !


!MarsRover methodsFor: 'dd - moving' stamp: 'FVF 7/19/2021 20:58:48'!
moveDown
	
	self step: (0@-1).
	! !

!MarsRover methodsFor: 'dd - moving' stamp: 'FVF 7/19/2021 20:59:54'!
moveLeft
	
	self step:(-1@0)
	! !

!MarsRover methodsFor: 'dd - moving' stamp: 'FVF 7/19/2021 21:00:12'!
moveRight
	
	self step:(1@0)
! !

!MarsRover methodsFor: 'dd - moving' stamp: 'FVF 7/19/2021 21:00:26'!
moveUp
	
	self step:(0@1)
	! !

!MarsRover methodsFor: 'dd - moving' stamp: 'FVF 7/19/2021 21:30:04'!
step: aStep

	position := position + aStep.
	positionTrackers do: [:positionTracker| positionTracker notifyChangeInPosition: position.]! !


!MarsRover methodsFor: 'dd - heading' stamp: 'FVF 7/19/2021 21:31:07'!
face: aMarsroverHead

	head := aMarsroverHead of: self.
	directionTrackers do: [:directionTracker| directionTracker notifyChangeInHeading: head].! !

!MarsRover methodsFor: 'dd - heading' stamp: 'FVF 7/19/2021 21:02:53'!
headEast
	
	self face: MarsRoverHeadFacingEast.
	
	! !

!MarsRover methodsFor: 'dd - heading' stamp: 'FVF 7/19/2021 21:04:18'!
headNorth

	self face: MarsRoverHeadFacingNorth.
	! !

!MarsRover methodsFor: 'dd - heading' stamp: 'FVF 7/19/2021 21:04:33'!
headSouth
	
	self face: MarsRoverHeadFacingSouth.
	! !

!MarsRover methodsFor: 'dd - heading' stamp: 'FVF 7/19/2021 21:04:47'!
headWest
	
	self face: MarsRoverHeadFacingWest.
	! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'FVF 7/20/2021 11:30:17'!
addHeadingTracker: aTracker

	directionTrackers add: aTracker.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'FVF 7/20/2021 11:29:44'!
addPositionTracker: aTracker

	positionTrackers add: aTracker.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-Solucion'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'LL 6/30/2021 13:30:13'!
startingAt: aPoint heading: aCardinalPoint 
	
	^self new initializeStartingAt: aPoint heading: aCardinalPoint ! !


!classDefinition: #MarsRoverHead category: 'MarsRover-Solucion'!
Object subclass: #MarsRoverHead
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 16:17:57'!
initializeOf: aMarsRover

	marsRover := aMarsRover! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:46:16'!
isHeading: aCardinalPoint

	^self class whenFacing: aCardinalPoint

	! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	self subclassResponsibility! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	self subclassResponsibility! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 16:36:46'!
rotateLeft

	self subclassResponsibility! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 16:36:43'!
rotateRight

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHead class' category: 'MarsRover-Solucion'!
MarsRoverHead class
	instanceVariableNames: ''!

!MarsRoverHead class methodsFor: 'testing' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	self subclassResponsibility.! !


!MarsRoverHead class methodsFor: 'instance creation' stamp: 'LL 6/30/2021 16:16:27'!
of: aMarsRover

	^self new initializeOf: aMarsRover! !

!MarsRoverHead class methodsFor: 'instance creation' stamp: 'LL 6/30/2021 19:46:37'!
of: aMarsRover facing: aCardinalPoint
	
	| headingSubclass |
	headingSubclass := self subclasses detect: [ :aHeadingSubclass | aHeadingSubclass whenFacing: aCardinalPoint ].
	
	^headingSubclass of: aMarsRover.! !


!classDefinition: #MarsRoverHeadFacingEast category: 'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingEast methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveLeft.

	! !

!MarsRoverHeadFacingEast methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveRight.

	! !

!MarsRoverHeadFacingEast methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:06:22'!
rotateLeft

	^marsRover headNorth.

	! !

!MarsRoverHeadFacingEast methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:10:14'!
rotateRight

	^marsRover headSouth.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingEast class' category: 'MarsRover-Solucion'!
MarsRoverHeadFacingEast class
	instanceVariableNames: ''!

!MarsRoverHeadFacingEast class methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #East! !


!classDefinition: #MarsRoverHeadFacingNorth category: 'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingNorth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveDown.! !

!MarsRoverHeadFacingNorth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveUp.! !

!MarsRoverHeadFacingNorth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:06:33'!
rotateLeft

	^marsRover headWest.! !

!MarsRoverHeadFacingNorth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:10:58'!
rotateRight

	^marsRover headEast.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingNorth class' category: 'MarsRover-Solucion'!
MarsRoverHeadFacingNorth class
	instanceVariableNames: ''!

!MarsRoverHeadFacingNorth class methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #North! !


!classDefinition: #MarsRoverHeadFacingSouth category: 'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingSouth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveUp.! !

!MarsRoverHeadFacingSouth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveDown! !

!MarsRoverHeadFacingSouth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:06:43'!
rotateLeft

	^marsRover headEast.! !

!MarsRoverHeadFacingSouth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:12:30'!
rotateRight

	^marsRover headWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingSouth class' category: 'MarsRover-Solucion'!
MarsRoverHeadFacingSouth class
	instanceVariableNames: ''!

!MarsRoverHeadFacingSouth class methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #South! !


!classDefinition: #MarsRoverHeadFacingWest category: 'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingWest methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveRight.! !

!MarsRoverHeadFacingWest methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveLeft.! !

!MarsRoverHeadFacingWest methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:06:52'!
rotateLeft

	^marsRover headSouth.! !

!MarsRoverHeadFacingWest methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:12:44'!
rotateRight

	^marsRover headNorth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingWest class' category: 'MarsRover-Solucion'!
MarsRoverHeadFacingWest class
	instanceVariableNames: ''!

!MarsRoverHeadFacingWest class methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #West! !


!classDefinition: #Window category: 'MarsRover-Solucion'!
Object subclass: #Window
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!Window methodsFor: 'as yet unclassified' stamp: 'FVF 7/19/2021 21:35:51'!
getDirection

	^direction! !

!Window methodsFor: 'as yet unclassified' stamp: 'FVF 7/19/2021 21:35:57'!
getPosition

	^position! !

!Window methodsFor: 'as yet unclassified' stamp: 'FVF 7/20/2021 11:12:13'!
hasPosition

	^ (position = nil) not.! !

!Window methodsFor: 'as yet unclassified' stamp: 'FVF 7/20/2021 11:13:04'!
initialize

	position := nil.
	direction := nil.! !

!Window methodsFor: 'as yet unclassified' stamp: 'FVF 7/19/2021 21:34:46'!
notifyChangeInHeading: aDirection
	
	(aDirection isKindOf: MarsRoverHeadFacingNorth) ifTrue: [direction := 'North'.].
	(aDirection isKindOf: MarsRoverHeadFacingWest) ifTrue: [direction  := 'West'.].
	(aDirection isKindOf: MarsRoverHeadFacingSouth) ifTrue: [direction := 'South'.].
	(aDirection isKindOf: MarsRoverHeadFacingEast) ifTrue: [direction := 'East'.].
	! !

!Window methodsFor: 'as yet unclassified' stamp: 'FVF 7/19/2021 21:35:00'!
notifyChangeInPosition: aPosition

	position := aPosition asString.! !
