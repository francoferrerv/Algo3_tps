!classDefinition: #TestLog category: 'MarsRover-Solucion'!
TestCase subclass: #TestLog
	instanceVariableNames: 'log positionLog directionLog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!TestLog methodsFor: 'tests' stamp: 'jb 7/22/2021 17:15:32'!
test01MarsRoverWithNoCommandsTheLogIsEmpty

	| marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	marsrover addPositionObserver: positionLog.
	marsrover addDirectionObserver: directionLog.
	
	self assert: log isEmpty.! !

!TestLog methodsFor: 'tests' stamp: 'jb 7/22/2021 17:15:32'!
test02TestLogContainsNewPositionWhenMarsRoverMovesForward

	| marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	marsrover addPositionObserver: positionLog.
	marsrover processCommands: 'f'.
	
	self deny: log isEmpty.
	self assert: (OrderedCollection with: (0@1) asString) equals: log getRegisters.! !

!TestLog methodsFor: 'tests' stamp: 'jb 7/22/2021 17:15:32'!
test03TestLogContainsNewPositionWhenMarsRoverMovesBackwards

	| marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	marsrover addPositionObserver: positionLog.
	marsrover processCommands: 'b'.
	
	self assert: (OrderedCollection with: (0@-1) asString) equals: log getRegisters.! !

!TestLog methodsFor: 'tests' stamp: 'jb 7/22/2021 17:15:32'!
test04TestLogContainsNewPositionWhenMarsRoverFacingEastMovesForward

	| marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #East.
	marsrover addPositionObserver: positionLog.
	marsrover processCommands: 'f'.
	
	self assert: (OrderedCollection with: (1@0) asString) equals: log getRegisters.! !

!TestLog methodsFor: 'tests' stamp: 'jb 7/22/2021 17:15:32'!
test05TestLogContainsNewPositionWhenMarsRoverFacingWestMovesForward

	| marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #West.
	marsrover addPositionObserver: positionLog.
	marsrover processCommands: 'f'.
	
	self assert: (OrderedCollection with: (-1@0) asString) equals: log getRegisters.! !

!TestLog methodsFor: 'tests' stamp: 'jb 7/22/2021 17:15:32'!
test06TestLogContainsNewDirectionWhenMarsRoverTurnsLeft

	| marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	marsrover addDirectionObserver: directionLog.
	marsrover processCommands: 'l'.
	
	self assert: (OrderedCollection with: 'West') equals: log getRegisters.! !

!TestLog methodsFor: 'tests' stamp: 'jb 7/22/2021 17:15:32'!
test07TestLogContainsNewDirectionWhenMarsRoverTurnsRight

	| marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	marsrover addDirectionObserver: directionLog.
	marsrover processCommands: 'r'.
	
	self assert: (OrderedCollection with: 'East') equals: log getRegisters.! !

!TestLog methodsFor: 'tests' stamp: 'jb 7/22/2021 17:15:32'!
test08TestLogContainsNewDirectionWhenMarsRoverFacingEastTurnsLeft

	| marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #East.
	marsrover addDirectionObserver: directionLog.
	marsrover processCommands: 'l'.
	
	self assert: (OrderedCollection with: 'North') equals: log getRegisters.! !

!TestLog methodsFor: 'tests' stamp: 'jb 7/22/2021 17:15:32'!
test09TestLogContainsNewDirectionWhenMarsRoverFacingEastTurnsRight

	| marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #East.
	marsrover addDirectionObserver: directionLog.
	marsrover processCommands: 'r'.
	
	self assert: (OrderedCollection with: 'South') equals: log getRegisters.! !

!TestLog methodsFor: 'tests' stamp: 'jb 7/22/2021 17:15:32'!
test10PositionAndDirectionLogOnMultipleCommandsRecordsChanges

	|  marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	marsrover addPositionObserver: positionLog.
	marsrover addDirectionObserver: directionLog.
	marsrover processCommands: 'fblr'.
	
	self assert: (OrderedCollection with: '0@1' with: '0@0' with: 'West' with: 'North') equals: log getRegisters.! !


