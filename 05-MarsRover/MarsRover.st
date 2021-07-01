!classDefinition: #TestsMarsRover category: 'MarsRover'!
TestCase subclass: #TestsMarsRover
	instanceVariableNames: 'roverAtOriginFacingNorth'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!TestsMarsRover methodsFor: 'helpers' stamp: 'jb 7/1/2021 12:24:24'!
assertThatRover: aRover raisesErrorOnCommand: aCommand endAtPosition: aPosition andSatisfiesThat: aBlock

	self should: [aRover processCommands: aCommand]
	raise: Error
	withExceptionDo: [:anException |
		self assert: (aRover positionIs: aPosition).
		self assert: aBlock value.
	]! !

!TestsMarsRover methodsFor: 'helpers' stamp: 'jb 6/30/2021 12:09:51'!
assertThatRover: aRover withCommands: aStringOfCommands endsAtPosition: aPoint andSatisfiesThat: isFacingBlock

	aRover processCommands: aStringOfCommands.
	
	self assert: (aRover positionIs: aPoint).
	self assert: isFacingBlock value.! !


!TestsMarsRover methodsFor: 'setUp/tearDown' stamp: 'jb 7/1/2021 11:35:12'!
setUp
	
	roverAtOriginFacingNorth _ MarsRover facing: 'N' positionedAt: (0@0).! !


!TestsMarsRover methodsFor: 'tests' stamp: 'jb 6/30/2021 12:24:14'!
test01RoverWithNoCommandsDoesntDoAnything
	| rover |
	
	rover _ roverAtOriginFacingNorth.
	
	self assertThatRover: rover
		withCommands: ''
		endsAtPosition: (0@0)
		andSatisfiesThat: [rover isFacingNorth].! !

!TestsMarsRover methodsFor: 'tests' stamp: 'jb 6/30/2021 12:41:28'!
test02BisRoverAtOriginWhenCommandedToMoveForwardMovesForwardAndDoesntStayAtOrigin
	
	| rover |
	rover _ roverAtOriginFacingNorth.
	
	self assertThatRover: rover
		withCommands: 'f'
		endsAtPosition: (0@1)
		andSatisfiesThat: [rover isFacingNorth].
	
	self deny: (rover positionIs: 0@0).! !

!TestsMarsRover methodsFor: 'tests' stamp: 'jb 6/30/2021 12:41:39'!
test02RoverAtOriginWhenCommandedToMoveForwardMovesForward
	
	| rover |
	rover _ roverAtOriginFacingNorth.
	
	self assertThatRover: rover
		withCommands: 'f'
		endsAtPosition: (0@1)
		andSatisfiesThat: [rover isFacingNorth].! !

!TestsMarsRover methodsFor: 'tests' stamp: 'jb 6/30/2021 12:39:20'!
test03RoverAtOriginWhenCommandedToMoveBackMovesBack
	| rover |
	
	rover _ roverAtOriginFacingNorth.
	
	self assertThatRover: rover
		withCommands: 'b'
		endsAtPosition: (0@-1)
		andSatisfiesThat: [rover isFacingNorth].! !

!TestsMarsRover methodsFor: 'tests' stamp: 'jb 6/30/2021 12:35:23'!
test04RoverFacingNorthWhenCommandedToTurnRightFacesEast
	
	| rover |
	rover _ roverAtOriginFacingNorth.
	
	self assertThatRover: rover
		withCommands: 'r'
		endsAtPosition: (0@0)
		andSatisfiesThat: [rover isFacingEast].! !

!TestsMarsRover methodsFor: 'tests' stamp: 'jb 6/30/2021 12:35:52'!
test05RoverFacingNorthWhenCommandedToTurnRightOnlyFacesEast
	
	| rover |
	rover _ roverAtOriginFacingNorth.
	
	self assertThatRover: rover
		withCommands: 'r'
		endsAtPosition: (0@0)
		andSatisfiesThat: [rover isFacingEast].
	
	self deny: (rover isFacingNorth).
	self deny: (rover isFacingSouth).
	self deny: (rover isFacingWest).! !

