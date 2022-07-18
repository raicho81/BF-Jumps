"
Class to compute the 'jumps' in a list of integers.

Algo description:


Internal Representation and Key Implementation Points.

    Instance Variables
	inputList:		<Object>
	jumpsList:		<Object>


    Implementation Points
"
Class {
	#name : #Jumps,
	#superclass : #Object,
	#instVars : [
		'jumpsList',
		'inputList'
	],
	#category : #'Jumps-Core'
}

{ #category : #initialization }
Jumps class >> withInputList: inputListCollection [

	| j |
	j := self new.
	j inputList: inputListCollection.
	j jumpsList:
		(OrderedCollection new: inputListCollection size withAll: 0).
	^ j
]

{ #category : #initialization }
Jumps class >> withRandom: nJumps [

	| j inpL |
	j := self new.
	j jumpsList: (OrderedCollection new: nJumps withAll: 0).
	inpL := OrderedCollection new: nJumps withAll: 0.
	inpL := inpL collect: [ :_ | nJumps atRandom ].
	j inputList: inpL sort.
	^ j
]

{ #category : #algorithm }
Jumps >> computeFast [

	1 to: jumpsList size - 1 do: [ :_ | self computeJumpsFast: _ ]
]

{ #category : #algorithm }
Jumps >> computeJumpsFast: inputListStartPosition [

	| jumps max listIndices totalmax |
	inputList size - inputListStartPosition + 1 = 1 ifTrue: [ ^ 0 ].
	jumps := 1.
	max := inputList at: inputListStartPosition.
	totalmax := inputList max.

	listIndices := OrderedCollection new.
	inputListStartPosition + 1 to: inputList size do: [ :index | 
		(jumpsList at: index - 1) > 0
			ifTrue: [ 
				jumps := jumpsList at: index - 1.
				listIndices do: [ :_ | 
					jumpsList at: _ put: (jumpsList at: _) + jumps ].
				^ self ]
			ifFalse: [ 
				listIndices add: index - 1.
				max < (inputList at: index) ifTrue: [ 
					max := inputList at: index.
					listIndices do: [ :_ | 
						jumpsList at: _ put: (jumpsList at: _) + jumps ] ] ] ]
]

{ #category : #algorithm }
Jumps >> computeJumpsSlow: startPos [

	" r: (Naively) compute the list jumps by bruteforce."

	| jumps max |
	jumps := 0.
	max := inputList at: startPos.

	startPos + 1 to: inputList size do: [ :index | 
		| current |
		current := inputList at: index.

		max < current ifTrue: [ 
			jumps := jumps + 1.
			max := current ] ].

	^ jumps
]

{ #category : #algorithm }
Jumps >> computeSlow [

	1 to: jumpsList size - 1 do: [ :index | 
	jumpsList at: index put: (self computeJumpsSlow: index) ]
]

{ #category : #initialization }
Jumps >> initialize [

	inputList := OrderedCollection new.
	jumpsList := OrderedCollection new.
	inputList := Dictionary new
]

{ #category : #accessing }
Jumps >> inputList [

	^ inputList
]

{ #category : #accessing }
Jumps >> inputList: aCollection [ 

	inputList := aCollection
]

{ #category : #accessing }
Jumps >> jumpsList [
	^ jumpsList
]

{ #category : #accessing }
Jumps >> jumpsList: aCollection [ 

	jumpsList := aCollection
]
