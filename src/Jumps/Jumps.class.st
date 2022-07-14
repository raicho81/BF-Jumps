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

{ #category : #accessing }
Jumps >> cache [

	^ inputList
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
	list size = 1 ifTrue: [ ^ 0 ]. "Base case - list with length 1 has no jumps."
	jumps := 0.
	max := list at: 1.
	listIndices := OrderedCollection new. "List of 'visited' indices"
	Transcript
		show: 'Cache					: ';
		show: inputList;
		cr.

	list size timesRepeat: [ :index |
		Transcript
			show: 'Iteration					: ';
			show: index;
			cr.
		(jumpsList at: index) > 0
			ifTrue: [ ^ jumpsList at: index ]
			ifFalse: [ 
				max < (inputList at: index) ifTrue: [ 
					max := inputList at: index.
					listIndices add: index.
					listIndices collect: [ :saved_idx | 
						inputList at: saved_idx put: (inputList at: saved_idx value) + 1 ].
					jumps := jumps + 1 ].
				Transcript
					show: 'jumpsList					: ';
					show: jumpsList;
					cr;
					show: 'listIndices					: ';
					show: listIndices;
					cr ] ].
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
	inputList := Dictionary new
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