!TestsMarsRover methodsFor: 'tests' stamp: 'jb 6/30/2021 12:36:13'!
test06RoverFacingNorthWhenCommandedToTurnLeftFacesWest
	
	| rover |
	rover _ roverAtOriginFacingNorth.
	
	self assertThatRover: rover
		withCommands: 'l'
		endsAtPosition: (0@0)
		andSatisfiesThat: [rover isFacingWest].! !

!TestsMarsRover methodsFor: 'tests' stamp: 'jb 7/1/2021 11:35:12'!
test07RoverFacingEastWhenCommandedToTurnRightFacesSouth
	
	| rover |
	rover := MarsRover facing: 'E' positionedAt: (0@0).
	
	self assertThatRover: rover
		withCommands: 'r'
		endsAtPosition: (0@0)
		andSatisfiesThat: [rover isFacingSouth].! !

!TestsMarsRover methodsFor: 'tests' stamp: 'jb 7/1/2021 11:35:12'!
test08RoverNotAtOriginWhenCommandedTomoveForwardMovesForward
	
	| rover |
	rover := MarsRover facing: 'N' positionedAt: (3@3).
	
	self assertThatRover: rover
		withCommands: 'f'
		endsAtPosition: (3@4)
		andSatisfiesThat: [rover isFacingNorth].! !

!TestsMarsRover methodsFor: 'tests' stamp: 'jb 6/30/2021 12:21:15'!
test09RoverRaisesExceptionOnUnkownCommand
	
	| rover |
	rover _ roverAtOriginFacingNorth.
	
	self assertThatRover: rover
		raisesErrorOnCommand: 'x'
		endAtPosition: (0@0)
		andSatisfiesThat: [rover isFacingNorth].! !

!TestsMarsRover methodsFor: 'tests' stamp: 'jb 6/30/2021 12:38:00'!
test10RoverWhenGivenCommandWithMoreThanOneInstructionFollowsAccordingly
	
	| rover |
	rover _ roverAtOriginFacingNorth.
	
	self assertThatRover: rover
		withCommands: 'ff'
		endsAtPosition: (0@2)
		andSatisfiesThat: [rover isFacingNorth].! !

!TestsMarsRover methodsFor: 'tests' stamp: 'jb 7/1/2021 11:35:12'!
test11RoverStopsExecutingCommandsAfterUnknownCommand
	
	| rover |
	rover := MarsRover facing: 'S' positionedAt: (2@5).
	
	self assertThatRover: rover
		raisesErrorOnCommand: 'ffrfxflbrb'
		endAtPosition: (1@3)
		andSatisfiesThat: [rover isFacingWest].! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'currentPosition currentDirection commands'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'accessing' stamp: 'jb 6/29/2021 11:32:10'!
isFacingEast
	^currentDirection = 'E'! !

!MarsRover methodsFor: 'accessing' stamp: 'jb 6/29/2021 11:31:57'!
isFacingNorth
	^currentDirection = 'N'! !

!MarsRover methodsFor: 'accessing' stamp: 'jb 6/29/2021 11:40:08'!
isFacingSouth
	^currentDirection = 'S'.! !

!MarsRover methodsFor: 'accessing' stamp: 'jb 6/29/2021 11:33:07'!
isFacingWest
	^currentDirection = 'W'! !

!MarsRover methodsFor: 'accessing' stamp: 'jb 7/1/2021 11:40:06'!
positionIs: aPosition
	^currentPosition = aPosition! !


!MarsRover methodsFor: 'initialization' stamp: 'jb 7/1/2021 11:32:14'!
initializeCommands

	commands _ 	Dictionary new.
	commands add: ('f' -> [self moveForward]).
	commands add: ('b' -> [self moveBack]).
	commands add: ('l' -> [self turnLeft]).
	commands add: ('r' -> [self turnRight]).! !

