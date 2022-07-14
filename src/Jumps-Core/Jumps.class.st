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

{ #category : #accessing }
Jumps >> cache [

	^ cache
]

{ #category : #initialization }
Jumps >> computeFast [

	| inputListCopy |
	inputListCopy := inputList copy.
	1 to: jumpsList size do: [ :index | 
		jumpsList at: index put: (self computeJumpsFast: inputListCopy).
		inputListCopy removeFirst ]
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
Jumps >> computeJumpsFast: list [

	| jumps max listIndices |
	jumps := 0.
	list size = 1 ifTrue: [ ^ jumps ].
	max := list at: 1.
	listIndices := OrderedCollection new.
	2 to: list size do: [ :index | 
		(cache keys includes: index - 1)
			ifTrue: [ ^ [ cache at: index - 1 ] value ]
			ifFalse: [ 
				(max < inputList at: index) ifTrue: [ 
					max := inputList at: index.
					listIndices add: index - 1.
					cache add: index - 1 -> 0.
					listIndices do: [ :saved_idx | 
						cache add: saved_idx -> ([ cache at: saved_idx ] value + 1) ].
					jumps := jumps + 1 ] ].
	Transcript
		show: inputList;
		cr;
		show: listIndices;
		cr;
		show: cache;
		cr.			
			 ].
	^ jumps
]

{ #category : #initialization }
Jumps >> computeSlow [

	| inputListCopy |
	inputListCopy := inputList copy.
	1 to: jumpsList size do: [ :index | 
		jumpsList at: index put: (self computeJumps: inputListCopy).
		inputListCopy removeFirst]
]

{ #category : #initialization }
Jumps >> initialize [

	inputList := OrderedCollection new.
	jumpsList := OrderedCollection new.
	cache := Dictionary new
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