!TestLog methodsFor: 'setUp' stamp: 'jb 7/22/2021 17:15:32'!
setUp

	log := Log new.
	
	positionLog := ObserverAdapter forObserver: log onChangeSendMessage: #notifyChangeInPosition:.	
	directionLog := ObserverAdapter forObserver: log onChangeSendMessage: #notifyChangeInHeading:.
	! !


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
	instanceVariableNames: 'window positionWindow directionWindow'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!TestWindow methodsFor: 'set up' stamp: 'jb 7/22/2021 17:16:21'!
setUp

	window := Window new.
	
	positionWindow := ObserverAdapter forObserver: window onChangeSendMessage: #notifyChangeInPosition:.
	directionWindow := ObserverAdapter forObserver: window onChangeSendMessage: #notifyChangeInHeading:.! !


!TestWindow methodsFor: 'tests' stamp: 'jb 7/22/2021 17:16:13'!
test01MarsRoverWithNoCommandsTheWindowHasNoPosition

	| marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	marsrover addPositionObserver: positionWindow.
	marsrover addDirectionObserver: directionWindow.
	
	self deny: window hasPosition.
	self deny: window hasDirection.! !

!TestWindow methodsFor: 'tests' stamp: 'jb 7/22/2021 17:16:47'!
test02TestWindowDisplaysNewPositionWhenMarsRoverMovesForward

	| marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	marsrover addPositionObserver: positionWindow.
	marsrover processCommands: 'f'.
	
	self assert: window hasPosition.
	self assert: '0@1' equals: window getPosition.! !

!TestWindow methodsFor: 'tests' stamp: 'jb 7/22/2021 17:16:03'!
test03TestWindowDisplaysNewPositionWhenMarsRoverMovesBackwards

	| marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	marsrover addPositionObserver: positionWindow.
	marsrover processCommands: 'b'.
	
	self assert: '0@-1' equals: window getPosition.! !

!TestWindow methodsFor: 'tests' stamp: 'jb 7/22/2021 17:16:03'!
test04TestWindowDisplaysNewPositionWhenMarsRoverFacingEastMovesForward

	| marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #East.
	marsrover addPositionObserver: positionWindow.
	marsrover processCommands: 'f'.
	
	self assert: '1@0' equals: window getPosition.! !

!TestWindow methodsFor: 'tests' stamp: 'jb 7/22/2021 17:16:03'!
test05TestWindowDisplaysNewPositionWhenMarsRoverFacingWestMovesForward

	| marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #West.
	marsrover addPositionObserver: positionWindow.
	marsrover processCommands: 'f'.
	
	self assert: '-1@0'  equals: window getPosition.! !

!TestWindow methodsFor: 'tests' stamp: 'jb 7/22/2021 17:17:07'!
test06TestWindowDisplaysNewPositionWhenMarsRoverTurnsLeft

	| marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	marsrover addDirectionObserver: directionWindow.
	marsrover processCommands: 'l'.
	
	self assert: window hasDirection.
	self assert:  'West' equals: window getDirection! !

!TestWindow methodsFor: 'tests' stamp: 'jb 7/22/2021 17:16:13'!
test07TestWindowDisplaysNewPositionWhenMarsRoverTurnsRight

	| marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	marsrover addDirectionObserver: directionWindow.
	marsrover processCommands: 'r'.
	
	self assert:  'East' equals: window getDirection! !

!TestWindow methodsFor: 'tests' stamp: 'jb 7/22/2021 17:16:13'!
test08TestWindowDisplaysNewPositionWhenMarsRoverFacingEastTurnsLeft

	| marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #East.
	marsrover addDirectionObserver: directionWindow.
	marsrover processCommands: 'l'.
	
	self assert:  'North' equals: window getDirection! !

!TestWindow methodsFor: 'tests' stamp: 'jb 7/22/2021 17:16:13'!
test09TestWindowDisplaysNewPositionWhenMarsRoverFacingEastTurnsRight

	| marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #East.
	marsrover addDirectionObserver: directionWindow.
	marsrover processCommands: 'r'.
	
	self assert:  'South' equals: window getDirection! !