!MarsRover methodsFor: 'initialization' stamp: 'jb 7/1/2021 11:32:31'!
initializeFacing: aCardinalPoint positionedAt: aPoint
	currentDirection _ aCardinalPoint.
	currentPosition _ aPoint.
	self initializeCommands.! !


!MarsRover methodsFor: 'private' stamp: 'jb 7/1/2021 12:20:14'!
navigationSystem
	^MarsRoverNavigationSystem withRoverFacing: currentDirection! !

!MarsRover methodsFor: 'private' stamp: 'jb 7/1/2021 12:23:28'!
processSingleCommand: aCommand
	
	(commands at: aCommand ifAbsent: [ self raiseUnknownCommandError ]) value.
	
	
		
		! !

!MarsRover methodsFor: 'private' stamp: 'jb 7/1/2021 12:23:14'!
raiseUnknownCommandError
	^self error: self class unknownCommandErrorMessage! !


!MarsRover methodsFor: 'operations' stamp: 'jb 6/29/2021 12:41:32'!
processCommands: aStringContainingCommands
	aStringContainingCommands do: [:aSingleCommand | self processSingleCommand: aSingleCommand asString].! !


!MarsRover methodsFor: 'movement' stamp: 'jb 7/1/2021 12:13:13'!
moveBack
	
	currentPosition _ currentPosition + (self navigationSystem) backwardsVector.! !

!MarsRover methodsFor: 'movement' stamp: 'jb 7/1/2021 12:12:51'!
moveForward
	
	currentPosition _ currentPosition + (self navigationSystem) forwardVector.! !

!MarsRover methodsFor: 'movement' stamp: 'jb 7/1/2021 12:18:21'!
turnLeft
	
	currentDirection _ (self navigationSystem) leftDirection.! !

!MarsRover methodsFor: 'movement' stamp: 'jb 7/1/2021 12:18:12'!
turnRight
	
	currentDirection _ (self navigationSystem) rightDirection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'creation' stamp: 'jb 7/1/2021 11:35:12'!
facing: aCardinalPoint positionedAt: aPoint
	^MarsRover new initializeFacing: aCardinalPoint positionedAt: aPoint.! !


!MarsRover class methodsFor: 'error messages' stamp: 'jb 7/1/2021 12:22:05'!
unknownCommandErrorMessage
	^'The command could not be understood'! !


!classDefinition: #MarsRoverNavigationSystem category: 'MarsRover'!
Object subclass: #MarsRoverNavigationSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverNavigationSystem methodsFor: 'as yet unclassified' stamp: 'jb 7/1/2021 12:13:13'!
backwardsVector
	^self forwardVector * -1! !

!MarsRoverNavigationSystem methodsFor: 'as yet unclassified' stamp: 'jb 7/1/2021 12:12:51'!
forwardVector
	self subclassResponsibility.! !

!MarsRoverNavigationSystem methodsFor: 'as yet unclassified' stamp: 'jb 7/1/2021 12:14:21'!
leftDirection
	self subclassResponsibility.! !

!MarsRoverNavigationSystem methodsFor: 'as yet unclassified' stamp: 'jb 7/1/2021 12:14:34'!
rightDirection
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverNavigationSystem class' category: 'MarsRover'!
MarsRoverNavigationSystem class
	instanceVariableNames: ''!

!MarsRoverNavigationSystem class methodsFor: 'as yet unclassified' stamp: 'jb 7/1/2021 12:09:39'!
canHandle: aDirection
	self subclassResponsibility.! !

!MarsRoverNavigationSystem class methodsFor: 'as yet unclassified' stamp: 'jb 7/1/2021 12:19:56'!
withRoverFacing: aDirection
	^(self subclasses detect: [:subclass | subclass canHandle: aDirection]) new.! !


