Class {
	#name : #JumpsTest,
	#superclass : #TestCase,
	#category : #'Jumps-Tests'
}

{ #category : #tests }
JumpsTest >> testComputeJumps [

	| input j |
	j := Jumps new.
	input := { 1. 1. 1. 1. 1. 1 }.
	self assert: (j computeJumps: input) equals: 0.
	input := { 1. 4. 2. 6. 3. 4 }.
	self assert: (j computeJumps: input) equals: 2.
	input := { 1. 3. 2. 6. 3. 7 }.
	self assert: (j computeJumps: input) equals: 3.
	input := { 1. 3. 2. 6. 3. 7. 5. 8. 9 }.
	self assert: (j computeJumps: input) equals: 5.
	input := { 1. 3. 2. 6. 3. 7. 5. 8. 9. 1. 1. 1. 10. 9. 8. 12 }.
	self assert: (j computeJumps: input) equals: 7.
	input := { 1. 3. 2. 6. 3. 7. 1. 2. 1. 1. 1. 1. 10. 9. 8. 12 }.
	self assert: (j computeJumps: input) equals: 5
]

{ #category : #tests }
JumpsTest >> testComputeSlow [

	| j |
	j := Jumps withInputList:
		     (OrderedCollection withAll: { 1. 1. 1. 1. 1. 1 }).
	j computeSlow.
	self
		assert: j jumpsList
		equals: (OrderedCollection withAll: { 0. 0. 0. 0. 0. 0 }).


	j := Jumps withInputList:
		     (OrderedCollection withAll: { 1. 4. 2. 6. 3. 4 }).
	j computeSlow.
	self
		assert: j jumpsList
		equals: (OrderedCollection withAll: { 2. 1. 1. 0. 1. 0 })
]

{ #category : #tests }
JumpsTest >> testInitializationIsOk [

	| j |
	j := Jumps new.
	self assert: j isNotNil.
	self assert: j jumpsList isEmpty.
	self assert: j inputList isEmpty.
	self assert: j cache isEmpty.
]

{ #category : #tests }
JumpsTest >> testInitializationRandom [

	| j |
	j := Jumps withRandom: 5000.
	self assert: j inputList size equals: 5000.
	self assert: j jumpsList size equals: 5000.
	self assert: j jumpsList sum equals: 0.
	self assert: j inputList sum ~= 0 equals: true
]