!TestWindow methodsFor: 'tests' stamp: 'jb 7/22/2021 17:16:13'!
test10PositionAndDirectionWindowOnMultipleCommandsRecordsChanges

	| marsrover |
	
	marsrover := MarsRover startingAt: (0@0) heading: #North.
	marsrover addPositionObserver: positionWindow.
	marsrover addDirectionObserver: directionWindow.
	marsrover processCommands: 'fblr'.
	
	self assert: '0@0' equals: window getPosition.
	self assert: 'North' equals: window getDirection .! !


!classDefinition: #Log category: 'MarsRover-Solucion'!
Object subclass: #Log
	instanceVariableNames: 'registers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!Log methodsFor: 'initialization' stamp: 'FVF 7/17/2021 22:31:37'!
initialize

	registers := OrderedCollection new.! !


!Log methodsFor: 'accessing' stamp: 'FVF 7/22/2021 11:37:32'!
getRegisters

	^registers.
	! !

!Log methodsFor: 'accessing' stamp: 'FVF 7/22/2021 11:12:08'!
isEmpty

	^registers isEmpty.! !


!Log methodsFor: 'notify changes' stamp: 'FVF 7/19/2021 21:21:05'!
notifyChangeInHeading: aDirection
	
	(aDirection isKindOf: MarsRoverHeadFacingNorth) ifTrue: [registers add: 'North'.].
	(aDirection isKindOf: MarsRoverHeadFacingWest) ifTrue: [registers add: 'West'.].
	(aDirection isKindOf: MarsRoverHeadFacingSouth) ifTrue: [registers add: 'South'.].
	(aDirection isKindOf: MarsRoverHeadFacingEast) ifTrue: [registers add: 'East'.].
	! !

!Log methodsFor: 'notify changes' stamp: 'FVF 7/17/2021 22:32:40'!
notifyChangeInPosition: aPosition

	registers add: aPosition asString.

	! !


!classDefinition: #MarsRover category: 'MarsRover-Solucion'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head positionObservers directionObservers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRover methodsFor: 'initialization' stamp: 'FVF 7/22/2021 11:36:09'!
initializeStartingAt: aPosition heading: aCardinalPoint 
	
	position := Observable withInitialValue: aPosition.
	head :=  Observable withInitialValue: (MarsRoverHead of: self facing: aCardinalPoint).
	positionObservers := OrderedCollection new.
	directionObservers := OrderedCollection new.
	! !


!MarsRover methodsFor: 'process commands' stamp: 'LL 6/30/2021 15:54:14'!
processCommands: aStringWithCommands

	aStringWithCommands do: [ :aCommand | 
		self assertCommandIsValid: aCommand.
		self processCommand: aCommand.
	].
	
! !


!MarsRover methodsFor: 'testing' stamp: 'jb 7/22/2021 17:12:52'!
isAt: aPosition heading: aCardinalPoint

	^ ((position getValue) = aPosition) and: [ (head getValue) isHeading: aCardinalPoint ]! !


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

!MarsRover methodsFor: 'dd - moving' stamp: 'FVF 7/20/2021 12:50:40'!
step: aStep

	position setValue: (position value + aStep).
	! !


!MarsRover methodsFor: 'dd - heading' stamp: 'FVF 7/20/2021 12:29:03'!
face: aMarsroverHead

	head setValue: (aMarsroverHead of: self).
	! !

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


!MarsRover methodsFor: 'add observers' stamp: 'FVF 7/22/2021 11:34:33'!
addDirectionObserver: aTracker

	head addObserver: aTracker.
	! !

!MarsRover methodsFor: 'add observers' stamp: 'FVF 7/22/2021 11:34:57'!
addPositionObserver: aTracker

	position addObserver: aTracker! !

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

!MarsRoverHead methodsFor: 'rotations' stamp: 'LL 6/30/2021 16:36:46'!
rotateLeft

	self subclassResponsibility! !

