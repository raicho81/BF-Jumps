Class {
	#name : #OrderedCollectionSliceTest,
	#superclass : #TestCase,
	#instVars : [
		'sliceStartPosition'
	],
	#category : #'Jumps-Test'
}

{ #category : #tests }
OrderedCollectionSliceTest >> testInitializationIsOk [

	| s |
	s := OrderedCollectionSlice
		     withSliceStartOffset: 2
		     withCollection: { 1. 2. 3. 4. 5 }.
	self assert: s size equals: 3
]
