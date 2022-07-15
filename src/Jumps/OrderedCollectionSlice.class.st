"
Just a very simple wrapper around OrderedCollection representing a slice in the collection rather than the whole collection so it can be considered a kind of restricted view of the collection contents resembling python and Go slices.

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

{ #category : #'instance creation' }
OrderedCollectionSlice class >> withSliceStartOffset: startOffset withCollection: aOrderedCollection [

	| slice |
	slice := self new.
	slice from: aOrderedCollection.
	slice sliceStartOffset: startOffset.
	^ slice
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

{ #category : #accessing }
OrderedCollectionSlice >> sliceStartOffset [

	^ sliceStartOffset
]

{ #category : #accessing }
OrderedCollectionSlice >> sliceStartOffset: startOffset [

	sliceStartOffset := startOffset
]
