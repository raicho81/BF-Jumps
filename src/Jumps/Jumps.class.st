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

{ #category : #accessing }
Jumps >> cache [

	^ inputList
]

{ #category : #initialization }
Jumps >> computeFast [

	1 to: jumpsList size do: [ :_ | 
		self computeJumpsFast: _ .]
]

{ #category : #initialization }
Jumps >> computeJumps [

	" r: (Naively) compute the list jumps by bruteforce. I bet that even if you are not familiar with Pharo / Smalltalk you will understand the algo very easy ;) "

	| jumps max |
	" (Closure) (Local) variable(s) definition "
	jumps := 0.
	max := inputList at: 1.

	2 to: inputList size do: [ :index | 
		| current |
		" (Closure) (Local) variable(s) definition "
		current := inputList at: index.
		max < current ifTrue: [ 
			jumps := jumps + 1.
			max := current ] ].

	^ jumps
]

{ #category : #initialization }
Jumps >> computeJumps: aInputCollection [

	" r: (Naively) compute the list jumps by bruteforce. I bet that even if you are not familiar with Pharo / Smalltalk you will understand the algo very easy ;) "

	| jumps max |
	" (Closure) (Local) variable(s) definition "
	jumps := 0.
	max := aInputCollection at: 1.

	2 to: aInputCollection size do: [ :index | 
		| current |
		" (Closure) (Local) variable(s) definition "
		current := aInputCollection at: index.
		max < current ifTrue: [ 
			jumps := jumps + 1.
			max := current ] ].

	^ jumps
]

{ #category : #initialization }
Jumps >> computeJumpsFast: inputListStartPosition [

	| jumps max listIndices totalmax listCurSlice |
	listCurSlice := inputList withIndexSelect: [ :index | 
		                index >= inputListStartPosition ].
	listCurSlice size = 1 ifTrue: [ ^ 0 ]. " r: Base case - list with length 1 has no jumps. The '^' operator is eqivalent to return but much shorter."
	totalmax := inputList max.
	jumps := 0.
	max := listCurSlice at: 1.
	listIndices := OrderedCollection new. " r: List of 'visited' indices"
	Transcript
		show: 'inputList					: ';
		show: inputList;
		cr.
	2 to: listCurSlice size do: [ :index | 
		Transcript
			show: 'Iteration					: ';
			show: index;
			cr.
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
					" Increment the counts of the jumps in the current jumps 'chain' by using iterator. The iterator 'do:' evaualtes it's block (closure) for each element in the sequence passing the element as a parameter to 						 						 the block (closure) - in this case I am using '_' for the varialble name holding each element for more compact code representation (by convention 'each' is used usually) and it start's to look like ASCII Art for example - '[ :_ |' :D Block closures are one of the workhorses in Smalltalk and are a very clean and powerful abstraction. Everything in Smalltalk pretty much boils-up to a block closure at one point in time. You can read more about this powerful concept here - https://wiki.c2.com/?SmalltalkBlocksAndClosures. In order not to get confused you can think about the block closures as lambda functions if you are more familiar with this definition. "
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

{ #category : #initialization }
Jumps >> computeJumpsSlow [

	" r: (Naively) compute the list jumps by bruteforce. I bet that even if you are not familiar with Pharo / Smalltalk you will understand the algo very easy ;) "

	| jumps max |
	" (Closure) (Local) variable(s) definition "
	jumps := 0.
	max := inputList at: 1.

	2 to: inputList size do: [ :index | 
		| current |
		" (Closure) (Local) variable(s) definition "
		current := inputList at: index.
		max < current ifTrue: [ 
			jumps := jumps + 1.
			max := current ] ].

	^ jumps
]

{ #category : #initialization }
Jumps >> computeJumpsSlow: aInputListCollection [

	" r: (Naively) compute the list jumps by bruteforce. I bet that even if you are not familiar with Pharo / Smalltalk you will understand the algo very easy ;) "

	| jumps max |
	" (Closure) (Local) variable(s) definition "
	jumps := 0.
	max := aInputListCollection at: 1.

	2 to: aInputListCollection size do: [ :index | 
		| current |
		" (Closure) (Local) variable(s) definition "
		current := aInputListCollection at: index.
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
		jumpsList at: index put: (self computeJumpsSlow: inputListCopy).
		inputListCopy removeFirst ]
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
