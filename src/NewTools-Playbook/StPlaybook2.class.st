Class {
	#name : #StPlaybook2,
	#superclass : #StPresenter,
	#instVars : [
		'playbook',
		'pageListHeader',
		'pageList',
		'actionBar',
		'pageContentHeader',
		'pageContent'
	],
	#classVars : [
		'PreferredExtent'
	],
	#category : #'NewTools-Playbook-View'
}

{ #category : #accessing }
StPlaybook2 class >> defaultPlaybook [

	^ StPlaybookBook newDefault
]

{ #category : #specs }
StPlaybook2 class >> defaultSpec [

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

{ #category : #settings }
StPlaybook2 class >> preferredExtent [

	^ PreferredExtent ifNil: [ PreferredExtent := 800@450 ]
]

{ #category : #settings }
StPlaybook2 class >> preferredExtent: aPoint [

	PreferredExtent = aPoint ifTrue: [ ^ self ].
	PreferredExtent := aPoint
]

{ #category : #private }
StPlaybook2 >> allMovePresenters [

	^ self allMoves collect: [ :each | self instantiate: StPlaybookPage on: each ]
]

{ #category : #accessing }
StPlaybook2 >> allMoves [

	^ self playbook 
		ifNotNil: [ :book | book allMoves ]
		ifNil: [ #() ]
]

{ #category : #private }
StPlaybook2 >> flushEnd: ann [

	pageContent popMessage
]

{ #category : #private }
StPlaybook2 >> flushStart: ann [

	pageContent pushMessage: 'Saving...'
]

{ #category : #initialization }
StPlaybook2 >> initializePresenters [

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
StPlaybook2 >> initializeWindow: aWindowPresenter [
	
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
StPlaybook2 >> playbook [

	^ playbook ifNil: [ playbook := self class defaultPlaybook ]
]

{ #category : #initialization }
StPlaybook2 >> subscribeToAnnouncements [

	StPlaybookFlushService uniqueInstance announcer
		when: StPlaybookFlushStartAnnouncement send: #flushStart: to: self;
		when: StPlaybookFlushEndAnnouncement send: #flushEnd: to: self
]

{ #category : #initialization }
StPlaybook2 >> unsubscribeFromAnnouncements [
	
	StPlaybookFlushService uniqueInstance announcer
		unsubscribe: self
]