!classDefinition: #MarsRoverIsFacingEast category: 'MarsRover'!
MarsRoverNavigationSystem subclass: #MarsRoverIsFacingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverIsFacingEast methodsFor: 'as yet unclassified' stamp: 'jb 7/1/2021 12:12:51'!
forwardVector
	^(1@0)! !

!MarsRoverIsFacingEast methodsFor: 'as yet unclassified' stamp: 'jb 7/1/2021 12:15:04'!
leftDirection
	^'N'! !

!MarsRoverIsFacingEast methodsFor: 'as yet unclassified' stamp: 'jb 7/1/2021 12:16:22'!
rightDirection
	^'S'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverIsFacingEast class' category: 'MarsRover'!
MarsRoverIsFacingEast class
	instanceVariableNames: ''!

!MarsRoverIsFacingEast class methodsFor: 'as yet unclassified' stamp: 'jb 7/1/2021 12:10:02'!
canHandle: aDirection
	^aDirection = 'E'! !


!classDefinition: #MarsRoverIsFacingNorth category: 'MarsRover'!
MarsRoverNavigationSystem subclass: #MarsRoverIsFacingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverIsFacingNorth methodsFor: 'as yet unclassified' stamp: 'jb 7/1/2021 12:12:51'!
forwardVector
	^(0@1)! !

!MarsRoverIsFacingNorth methodsFor: 'as yet unclassified' stamp: 'jb 7/1/2021 12:15:37'!
leftDirection
	^'W'! !

!MarsRoverIsFacingNorth methodsFor: 'as yet unclassified' stamp: 'jb 7/1/2021 12:16:37'!
rightDirection
	^'E'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverIsFacingNorth class' category: 'MarsRover'!
MarsRoverIsFacingNorth class
	instanceVariableNames: ''!

!MarsRoverIsFacingNorth class methodsFor: 'as yet unclassified' stamp: 'jb 7/1/2021 12:10:33'!
canHandle: aDirection
	^aDirection = 'N'! !


!classDefinition: #MarsRoverIsFacingSouth category: 'MarsRover'!
MarsRoverNavigationSystem subclass: #MarsRoverIsFacingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverIsFacingSouth methodsFor: 'as yet unclassified' stamp: 'jb 7/1/2021 12:12:51'!
forwardVector
	^(0@-1)! !

!MarsRoverIsFacingSouth methodsFor: 'as yet unclassified' stamp: 'jb 7/1/2021 12:15:26'!
leftDirection
	^'E'! !

!MarsRoverIsFacingSouth methodsFor: 'as yet unclassified' stamp: 'jb 7/1/2021 12:16:48'!
rightDirection
	^'W'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverIsFacingSouth class' category: 'MarsRover'!
MarsRoverIsFacingSouth class
	instanceVariableNames: ''!

!MarsRoverIsFacingSouth class methodsFor: 'as yet unclassified' stamp: 'jb 7/1/2021 12:10:40'!
canHandle: aDirection
	^aDirection = 'S'! !


!classDefinition: #MarsRoverIsFacingWest category: 'MarsRover'!
MarsRoverNavigationSystem subclass: #MarsRoverIsFacingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverIsFacingWest methodsFor: 'as yet unclassified' stamp: 'jb 7/1/2021 12:12:51'!
forwardVector
	^(-1@0)! !

!MarsRoverIsFacingWest methodsFor: 'as yet unclassified' stamp: 'jb 7/1/2021 12:15:47'!
leftDirection
	^'S'! !

!MarsRoverIsFacingWest methodsFor: 'as yet unclassified' stamp: 'jb 7/1/2021 12:16:56'!
rightDirection
	^'N'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverIsFacingWest class' category: 'MarsRover'!
MarsRoverIsFacingWest class
	instanceVariableNames: ''!

!MarsRoverIsFacingWest class methodsFor: 'as yet unclassified' stamp: 'jb 7/1/2021 12:10:47'!
canHandle: aDirection
	^aDirection = 'W'! !
