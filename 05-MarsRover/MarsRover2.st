!classDefinition: #Tests category: 'MarsRover2'!
TestCase subclass: #Tests
	instanceVariableNames: 'roverAtOriginFacingNorth'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2'!

!Tests methodsFor: 'helpers' stamp: 'jb 6/30/2021 12:21:15'!
assertThatRover: aRover raisesErrorOnCommand: aCommand endAtPosition: aPosition andSatisfiesThat: aBlock

	self should: [aRover processCommands: aCommand]
	raise: Error
	withExceptionDo: [:anException |
		self assert: (aRover positionIs: aPosition).
		self assert: aBlock value.
	]! !

!Tests methodsFor: 'helpers' stamp: 'jb 6/30/2021 12:09:51'!
assertThatRover: aRover withCommands: aStringOfCommands endsAtPosition: aPoint andSatisfiesThat: isFacingBlock

	aRover processCommands: aStringOfCommands.
	
	self assert: (aRover positionIs: aPoint).
	self assert: isFacingBlock value.! !


!Tests methodsFor: 'setUp/tearDown' stamp: 'jb 6/30/2021 11:47:51'!
setUp
	
	roverAtOriginFacingNorth _ Rover2 facing: 'N' positionedAt: (0@0).! !


!Tests methodsFor: 'tests' stamp: 'jb 6/30/2021 12:24:14'!
test01RoverWithNoCommandsDoesntDoAnything
	| rover |
	
	rover _ roverAtOriginFacingNorth.
	
	self assertThatRover: rover
		withCommands: ''
		endsAtPosition: (0@0)
		andSatisfiesThat: [rover isFacingNorth].! !

!Tests methodsFor: 'tests' stamp: 'jb 6/30/2021 12:41:28'!
test02BisRoverAtOriginWhenCommandedToMoveForwardMovesForwardAndDoesntStayAtOrigin
	
	| rover |
	rover _ roverAtOriginFacingNorth.
	
	self assertThatRover: rover
		withCommands: 'f'
		endsAtPosition: (0@1)
		andSatisfiesThat: [rover isFacingNorth].
	
	self deny: (rover positionIs: 0@0).! !

!Tests methodsFor: 'tests' stamp: 'jb 6/30/2021 12:41:39'!
test02RoverAtOriginWhenCommandedToMoveForwardMovesForward
	
	| rover |
	rover _ roverAtOriginFacingNorth.
	
	self assertThatRover: rover
		withCommands: 'f'
		endsAtPosition: (0@1)
		andSatisfiesThat: [rover isFacingNorth].! !

!Tests methodsFor: 'tests' stamp: 'jb 6/30/2021 12:39:20'!
test03RoverAtOriginWhenCommandedToMoveBackMovesBack
	| rover |
	
	rover _ roverAtOriginFacingNorth.
	
	self assertThatRover: rover
		withCommands: 'b'
		endsAtPosition: (0@-1)
		andSatisfiesThat: [rover isFacingNorth].! !

!Tests methodsFor: 'tests' stamp: 'jb 6/30/2021 12:35:23'!
test04RoverFacingNorthWhenCommandedToTurnRightFacesEast
	
	| rover |
	rover _ roverAtOriginFacingNorth.
	
	self assertThatRover: rover
		withCommands: 'r'
		endsAtPosition: (0@0)
		andSatisfiesThat: [rover isFacingEast].! !

!Tests methodsFor: 'tests' stamp: 'jb 6/30/2021 12:35:52'!
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

!Tests methodsFor: 'tests' stamp: 'jb 6/30/2021 12:36:13'!
test06RoverFacingNorthWhenCommandedToTurnLeftFacesWest
	
	| rover |
	rover _ roverAtOriginFacingNorth.
	
	self assertThatRover: rover
		withCommands: 'l'
		endsAtPosition: (0@0)
		andSatisfiesThat: [rover isFacingWest].! !

!Tests methodsFor: 'tests' stamp: 'jb 6/30/2021 12:34:56'!
test07RoverFacingEastWhenCommandedToTurnRightFacesSouth
	
	| rover |
	rover := Rover2 facing: 'E' positionedAt: (0@0).
	
	self assertThatRover: rover
		withCommands: 'r'
		endsAtPosition: (0@0)
		andSatisfiesThat: [rover isFacingSouth].! !

