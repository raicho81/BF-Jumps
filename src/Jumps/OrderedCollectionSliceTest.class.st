Class {
	#name : #OrderedCollectionSliceTest,
	#superclass : #OrderedCollection,
	#instVars : [
		'sliceStartPosition'
	],
	#category : #'Jumps-Test'
}

{ #category : #tests }
OrderedCollectionSliceTest >> testInitializationIsOk [

	| s |
	s := OrderedCollectionSlice withSliceStartOffset: 3 withCollection: { 1. 2. 3. 4. 5 }.
	s sliceStartOffset: 3.
	self assert: s size equals: 3
]
