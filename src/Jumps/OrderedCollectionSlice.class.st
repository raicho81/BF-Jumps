Class {
	#name : #OrderedCollectionSlice,
	#superclass : #OrderedCollection,
	#instVars : [
		'sliceStartPosition'
	],
	#category : #'Jumps-Core'
}

{ #category : #'as yet unclassified' }
OrderedCollectionSlice class >> withSliceStartPosition: sliceStartPosition withCollection: aOrderedCollection [

	| slice |
	slice := OrderedCollectionSlice new.
	slice := aOrderedCollection.
	slice sliceStartPosition: sliceStartPosition
]

{ #category : #initialization }
OrderedCollectionSlice >> at: pos [

	^ self at: pos + sliceStartPosition.
]

{ #category : #initialization }
OrderedCollectionSlice >> initialize [

	super initialize.
	sliceStartPosition := -1
]

{ #category : #initialization }
OrderedCollectionSlice >> size [
	
	^ super size - sliceStartPosition 

]