!Tests methodsFor: 'tests' stamp: 'jb 6/30/2021 12:37:11'!
test08RoverNotAtOriginWhenCommandedTomoveForwardMovesForward
	
	| rover |
	rover := Rover2 facing: 'N' positionedAt: (3@3).
	
	self assertThatRover: rover
		withCommands: 'f'
		endsAtPosition: (3@4)
		andSatisfiesThat: [rover isFacingNorth].! !

!Tests methodsFor: 'tests' stamp: 'jb 6/30/2021 12:21:15'!
test09RoverRaisesExceptionOnUnkownCommand
	
	| rover |
	rover _ roverAtOriginFacingNorth.
	
	self assertThatRover: rover
		raisesErrorOnCommand: 'x'
		endAtPosition: (0@0)
		andSatisfiesThat: [rover isFacingNorth].! !

!Tests methodsFor: 'tests' stamp: 'jb 6/30/2021 12:38:00'!
test10RoverWhenGivenCommandWithMoreThanOneInstructionFollowsAccordingly
	
	| rover |
	rover _ roverAtOriginFacingNorth.
	
	self assertThatRover: rover
		withCommands: 'ff'
		endsAtPosition: (0@2)
		andSatisfiesThat: [rover isFacingNorth].! !

!Tests methodsFor: 'tests' stamp: 'jb 6/30/2021 12:21:15'!
test11RoverStopsExecutingCommandsAfterUnknownCommand
	
	| rover |
	rover := Rover2 facing: 'S' positionedAt: (2@5).
	
	self assertThatRover: rover
		raisesErrorOnCommand: 'ffrfxflbrb'
		endAtPosition: (1@3)
		andSatisfiesThat: [rover isFacingWest].! !


!classDefinition: #Command category: 'MarsRover2'!
Object subclass: #Command
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2'!

!Command methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 13:12:09'!
performCommandWithRover: aRover
	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Command class' category: 'MarsRover2'!
Command class
	instanceVariableNames: ''!

!Command class methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 13:09:39'!
canHandle: aCommand
	self subclassResponsibility! !

!Command class methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 13:21:00'!
fromCharacter: aCommand
	^(self subclasses detect: [:subclass | subclass canHandle: aCommand] ifNone: NotRecognizedCommand ) new.! !


!classDefinition: #Back category: 'MarsRover2'!
Command subclass: #Back
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2'!

!Back methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 13:12:22'!
performCommandWithRover: aRover
	aRover moveBack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Back class' category: 'MarsRover2'!
Back class
	instanceVariableNames: ''!

!Back class methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 13:10:25'!
canHandle: aCommand
	^aCommand = 'b'! !


!classDefinition: #Forward category: 'MarsRover2'!
Command subclass: #Forward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2'!

!Forward methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 13:12:45'!
performCommandWithRover: aRover
	aRover moveForward.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Forward class' category: 'MarsRover2'!
Forward class
	instanceVariableNames: ''!

!Forward class methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 13:10:39'!
canHandle: aCommand
	^aCommand = 'f'! !


!classDefinition: #Left category: 'MarsRover2'!
Command subclass: #Left
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2'!

!Left methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 13:12:59'!
performCommandWithRover: aRover
	aRover turnLeft.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Left class' category: 'MarsRover2'!
Left class
	instanceVariableNames: ''!

!Left class methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 13:10:55'!
canHandle: aCommand
	^aCommand = 'l'! !


!classDefinition: #NotRecognizedCommand category: 'MarsRover2'!
Command subclass: #NotRecognizedCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2'!

!NotRecognizedCommand methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 13:21:51'!
performCommandWithRover: aRover
	^self error: 'Command not recognized'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotRecognizedCommand class' category: 'MarsRover2'!
NotRecognizedCommand class
	instanceVariableNames: ''!

!NotRecognizedCommand class methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 13:21:08'!
canHandle: aCommand
	^false! !


!classDefinition: #Right category: 'MarsRover2'!
Command subclass: #Right
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2'!

!Right methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 13:13:08'!
performCommandWithRover: aRover
	aRover turnRight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Right class' category: 'MarsRover2'!
