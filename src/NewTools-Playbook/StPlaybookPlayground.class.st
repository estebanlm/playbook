Class {
	#name : #StPlaybookPlayground,
	#superclass : #StPlayground,
	#instVars : [
		'move',
		'toolbar',
		'statusbar'
	],
	#category : #'NewTools-Playbook'
}

{ #category : #specs }
StPlaybookPlayground class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #toolbar expand: false fill: false padding: 0;
		add: #text;
		addLast: #statusbar expand: false fill: false padding: 0;
		yourself
]

{ #category : #initialization }
StPlaybookPlayground >> defineInputPorts [

	^ { SpModelPort new }
]

{ #category : #initialization }
StPlaybookPlayground >> initializePresenters [

	super initializePresenters.
	self initializeToolbar.
	self initializeStatusbar.

	text whenTextChangedDo: [ :aString | move contents: aString ].
	move ifNotNil: [ 	
		text text: move contents ]
]

{ #category : #initialization }
StPlaybookPlayground >> initializeStatusbar [
	
	statusbar := self newStatusBar
]

{ #category : #initialization }
StPlaybookPlayground >> initializeToolbar [

	toolbar := self newToolBar.
	toolbar beIcons.
	
	SpToolBarPresenterBuilder new 
		toolbarPresenter: toolbar;
		visit: self toolbarActions
]

{ #category : #accessing }
StPlaybookPlayground >> refresh [

	move ifNil: [ ^ self ].

	text text: move contents.
	statusbar popMessage.
	statusbar pushMessage: ('Editing {1}' format: { move name })
]

{ #category : #'accessing model' }
StPlaybookPlayground >> setModel: aMove [

	move := aMove.
	self refresh
]

{ #category : #'accessing model' }
StPlaybookPlayground >> setModelBeforeInitialization: aMove [

	move := aMove
]
