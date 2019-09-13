Class {
	#name : #StPlaybookPlayground,
	#superclass : #StPlayground,
	#instVars : [
		'move'
	],
	#category : #'NewTools-Playbook'
}

{ #category : #initialization }
StPlaybookPlayground >> initializeWidgets [

	super initializeWidgets.
	text text: move contents
]

{ #category : #'accessing model' }
StPlaybookPlayground >> setModelBeforeInitialization: aMove [

	move := aMove
]
