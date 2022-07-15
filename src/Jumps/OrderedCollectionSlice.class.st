Class {
	#name : #OrderedCollectionSlice,
	#superclass : #OrderedCollection,
	#instVars : [
		'sliceStartPosition'
	],
	#category : #'Jumps-Core'
}

{ #category : #'as yet unclassified' }
OrderedCollectionSlice class >> withSliceStartPosition: sliceStartPosition [
	|slice|
	slice := OrderedCollectionSlice new.
	slice sliceStartPosition: sliceStartPosition

]

{ #category : #initialization }
OrderedCollectionSlice >> initialize [

	super initialize

]
