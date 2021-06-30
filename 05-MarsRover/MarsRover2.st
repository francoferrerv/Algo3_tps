!classDefinition: #Tests category: 'MarsRover2'!
TestCase subclass: #Tests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2'!

!Tests methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 12:41:33'!
test01
	
	| rover |
	rover := Rover2 facing: 'N' positionedAt: (0@0).
	rover processCommands: ''.
	
	self assert: (rover isFacingNorth).
	self assert: (rover positionIs: 0@0).! !

!Tests methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 12:41:32'!
test02
	
	| rover |
	rover := Rover2 facing: 'N' positionedAt: (0@0).
	rover processCommands: 'f'.
	
	self assert: (rover isFacingNorth).
	self deny: (rover positionIs: 0@0).
	self assert: (rover positionIs: 0@1).! !

!Tests methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 12:41:33'!
test03
	
	| rover |
	rover := Rover2 facing: 'N' positionedAt: (0@0).
	rover processCommands: 'b'.
	
	self assert: (rover isFacingNorth).
	self assert: (rover positionIs: 0@-1).! !

!Tests methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 12:41:33'!
test04
	
	| rover |
	rover := Rover2 facing: 'N' positionedAt: (0@0).
	rover processCommands: 'r'.
	
	self assert: (rover isFacingEast).
	self assert: (rover positionIs: 0@0).! !

!Tests methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 12:41:32'!
test05RoverTurningRightFacesEastButNotNorth
	
	| rover |
	rover := Rover2 facing: 'N' positionedAt: (0@0).
	rover processCommands: 'r'.
	
	self assert: (rover isFacingEast).
	self deny: (rover isFacingNorth).
	self assert: (rover positionIs: 0@0).! !

!Tests methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 12:41:33'!
test06
	
	| rover |
	rover := Rover2 facing: 'N' positionedAt: (0@0).
	rover processCommands: 'l'.
	
	self assert: (rover isFacingWest).
	self assert: (rover positionIs: 0@0).! !

!Tests methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 12:41:33'!
test07
	
	| rover |
	rover := Rover2 facing: 'E' positionedAt: (0@0).
	rover processCommands: 'r'.
	
	self assert: (rover isFacingSouth).
	self assert: (rover positionIs: 0@0).! !

!Tests methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 12:41:33'!
test08
	
	| rover |
	rover := Rover2 facing: 'N' positionedAt: (3@3).
	rover processCommands: 'f'.
	
	self assert: (rover isFacingNorth).
	self assert: (rover positionIs: 3@4).! !

!Tests methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 12:41:33'!
test09TENEMOSQUETERMINARLO
	
	| rover |
	rover := Rover2 facing: 'N' positionedAt: (0@0).
	
	self should: [rover processCommands: 'x']
	raise: Error
	withExceptionDo: [:anException |
		self assert: (rover isFacingNorth).
		self assert: (rover positionIs: 0@0).
	]
	
	! !

!Tests methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 12:41:33'!
test10
	
	| rover |
	rover := Rover2 facing: 'N' positionedAt: (0@0).
	rover processCommands: 'ff'.
	
	self assert: (rover isFacingNorth).
	self assert: (rover positionIs: 0@2).! !

!Tests methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 13:23:03'!
test11TENEMOSQUETERMINARLO
	
	| rover test |
	rover := Rover2 facing: 'S' positionedAt: (2@5).
	
	test := (2@5) + ((0@-1) * 2) + ((-1@0) * 1)." + (0@1) + (1@0)".
	
	self should: [rover processCommands: 'ffrfxflbrb']
	raise: Error
	withExceptionDo: [:anException |
		self assert: (rover isFacingWest).
	self assert: (rover positionIs: test).
	]! !


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

!Rover2 methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 13:01:13'!
initializeFacing: aCardinalPoint positionedAt: aPoint
	currentDirection _ aCardinalPoint.
	currentPosition _ aPoint.! !

!Rover2 methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 11:32:10'!
isFacingEast
	^currentDirection = 'E'! !

!Rover2 methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 11:31:57'!
isFacingNorth
	^currentDirection = 'N'! !

!Rover2 methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 11:40:08'!
isFacingSouth
	^currentDirection = 'S'.! !

!Rover2 methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 11:33:07'!
isFacingWest
	^currentDirection = 'W'! !

!Rover2 methodsFor: 'as yet unclassified' stamp: 'jb 6/29/2021 11:17:33'!
positionIs: aPosition
	^currentPosition = aPosition! !


!Rover2 methodsFor: 'private' stamp: 'jb 6/29/2021 13:05:24'!
processSingleCommand: aCommand
	(Command fromCharacter: aCommand) performCommandWithRover: self.
	
	"(aCommand = 'f') ifTrue: [
		self isFacingNorth ifTrue: [^currentPosition _ currentPosition + (0@1)].
		self isFacingEast ifTrue: [^currentPosition _ currentPosition +  (1@0)].
		self isFacingSouth ifTrue: [^currentPosition _ currentPosition + (0@-1)].
		self isFacingWest ifTrue: [^currentPosition _ currentPosition + (-1@0)].
	].
	(aCommand = 'b') ifTrue: [
		self isFacingNorth ifTrue: [^currentPosition _ currentPosition + (0@-1)].
		self isFacingEast ifTrue: [^currentPosition _ currentPosition + (-1@0)].
		self isFacingSouth ifTrue: [^currentPosition _ currentPosition + (0@1)].
		self isFacingWest ifTrue: [^currentPosition _ currentPosition + (1@0)].
	].
	
	(aCommand = 'r') ifTrue: [
		self isFacingNorth ifTrue: [^currentDirection _ 'E'].
		self isFacingEast ifTrue: [^currentDirection _ 'S'].
		self isFacingSouth ifTrue: [^currentDirection _ 'W'].
		self isFacingWest ifTrue: [^currentDirection _ 'N'].
		
	].

	(aCommand = 'l') ifTrue: [
		self isFacingNorth ifTrue: [^currentDirection _ 'W'].
		self isFacingEast ifTrue: [^currentDirection _ 'N'].
		self isFacingSouth ifTrue: [^currentDirection _ 'E'].
		self isFacingWest ifTrue: [^currentDirection _ 'S'].
	].

	^self error: 'The command was not understood.'
	"! !


!Rover2 methodsFor: 'operations' stamp: 'jb 6/29/2021 12:41:32'!
processCommands: aStringContainingCommands
	aStringContainingCommands do: [:aSingleCommand | self processSingleCommand: aSingleCommand asString].! !


!Rover2 methodsFor: 'commands' stamp: 'jb 6/29/2021 13:14:26'!
moveBack
	self isFacingNorth ifTrue: [^currentPosition _ currentPosition + (0@-1)].
	self isFacingEast ifTrue: [^currentPosition _ currentPosition + (-1@0)].
	self isFacingSouth ifTrue: [^currentPosition _ currentPosition + (0@1)].
	self isFacingWest ifTrue: [^currentPosition _ currentPosition + (1@0)].! !

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
