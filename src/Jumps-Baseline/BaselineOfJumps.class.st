"
Implementation Points
"
Class {
	#name : #BaselineOfJumps,
	#superclass : #BaselineOf,
	#category : #'Jumps-Baseline'
}

{ #category : #baselines }
BaselineOfJumps >> baseline: spec [
	<baseline>

	spec for: #pharo do: [ 
		spec package: 'Jumps-Core'.
		spec package: 'Jumps-Tests' with: [ spec requires: #('Jumps-Core') ]
	]
	

]
