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
		'inputList',
		'computed'
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

	1 to: inputList size - 1 do: [ :each | self computeJumpsFast: each]
]

{ #category : #algorithm }
Jumps >> computeJumpsFast: startPos [

	| max jumpsListIndices |
	(computed includes: startPos) ifTrue: [ ^ self ].
	max := inputList at: startPos.
	jumpsListIndices := OrderedCollection new.
	jumpsListIndices add: startPos.

	startPos + 1 to: inputList size do: [ :index | 
		max < (inputList at: index) ifTrue: [ 
			jumpsListIndices do: [ :each | 
				jumpsList at: each put: (jumpsList at: each) + 1 ].
			(computed includes: index) ifTrue: [ 
				jumpsListIndices do: [ :each | 
					jumpsList
						at: each
						put: (jumpsList at: each) + (jumpsList at: index) ].
				computed addAll: jumpsListIndices.
				^ self ].
			jumpsListIndices add: index.			
			max := inputList at: index ].
		inputList size = index ifTrue: [ computed addAll: jumpsListIndices ] ]
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

	1 to: jumpsList size do: [ :index | 
	jumpsList at: index put: (self computeJumpsSlow: index) ]
]

{ #category : #accessing }
Jumps >> computed [

	^ computed
]

{ #category : #initialization }
Jumps >> initialize [

	inputList := OrderedCollection new.
	jumpsList := OrderedCollection new.
	computed := Set new.
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
