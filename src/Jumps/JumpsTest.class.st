Class {
	#name : #JumpsTest,
	#superclass : #TestCase,
	#category : #'Jumps-Test'
}

{ #category : #tests }
JumpsTest >> testComputeFastExample [

	| j |
	j := Jumps withInputList:
		     (OrderedCollection withAll: { 1. 4. 2. 6. 3. 4 }).
	j computeFast.

	self
		assert: j jumpsList
		equals: (OrderedCollection withAll: { 2. 1. 1. 0. 1. 0 })
]

{ #category : #tests }
JumpsTest >> testComputeFastFourElements [

	| j |
	j := Jumps withInputList: (OrderedCollection withAll: { 1. 0. 2. 3 }).
	j computeFast.
	self
		assert: j jumpsList
		equals: (OrderedCollection withAll: { 2. 2. 1. 0 }).

	j := Jumps withInputList: (OrderedCollection withAll: { 2. 2. 0. 3 }).
	j computeFast.
	self
		assert: j jumpsList
		equals: (OrderedCollection withAll: { 1. 1. 1. 0 }).

	j := Jumps withInputList: (OrderedCollection withAll: { 2. 2. 2. 3 }).
	j computeFast.
	self
		assert: j jumpsList
		equals: (OrderedCollection withAll: { 1. 1. 1. 0 }).

	j := Jumps withInputList: (OrderedCollection withAll: { 2. 2. 2. 2 }).
	j computeFast.
	self
		assert: j jumpsList
		equals: (OrderedCollection withAll: { 0. 0. 0. 0 }).

	j := Jumps withInputList: (OrderedCollection withAll: { 3. 2. 1. 0 }).
	j computeFast.
	self
		assert: j jumpsList
		equals: (OrderedCollection withAll: { 0. 0. 0. 0 }).

	j := Jumps withInputList: (OrderedCollection withAll: { 1. 2. 1. 2 }).
	j computeFast.
	self
		assert: j jumpsList
		equals: (OrderedCollection withAll: { 1. 0. 1. 0 }).

	j := Jumps withInputList: (OrderedCollection withAll: { 1. 2. 3. 4 }).
	j computeFast.
	self
		assert: j jumpsList
		equals: (OrderedCollection withAll: { 3. 2. 1. 0 })

]

{ #category : #tests }
JumpsTest >> testComputeFastOneElement [

	| j |
	j := Jumps withInputList: (OrderedCollection withAll: { 1 }).
	j computeFast.
	self assert: j jumpsList equals: (OrderedCollection withAll: { 0 })
]

{ #category : #tests }
JumpsTest >> testComputeFastThreeElements [

	| j |
	j := Jumps withInputList: (OrderedCollection withAll: { 1. 0. 2 }).
	j computeFast.
	self
		assert: j jumpsList
		equals: (OrderedCollection withAll: { 1. 1. 0 }).

	j := Jumps withInputList: (OrderedCollection withAll: { 1. 2. 3 }).
	j computeFast.
	self
		assert: j jumpsList
		equals: (OrderedCollection withAll: { 2. 1. 0 }).

	j := Jumps withInputList: (OrderedCollection withAll: { 1. 1. 3 }).
	j computeFast.
	self
		assert: j jumpsList
		equals: (OrderedCollection withAll: { 1. 1. 0 })		
]

{ #category : #tests }
JumpsTest >> testComputeFastTwoElements [

	| j |
	j := Jumps withInputList: (OrderedCollection withAll: { 1. 0 }).
	j computeFast.
	self
		assert: j jumpsList
		equals: (OrderedCollection withAll: { 0. 0 }).

	j := Jumps withInputList: (OrderedCollection withAll: { 1. 2 }).
	j computeFast.
	self
		assert: j jumpsList
		equals: (OrderedCollection withAll: { 1. 0 }).
		
	j := Jumps withInputList: (OrderedCollection withAll: { 0. 2 }).
	j computeFast.
	self
		assert: j jumpsList
		equals: (OrderedCollection withAll: { 1. 0 })	
]

{ #category : #tests }
JumpsTest >> testComputeJumpsSlow [

	| j |
	j := Jumps new.

	j inputList: { 1. 1. 1. 1. 1. 1 }.
	self assert: (j computeJumpsSlow: 1) equals: 0.

	j inputList: { 1. 4. 2. 6. 3. 4 }.
	self assert: (j computeJumpsSlow: 1) equals: 2.

	j inputList: { 1. 3. 2. 6. 3. 7 }.
	self assert: (j computeJumpsSlow: 1) equals: 3.

	j inputList: { 1. 3. 2. 6. 3. 7. 5. 8. 9 }.
	self assert: (j computeJumpsSlow: 1) equals: 5.

	j inputList: { 1. 3. 2. 6. 3. 7. 5. 8. 9. 1. 1. 1. 10. 9. 8. 12 }.
	self assert: (j computeJumpsSlow: 1) equals: 7.

	j inputList: { 1. 3. 2. 6. 3. 7. 1. 2. 1. 1. 1. 1. 10. 9. 8. 12 }.
	self assert: (j computeJumpsSlow: 1) equals: 5
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
JumpsTest >> testComputeSlowVsFastWith500Random [

	| j jumpsSlow inpListRandom start duration |
	inpListRandom := OrderedCollection new: 50000 withAll: 0.
	inpListRandom := inpListRandom collect: [ :_ | 50000 atRandom ].
	inpListRandom sort.
	j := Jumps withInputList: inpListRandom.
	start := Time nowUTC.
	j computeSlow.
	duration := Time nowUTC subtractTime: start.
	Transcript
		show: 'computeSlow time: ';
		show: duration asNanoSeconds;
		cr.

	jumpsSlow := j jumpsList copy.
	j := Jumps withInputList: inpListRandom.
	start := Time nowUTC.
	j computeFast.
	duration := Time nowUTC subtractTime: start.
	Transcript
		show: 'computeFast time: ';
		show: duration asNanoSeconds;
		cr.
	self assert: jumpsSlow equals: j jumpsList
]

{ #category : #tests }
JumpsTest >> testInitializationIsOk [

	| j |
	j := Jumps new.
	self assert: j isNotNil.
	self assert: j jumpsList isEmpty.
	self assert: j inputList isEmpty.
	self assert: j computed isEmpty.
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