!MarsRoverHead methodsFor: 'rotations' stamp: 'LL 6/30/2021 16:36:43'!
rotateRight

	self subclassResponsibility! !


!MarsRoverHead methodsFor: 'initialization' stamp: 'LL 6/30/2021 16:17:57'!
initializeOf: aMarsRover

	marsRover := aMarsRover! !


!MarsRoverHead methodsFor: 'movements' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	self subclassResponsibility! !

!MarsRoverHead methodsFor: 'movements' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	self subclassResponsibility! !


!MarsRoverHead methodsFor: 'accessing' stamp: 'LL 6/30/2021 19:46:16'!
isHeading: aCardinalPoint

	^self class whenFacing: aCardinalPoint

	! !

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

!MarsRoverHeadFacingEast methodsFor: 'movements' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveLeft.

	! !

!MarsRoverHeadFacingEast methodsFor: 'movements' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveRight.

	! !


!MarsRoverHeadFacingEast methodsFor: 'rotations' stamp: 'LL 6/30/2021 17:06:22'!
rotateLeft

	^marsRover headNorth.

	! !

!MarsRoverHeadFacingEast methodsFor: 'rotations' stamp: 'LL 6/30/2021 17:10:14'!
rotateRight

	^marsRover headSouth.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingEast class' category: 'MarsRover-Solucion'!
MarsRoverHeadFacingEast class
	instanceVariableNames: ''!

!MarsRoverHeadFacingEast class methodsFor: 'accessing' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #East! !


!classDefinition: #MarsRoverHeadFacingNorth category: 'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingNorth methodsFor: 'movements' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveDown.! !

!MarsRoverHeadFacingNorth methodsFor: 'movements' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveUp.! !


!MarsRoverHeadFacingNorth methodsFor: 'rotations' stamp: 'LL 6/30/2021 17:06:33'!
rotateLeft

	^marsRover headWest.! !

!MarsRoverHeadFacingNorth methodsFor: 'rotations' stamp: 'LL 6/30/2021 17:10:58'!
rotateRight

	^marsRover headEast.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingNorth class' category: 'MarsRover-Solucion'!
MarsRoverHeadFacingNorth class
	instanceVariableNames: ''!

!MarsRoverHeadFacingNorth class methodsFor: 'accessing' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #North! !


!classDefinition: #MarsRoverHeadFacingSouth category: 'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingSouth methodsFor: 'movements' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveUp.! !

!MarsRoverHeadFacingSouth methodsFor: 'movements' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveDown! !


!MarsRoverHeadFacingSouth methodsFor: 'rotations' stamp: 'LL 6/30/2021 17:06:43'!
rotateLeft

	^marsRover headEast.! !

!MarsRoverHeadFacingSouth methodsFor: 'rotations' stamp: 'LL 6/30/2021 17:12:30'!
rotateRight

	^marsRover headWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingSouth class' category: 'MarsRover-Solucion'!
MarsRoverHeadFacingSouth class
	instanceVariableNames: ''!

!MarsRoverHeadFacingSouth class methodsFor: 'accessing' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #South! !


!classDefinition: #MarsRoverHeadFacingWest category: 'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingWest methodsFor: 'movements' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveRight.! !

!MarsRoverHeadFacingWest methodsFor: 'movements' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveLeft.! !


!MarsRoverHeadFacingWest methodsFor: 'rotations' stamp: 'LL 6/30/2021 17:06:52'!
rotateLeft

	^marsRover headSouth.! !

!MarsRoverHeadFacingWest methodsFor: 'rotations' stamp: 'LL 6/30/2021 17:12:44'!
rotateRight

	^marsRover headNorth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingWest class' category: 'MarsRover-Solucion'!
MarsRoverHeadFacingWest class
	instanceVariableNames: ''!

!MarsRoverHeadFacingWest class methodsFor: 'accessing' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #West! !


!classDefinition: #Observable category: 'MarsRover-Solucion'!
Object subclass: #Observable
	instanceVariableNames: 'value observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!Observable methodsFor: 'initialization' stamp: 'FVF 7/20/2021 12:31:31'!
