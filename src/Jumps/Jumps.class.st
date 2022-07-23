"
Class Jumps
 
Given a sequence of elements(numbers), calculate the longest possible sequence of 'jumps' from each number.
 
Each 'jump' must be made according to the following rules:
 
    You can only 'jump' on a number that is greater than the current one;
    You can 'jump' on a number, only if there isn't one with a greater value between;
    You can 'jump' only from left to right;
 
Input
 
Read from the standard input
 
    On the first line, you will find the number N
        The number of elements
    On the second line you will find N numbers, separated by a space
        The elements themselves
 
The input will be correct and in the described format, so there is no need to check it explicitly.
Output
 
Print to the standard output
 
    On the first line, print the length of the longest sequence of jumps
    On the second line, print the lengths of the sequences, starting from each element
 
Constraints
 
    The N will always be less than 50000
 
Sample Tests
Input
 
1 4 2 6 3 4
 
Output
 
2 1 1 0 1 0
 
Explanation
 
    Element 1:
        1 -> 4 -> 6 (2 jumps)
    Element 2:
        4 -> 6 (1 jump)
    Element 3:
        2 -> 6 (1 jump)
    Element 4:
        6 (0 jumps)
    Element 5:
        3 -> 4 (1 jump)
    Element 6:
        4 -> (0 jumps)
 
Input
 
1 1 1 1 1
 
Output
 
0 0 0 0 0
"
Class {
	#name : #Jumps,
	#superclass : #Object,
	#instVars : [
		'jumpsList',
		'inputList',
		'computed',
		'totalmax',
		'jumpsListIndices'
	],
	#category : #'Jumps-Core'
}

{ #category : #initialization }
Jumps class >> withInputList: inputListCollection [

	| j |
	j := self new.
	j inputList: inputListCollection.
	j totalmax: j inputList max.
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
	j inputList: inpL.
	j totalmax: j inputList max.
	^ j
]

{ #category : #algorithm }
Jumps >> computeFast [

	1 to: inputList size - 1 do: [ :each | 
		self computeJumpsFast: each]
]

{ #category : #algorithm }
Jumps >> computeJumpsFast: startPos [

	| max inputListSize |
	(computed includes: startPos) ifTrue: [ ^ self ].
	max := inputList at: startPos.
	jumpsListIndices reset.
	jumpsListIndices add: startPos.
	inputListSize := inputList size.

	startPos + 1 to: inputListSize do: [ :index | 
		max = totalmax ifTrue: [ 
			computed addAll: jumpsListIndices.
			^ self ].
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
		inputListSize = index ifTrue: [ computed addAll: jumpsListIndices ] ]
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

		max = totalmax ifTrue: [ ^ jumps ].
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
	totalmax := 0.
	jumpsListIndices := OrderedCollection new.
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

{ #category : #accessing }
Jumps >> jumpsListIndices [
	^ jumpsListIndices
]

{ #category : #accessing }
Jumps >> totalmax [
	^ totalmax
]

{ #category : #accessing }
Jumps >> totalmax: anInteger [ 
	totalmax := anInteger
]
