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
		(OrderedCollection new: (inputListCollection size) withAll: 0).
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
	inputList size - inputListStartPosition + 1 = 1 ifTrue: [ ^ 0 ]. " r: Base case - list with length 1 has no jumps. The '^' operator is eqivalent to return but much shorter."
	jumps := 0.
	max := inputList at: inputListStartPosition.
	totalmax := inputList max.

	listIndices := OrderedCollection new. " r: List of 'visited' indices"
	Transcript
		show: 'inputList					: ';
		show: inputList;
		cr.
	inputListStartPosition + 1 to: inputList size do: [ :index | 
		(inputList at: index) = totalmax ifTrue: [ ^ 0 ]. " r: Nicky's partial optimization goes here. "
		" r: Check if we have cached data for the current index "
		(jumpsList at: index - 1) > 0
			ifTrue: [ " If there is data just return the precomputed jumps." 
				^ jumpsList at: index - 1 ]
			ifFalse: [ " Else start to compute the jumps forming a jumps 'chain' "
				max < (inputList at: index) ifTrue: [ " If the current max is less than the current element in consideration => we have a jump. "
					max := inputList at: index.
					" Add the jump index to the current jumps 'chain' "
					listIndices add: index - 1.
					" Increment the counts of the jumps in the current jumps 'chain' by using iterator. The iterator 'do:' evaualtes it's block (closure) for each element in the sequence passing the element as a parameter to 						  					  the block (closure) - in this case I am using '_' for the varialble name holding each element for more compact code representation (by convention 'each' is used usually). Block closures are one of the                        workhorses of Smalltalk and are a very clean and powerful abstraction. Everything in Smalltalk pretty much boils-up to a block closure at one point in time. You can read more about this powerful concept                      here - https://wiki.c2.com/?SmalltalkBlocksAndClosures. In order not to get confused you can think about the block closures as lambda functions if you are more familiar with this definition. "
					listIndices do: [ :_ | 
						jumpsList at: _ put: (jumpsList at: _) + 1 ].
					Transcript
						show: 'inputList					: ';
						show: inputList;
						cr.
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
