Class {
	#name : #StPlaybookMovePresenter,
	#superclass : #StPlayground,
	#instVars : [
		'move',
		'expandButton',
		'expandAction'
	],
	#category : #'NewTools-Playbook'
}

{ #category : #'as yet unclassified' }
StPlaybookMovePresenter >> expandNext [

	expandAction ifNil: [ ^ self ].
	expandAction 
		cull: self 
		cull: move
]

{ #category : #initialization }
StPlaybookMovePresenter >> initializePresenters [

	super initializePresenters.
	text text: move contents.
	"expandButton := self newButton 
		icon: (self application iconNamed: #glamorousDown);
		action: [ self expandNext ];
		yourself. "
]

{ #category : #'as yet unclassified' }
StPlaybookMovePresenter >> onExpand: aBlock [

	expandAction := aBlock 
]

{ #category : #'accessing model' }
StPlaybookMovePresenter >> setModelBeforeInitialization: aMove [

	move := aMove
]
