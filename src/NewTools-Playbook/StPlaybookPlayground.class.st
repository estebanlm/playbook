Class {
	#name : #StPlaybookPlayground,
	#superclass : #StPlayground,
	#instVars : [
		'move',
		'toolbar'
	],
	#category : #'NewTools-Playbook'
}

{ #category : #specs }
StPlaybookPlayground class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #toolbar expand: false fill: false padding: 0;
		add: #text;
		yourself
]

{ #category : #initialization }
StPlaybookPlayground >> initializePresenters [

	super initializePresenters.
	self initializeToolbar.
	
	text text: move contents
]

{ #category : #initialization }
StPlaybookPlayground >> initializeToolbar [

	toolbar := self newToolBar.
	toolbar beIcons.
	
	SpToolBarPresenterBuilder new 
		toolbarPresenter: toolbar;
		visit: self toolbarActions
]

{ #category : #'accessing model' }
StPlaybookPlayground >> setModelBeforeInitialization: aMove [

	move := aMove
]
