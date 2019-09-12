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

{ #category : #specs }
StPlaybookMovePresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #text;
		addLast: #expandButton expand: false fill: true padding: 0;
		yourself
]

{ #category : #'as yet unclassified' }
StPlaybookMovePresenter >> expandNext [

	expandAction ifNil: [ ^ self ].
	expandAction 
		cull: self 
		cull: move
]

{ #category : #initialization }
StPlaybookMovePresenter >> initializeWidgets [

	super initializeWidgets.
	text text: move contents.
	expandButton := self newButton 
		icon: (self application iconNamed: #glamorousDown);
		action: [ self expandNext ];
		yourself. 
]

{ #category : #'as yet unclassified' }
StPlaybookMovePresenter >> onExpand: aBlock [

	expandAction := aBlock 
]

{ #category : #'accessing model' }
StPlaybookMovePresenter >> setModelBeforeInitialization: aMove [

	move := aMove
]
