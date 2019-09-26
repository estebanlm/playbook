Class {
	#name : #StPlaybookPlayground,
	#superclass : #StPlayground,
	#instVars : [
		'move',
		'toolbar'
	],
	#category : #'NewTools-Playbook-View'
}

{ #category : #specs }
StPlaybookPlayground class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #toolbar expand: false fill: false padding: 0;
		add: #text;
		addLast: #statusBar expand: false fill: false padding: 0;
		yourself
]

{ #category : #initialization }
StPlaybookPlayground >> defineInputPorts [

	^ { SpModelPort new }
]

{ #category : #accessing }
StPlaybookPlayground >> firstResponder [

	^ text
]

{ #category : #initialization }
StPlaybookPlayground >> initializePresenters [

	super initializePresenters.
	self initializeToolbar.
	self initializeStatusbar.
	
	"this is just needed for morphic, gtk is always autoAccept"
	text autoAccept: true.
	text whenTextChangedDo: [ :aString | move contents: aString asString ].
	move ifNotNil: [ 	
		text text: move contents ]
]

{ #category : #initialization }
StPlaybookPlayground >> initializeStatusbar [
	
	statusBar := self newStatusBar
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
StPlaybookPlayground >> popMessage [ 

	statusBar popMessage
]

{ #category : #accessing }
StPlaybookPlayground >> pushMessage: aString [ 

	statusBar pushMessage: aString
]

{ #category : #accessing }
StPlaybookPlayground >> refresh [

	move ifNil: [ ^ self ].

	text text: move contents.
	statusBar popMessage.
	statusBar pushMessage: ('Editing {1}' format: { move name })
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