Right class
	instanceVariableNames: ''!

!Right class methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 13:11:09'!
canHandle: aCommand
	^aCommand = 'r'! !


!classDefinition: #Rover2 category: 'MarsRover2'!
Object subclass: #Rover2
	instanceVariableNames: 'currentPosition currentDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2'!

!Rover2 methodsFor: 'accessing' stamp: 'jb 6/29/2021 11:32:10'!
isFacingEast
	^currentDirection = 'E'! !

!Rover2 methodsFor: 'accessing' stamp: 'jb 6/29/2021 11:31:57'!
isFacingNorth
	^currentDirection = 'N'! !

!Rover2 methodsFor: 'accessing' stamp: 'jb 6/29/2021 11:40:08'!
isFacingSouth
	^currentDirection = 'S'.! !

!Rover2 methodsFor: 'accessing' stamp: 'jb 6/29/2021 11:33:07'!
isFacingWest
	^currentDirection = 'W'! !

!Rover2 methodsFor: 'accessing' stamp: 'jb 6/29/2021 11:17:33'!
positionIs: aPosition
	^currentPosition = aPosition! !


!Rover2 methodsFor: 'initialization' stamp: 'jb 6/29/2021 13:01:13'!
initializeFacing: aCardinalPoint positionedAt: aPoint
	currentDirection _ aCardinalPoint.
	currentPosition _ aPoint.! !


!Rover2 methodsFor: 'private' stamp: 'jb 6/30/2021 11:41:57'!
processSingleCommand: aCommand
	|command|
	
	command _ Command fromCharacter: aCommand.
	
	command performCommandWithRover: self.
	
	"commandProcesor := CommandProcessor withRover: self."
	"commandProcesor executeCommand: aCommand."! !


!Rover2 methodsFor: 'operations' stamp: 'jb 6/29/2021 12:41:32'!
processCommands: aStringContainingCommands
	aStringContainingCommands do: [:aSingleCommand | self processSingleCommand: aSingleCommand asString].! !


!Rover2 methodsFor: 'commands' stamp: 'jb 6/30/2021 12:47:21'!
moveBack
	self isFacingNorth ifTrue: [^currentPosition _ currentPosition + ( 0@-1)].
	self isFacingEast   ifTrue: [^currentPosition _ currentPosition + (-1@ 0)].
	self isFacingSouth ifTrue: [^currentPosition _ currentPosition + ( 0@ 1)].
	self isFacingWest  ifTrue: [^currentPosition _ currentPosition + ( 1@ 0)].! !

!Rover2 methodsFor: 'commands' stamp: 'jb 6/29/2021 13:14:06'!
moveForward
	self isFacingNorth ifTrue: [^currentPosition _ currentPosition + (0@1)].
	self isFacingEast ifTrue: [^currentPosition _ currentPosition +  (1@0)].
	self isFacingSouth ifTrue: [^currentPosition _ currentPosition + (0@-1)].
	self isFacingWest ifTrue: [^currentPosition _ currentPosition + (-1@0)].! !

!Rover2 methodsFor: 'commands' stamp: 'jb 6/29/2021 13:14:53'!
turnLeft
	self isFacingNorth ifTrue: [^currentDirection _ 'W'].
	self isFacingEast ifTrue: [^currentDirection _ 'N'].
	self isFacingSouth ifTrue: [^currentDirection _ 'E'].
	self isFacingWest ifTrue: [^currentDirection _ 'S'].! !

!Rover2 methodsFor: 'commands' stamp: 'jb 6/29/2021 13:15:11'!
turnRight
	self isFacingNorth ifTrue: [^currentDirection _ 'E'].
	self isFacingEast ifTrue: [^currentDirection _ 'S'].
	self isFacingSouth ifTrue: [^currentDirection _ 'W'].
	self isFacingWest ifTrue: [^currentDirection _ 'N'].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Rover2 class' category: 'MarsRover2'!
Rover2 class
	instanceVariableNames: ''!

!Rover2 class methodsFor: 'nil' stamp: 'jb 6/29/2021 11:50:37'!
facing: aCardinalPoint positionedAt: aPoint
	^Rover2 new initializeFacing: aCardinalPoint positionedAt: aPoint.! !
