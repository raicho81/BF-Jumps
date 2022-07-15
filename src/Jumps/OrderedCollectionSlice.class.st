"
Just a very simple wrapper around OrderedCollection representing a slice in the collection rather than the whole collection.

   Instance Variables

	sliceStartOffset:	SmallInteger

"
Class {
	#name : #OrderedCollectionSlice,
	#superclass : #OrderedCollection,
	#instVars : [
		'sliceStartOffset'
	],
	#category : #'Jumps-Core'
}

{ #category : #'as yet unclassified' }
OrderedCollectionSlice class >> withSliceStartOffset: startOffset withCollection: aOrderedCollection [

	| slice |
	slice := OrderedCollectionSlice new.
	slice := aOrderedCollection.
	slice sliceStartOffset: startOffset
]

{ #category : #accessing }
OrderedCollectionSlice >> at: pos [

	^ self at: pos + sliceStartOffset
]

{ #category : #iterating }
OrderedCollectionSlice >> do: aBlock [

	sliceStartOffset to: self size do: aBlock
]

{ #category : #initialization }
OrderedCollectionSlice >> initialize [

	super initialize.
	sliceStartOffset := -1
]

{ #category : #accessing }
OrderedCollectionSlice >> size [

	^ super size - sliceStartOffset
]