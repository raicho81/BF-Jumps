Class {
	#name : #Jumps,
	#superclass : #Object,
	#instVars : [
		'jumpsList',
		'inputList',
		'cache'
	],
	#category : #'Jumps-Core'
}

{ #category : #initialization }
Jumps class >> withInputList: inputListCollection [

	| j |
	j := self new.
	j inputList: inputListCollection.
	j jumpsList: (OrderedCollection new: inputListCollection size withAll: 0).
	^ j
]

{ #category : #initialization }
Jumps class >> withRandom: nJumps [

	| j inpL |
	j := self new.
	j jumpsList: (OrderedCollection new: nJumps withAll: 0).
	inpL := OrderedCollection new: nJumps withAll: 0.
	inpL := inpL collect: [ :_ | nJumps atRandom ].
	j inputList: inpL.
	^ j
]

{ #category : #accessing }
Jumps >> cache [

	^ cache
]

{ #category : #initialization }
Jumps >> computeJumps: list [

	| jumps max |
	jumps := 0.
	max := list at: 1.
	2 to: list size do: [ :index | | current | current := list at: index.
		max < current ifTrue: [ 
			jumps := jumps + 1.
			max := current ] ].
	^ jumps
]

{ #category : #initialization }
Jumps >> computeSlow [

	| inputListCopy |
	inputListCopy := inputList copy.
	1 to: jumpsList size do: [ :index | 
		jumpsList at: index put: (self computeJumps: inputListCopy).
		inputListCopy removeFirst ]
]

{ #category : #initialization }
Jumps >> initialize [ 
	
	inputList := OrderedCollection new.
	jumpsList := OrderedCollection new.
	cache := Dictionary new.
]

{ #category : #accessing }
Jumps >> inputList [

	^ inputList
]

{ #category : #accesing }
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