initializeWithValue: aValue 

	value := aValue.
	observers := OrderedCollection new.
	! !


!Observable methodsFor: 'private' stamp: 'FVF 7/20/2021 12:40:41'!
doesNotUnderstand: aMessage

	^aMessage sendTo: value ! !

!Observable methodsFor: 'private' stamp: 'FVF 7/20/2021 12:58:57'!
notifyObservers

	observers do: [:observer| observer notifyChange: value].! !


!Observable methodsFor: 'main protocol' stamp: 'FVF 7/20/2021 11:49:55'!
addObserver: anObserver

	observers add: anObserver! !

!Observable methodsFor: 'main protocol' stamp: 'jb 7/22/2021 17:08:01'!
getValue
	^value! !

!Observable methodsFor: 'main protocol' stamp: 'FVF 7/20/2021 11:57:10'!
setValue: aValue

	value := aValue.
	self notifyObservers.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Observable class' category: 'MarsRover-Solucion'!
Observable class
	instanceVariableNames: ''!

!Observable class methodsFor: 'instance creation' stamp: 'FVF 7/20/2021 12:11:55'!
withInitialValue: aValue 

	^self new initializeWithValue: aValue 
	! !


!classDefinition: #ObserverAdapter category: 'MarsRover-Solucion'!
Object subclass: #ObserverAdapter
	instanceVariableNames: 'onChangeMessage observer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!ObserverAdapter methodsFor: 'private' stamp: 'FVF 7/20/2021 12:40:10'!
doesNotUnderstand: aMessage

	^aMessage sendTo: observer 

	! !


!ObserverAdapter methodsFor: 'main protocol' stamp: 'FVF 7/20/2021 13:03:28'!
notifyChange: aValue

	onChangeMessage sendTo: observer with: aValue! !


!ObserverAdapter methodsFor: 'initialization' stamp: 'FVF 7/20/2021 12:22:57'!
initializeWith: anObserver onChange: aMessage

	observer  := anObserver.
	onChangeMessage := aMessage.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ObserverAdapter class' category: 'MarsRover-Solucion'!
ObserverAdapter class
	instanceVariableNames: ''!

!ObserverAdapter class methodsFor: 'instance creation' stamp: 'FVF 7/20/2021 13:05:07'!
forObserver: anObserver onChangeSendMessage: aMessage

	^self new initializeWith: anObserver onChange: aMessage.

	! !


!classDefinition: #Window category: 'MarsRover-Solucion'!
Object subclass: #Window
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!Window methodsFor: 'initialization' stamp: 'FVF 7/20/2021 11:13:04'!
initialize

	position := nil.
	direction := nil.! !


!Window methodsFor: 'notify changes' stamp: 'FVF 7/19/2021 21:34:46'!
notifyChangeInHeading: aDirection
	
	(aDirection isKindOf: MarsRoverHeadFacingNorth) ifTrue: [direction := 'North'.].
	(aDirection isKindOf: MarsRoverHeadFacingWest) ifTrue: [direction  := 'West'.].
	(aDirection isKindOf: MarsRoverHeadFacingSouth) ifTrue: [direction := 'South'.].
	(aDirection isKindOf: MarsRoverHeadFacingEast) ifTrue: [direction := 'East'.].
	! !

!Window methodsFor: 'notify changes' stamp: 'FVF 7/19/2021 21:35:00'!
notifyChangeInPosition: aPosition

	position := aPosition asString.! !


!Window methodsFor: 'accessing' stamp: 'FVF 7/19/2021 21:35:51'!
getDirection

	^direction! !

!Window methodsFor: 'accessing' stamp: 'FVF 7/19/2021 21:35:57'!
getPosition

	^position! !

!Window methodsFor: 'accessing' stamp: 'jb 7/22/2021 17:13:54'!
hasDirection

	^ (direction = nil) not.! !

!Window methodsFor: 'accessing' stamp: 'FVF 7/20/2021 11:12:13'!
hasPosition

	^ (position = nil) not.! !
