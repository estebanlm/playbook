Class {
	#name : #StPlaybook,
	#superclass : #StPresenter,
	#instVars : [
		'playbook',
		'pageListHeader',
		'pageList',
		'actionBar',
		'pageContentHeader',
		'pageContent',
		'sortFunction'
	],
	#classVars : [
		'PreferredExtent'
	],
	#category : #'NewTools-Playbook-View'
}

{ #category : #accessing }
StPlaybook class >> defaultPlaybook [

	^ StPlaybookBook newDefault
]

{ #category : #specs }
StPlaybook class >> defaultSpec [

	^ SpPanedLayout newHorizontal
		position: 20 percent;
		add: (SpBoxLayout newVertical 
			add: #pageListHeader expand: false fill: false padding: 5;
			add: (SpBoxLayout newVertical
				add: #pageList;
				addLast: #actionBar expand: false;
				yourself);
			yourself);
		add: (SpBoxLayout newVertical 
			add: #pageContentHeader expand: false fill: false padding: 5;
			add: #pageContent;
			yourself);
		yourself
]

{ #category : #icons }
StPlaybook class >> menuCommandOn: aBuilder [
	<worldMenu>
	
	(aBuilder item: #Playbook)
		parent: #Tools;
		action: [ StPlaybookOLD open ];
		order: 15;
		help: 'A window used as a scratchpad area where fragments of Pharo code can be entered, stored, edited, and evaluated.';
		icon: (self iconNamed: #workspaceIcon)
]

{ #category : #'instance creation' }
StPlaybook class >> open [ 
	<script>
	
	^ self openOn: StPlaybookBook newDefault
]

{ #category : #'instance creation' }
StPlaybook class >> openOn: aPlaybook [
	
	^ (self on: aPlaybook) openWithSpec
]

{ #category : #'instance creation' }
StPlaybook class >> openOnDirectory: aDirectory [

	^ self openOn: (StPlaybookBook newDirectory: aDirectory)
]

{ #category : #settings }
StPlaybook class >> preferredExtent [

	^ PreferredExtent ifNil: [ PreferredExtent := 800@450 ]
]

{ #category : #settings }
StPlaybook class >> preferredExtent: aPoint [

	PreferredExtent = aPoint ifTrue: [ ^ self ].
	PreferredExtent := aPoint
]

{ #category : #private }
StPlaybook >> allMovePresenters [

	^ (self allMoves 
		sorted: self sortFunction) 
		collect: [ :each | self instantiate: StPlaybookPage on: each ]
]

{ #category : #accessing }
StPlaybook >> allMoves [

	^ self playbook 
		ifNotNil: [ :book | book allMoves ]
		ifNil: [ #() ]
]

{ #category : #private }
StPlaybook >> flushEnd: ann [

	pageContent popMessage.
	self refreshPageListOrder
]

{ #category : #private }
StPlaybook >> flushStart: ann [

	pageContent pushMessage: 'Saving...'
]

{ #category : #initialization }
StPlaybook >> initialize [

	sortFunction := #modificationTime ascending.
	super initialize
]

{ #category : #initialization }
StPlaybook >> initializePresenters [

	pageListHeader := self instantiate: StHeaderBar.
	pageListHeader 
		label: 'Playgrounds';
		shortcut: (self shortcutForPanel: 1).
	pageList := self newComponentList
		presenters: self allMovePresenters;
		yourself.
	actionBar := self newActionBar
		add: (self newButton
			addStyle: 'actionButton.showIcon';
			icon: (self application iconNamed: #add);
			action: [ self addNew ];
			yourself);
		yourself.

	pageContentHeader := self instantiate: StHeaderBar.
	pageContentHeader 
		label: 'Active';
		shortcut: (self shortcutForPanel: 2).	
	pageContent := self instantiate: StPlaybookPlayground.
	
	pageList transmitTo: pageContent transform: [ :page | page move ].
	pageList selectIndex: 1
]

{ #category : #initialization }
StPlaybook >> initializeWindow: aWindowPresenter [
	
	aWindowPresenter
		title: 'Playbook: ', self playbook title;
		initialExtent: self class preferredExtent;
		whenOpenedDo: [ self subscribeToAnnouncements ];
		whenClosedDo: [ self unsubscribeFromAnnouncements ];
		whenResizingDo: [ :ann | self class preferredExtent: ann newSize ];
		bindKeyCombination: (self shortcutForPanel: 1) 
			toAction: [ pageList takeKeyboardFocus ];
		bindKeyCombination: (self shortcutForPanel: 2) 
			toAction: [ pageContent firstResponder takeKeyboardFocus ]
]

{ #category : #accessing }
StPlaybook >> playbook [

	^ playbook ifNil: [ playbook := self class defaultPlaybook ]
]

{ #category : #private }
StPlaybook >> refreshPageListOrder [
	| selectedMove |

	selectedMove := pageList selection selectedItem ifNotNil: #move.
	pageList presenters: self allMovePresenters.
	selectedMove ifNotNil: [ 
		pageList selectItem: (pageList presenters detect: [ :each | each move = selectedMove ]) ]
]

{ #category : #initialization }
StPlaybook >> setModelBeforeInitialization: aBook [

	playbook := aBook
]

{ #category : #private }
StPlaybook >> sortFunction [

	^ sortFunction
]

{ #category : #initialization }
StPlaybook >> subscribeToAnnouncements [

	StPlaybookFlushService uniqueInstance announcer
		when: StPlaybookFlushStartAnnouncement send: #flushStart: to: self;
		when: StPlaybookFlushEndAnnouncement send: #flushEnd: to: self
]

{ #category : #initialization }
StPlaybook >> unsubscribeFromAnnouncements [
	
	StPlaybookFlushService uniqueInstance announcer
		unsubscribe: self
]
