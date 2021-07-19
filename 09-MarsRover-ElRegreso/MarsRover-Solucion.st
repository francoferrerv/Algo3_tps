!classDefinition: #TestLog category: 'MarsRover-Solucion'!
TestCase subclass: #TestLog
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!TestLog methodsFor: 'tests' stamp: 'FVF 7/17/2021 22:59:25'!
test01

	| log marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	log := Log with: marsrover.
	
	self assert: OrderedCollection new equals: log asOrderedCollection.! !

!TestLog methodsFor: 'tests' stamp: 'FVF 7/17/2021 22:34:33'!
test02

	| log marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	log := Log with: marsrover.
	marsrover processCommands: 'f'.
	
	self assert: (OrderedCollection with: (0@1) asString) equals: log asOrderedCollection.! !

!TestLog methodsFor: 'tests' stamp: 'FVF 7/17/2021 22:43:38'!
test03

	| log marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	log := Log with: marsrover.
	marsrover processCommands: 'b'.
	
	self assert: (OrderedCollection with: (0@-1) asString) equals: log asOrderedCollection.! !

!TestLog methodsFor: 'tests' stamp: 'FVF 7/17/2021 22:44:40'!
test04

	| log marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #East.
	log := Log with: marsrover.
	marsrover processCommands: 'f'.
	
	self assert: (OrderedCollection with: (1@0) asString) equals: log asOrderedCollection.! !

!TestLog methodsFor: 'tests' stamp: 'FVF 7/17/2021 22:44:56'!
test05

	| log marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #West.
	log := Log with: marsrover.
	marsrover processCommands: 'f'.
	
	self assert: (OrderedCollection with: (-1@0) asString) equals: log asOrderedCollection.! !

!TestLog methodsFor: 'tests' stamp: 'FVF 7/17/2021 22:53:57'!
test06

	| log marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	log := Log with: marsrover.
	marsrover processCommands: 'l'.
	
	self assert: (OrderedCollection with: 'West') equals: log asOrderedCollection.! !

!TestLog methodsFor: 'tests' stamp: 'FVF 7/17/2021 22:53:51'!
test07

	| log marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	log := Log with: marsrover.
	marsrover processCommands: 'r'.
	
	self assert: (OrderedCollection with: 'East') equals: log asOrderedCollection.! !

!TestLog methodsFor: 'tests' stamp: 'FVF 7/17/2021 22:54:14'!
test08

	| log marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #East.
	log := Log with: marsrover.
	marsrover processCommands: 'l'.
	
	self assert: (OrderedCollection with: 'North') equals: log asOrderedCollection.! !

!TestLog methodsFor: 'tests' stamp: 'FVF 7/17/2021 22:54:44'!
test09

	| log marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #East.
	log := Log with: marsrover.
	marsrover processCommands: 'r'.
	
	self assert: (OrderedCollection with: 'South') equals: log asOrderedCollection.! !

!TestLog methodsFor: 'tests' stamp: 'FVF 7/17/2021 22:57:49'!
test10

	| log marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	log := Log with: marsrover.
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

!TestWindow methodsFor: 'as yet unclassified' stamp: 'FVF 7/17/2021 23:25:16'!
test01

	| window marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	window := Window with: marsrover.
	
	self assert:  (0@0) equals: window getPosition.! !

!TestWindow methodsFor: 'as yet unclassified' stamp: 'FVF 7/17/2021 23:27:48'!
test02

	| window marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	window := Window with: marsrover.
	marsrover processCommands: 'f'.
	
	self assert: (0@1) equals: window getPosition.! !

!TestWindow methodsFor: 'as yet unclassified' stamp: 'FVF 7/17/2021 23:28:39'!
test03

	| window marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	window := Window with: marsrover.
	marsrover processCommands: 'b'.
	
	self assert: (0@-1) equals: window getPosition.! !


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

!Log methodsFor: 'as yet unclassified' stamp: 'FVF 7/17/2021 23:01:48'!
notifyChangeInHeading: aDirection

	registers add: aDirection asString.! !

!Log methodsFor: 'as yet unclassified' stamp: 'FVF 7/17/2021 22:32:40'!
notifyChangeInPosition: aPosition

	registers add: aPosition asString.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Log class' category: 'MarsRover-Solucion'!
Log class
	instanceVariableNames: ''!

!Log class methodsFor: 'as yet unclassified' stamp: 'FVF 7/17/2021 22:31:08'!
with: aRover
	
	| log |
	
	log := self new.
	aRover addTrackingSystem: log.
	
	^log.! !


!classDefinition: #MarsRover category: 'MarsRover-Solucion'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head trackingSystems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRover methodsFor: 'initialization' stamp: 'FVF 7/17/2021 22:23:31'!
initializeStartingAt: aPosition heading: aCardinalPoint 
	
	position := aPosition.
	head := MarsRoverHead of: self facing: aCardinalPoint.
	trackingSystems := nil.
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


!MarsRover methodsFor: 'dd - moving' stamp: 'FVF 7/17/2021 22:42:37'!
moveDown

	position := position + (0@-1).
	trackingSystems notifyChangeInPosition: position.! !

!MarsRover methodsFor: 'dd - moving' stamp: 'FVF 7/17/2021 22:42:32'!
moveLeft

	position := position + (-1@0).
	trackingSystems notifyChangeInPosition: position.! !

!MarsRover methodsFor: 'dd - moving' stamp: 'FVF 7/17/2021 22:42:26'!
moveRight

	position := position + (1@0).
	trackingSystems notifyChangeInPosition: position.! !

!MarsRover methodsFor: 'dd - moving' stamp: 'FVF 7/17/2021 22:42:19'!
moveUp

	position := position + (0@1).
	trackingSystems notifyChangeInPosition: position.! !


!MarsRover methodsFor: 'dd - heading' stamp: 'FVF 7/17/2021 23:00:53'!
headEast

	head := MarsRoverHeadFacingEast of: self.
	
	trackingSystems notifyChangeInHeading: #East.! !

!MarsRover methodsFor: 'dd - heading' stamp: 'FVF 7/17/2021 23:01:12'!
headNorth

	head := MarsRoverHeadFacingNorth of: self.
	
	trackingSystems notifyChangeInHeading: #North.! !

!MarsRover methodsFor: 'dd - heading' stamp: 'FVF 7/17/2021 23:01:24'!
headSouth

	head := MarsRoverHeadFacingSouth of: self.
	
	trackingSystems notifyChangeInHeading: #South.! !

!MarsRover methodsFor: 'dd - heading' stamp: 'FVF 7/17/2021 23:01:33'!
headWest

	head := MarsRoverHeadFacingWest of: self.
	
	trackingSystems notifyChangeInHeading: #West.
	! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'FVF 7/17/2021 22:28:52'!
addTrackingSystem: aSystem

	trackingSystems := aSystem.! !

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
	instanceVariableNames: 'registers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!Window methodsFor: 'as yet unclassified' stamp: 'FVF 7/17/2021 23:31:14'!
getPosition

	^0@0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Window class' category: 'MarsRover-Solucion'!
Window class
	instanceVariableNames: ''!

!Window class methodsFor: 'as yet unclassified' stamp: 'FVF 7/17/2021 23:26:50'!
with: aRover

	| window |
	
	window := self new.
	aRover addTrackingSystem: window.
	
	^window.! !
