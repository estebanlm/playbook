Class {
	#name : #StPlaybookOLD,
	#superclass : #StPresenter,
	#instVars : [
		'pageListHeader',
		'pageList',
		'pageContent',
		'pageContentHeader',
		'playbook',
		'actionBar'
	],
	#classVars : [
		'PreferredExtent'
	],
	#category : #'NewTools-Playbook-View'
}

{ #category : #specs }
StPlaybookOLD class >> defaultSpec [

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

{ #category : #'instance creation' }
StPlaybookOLD class >> open [ 
	
	^ self openOn: StPlaybookBook newDefault
]

{ #category : #'instance creation' }
StPlaybookOLD class >> openOn: aPlaybook [
	
	^ (self on: aPlaybook) openWithSpec
]

{ #category : #'instance creation' }
StPlaybookOLD class >> openOnDirectory: aDirectory [

	^ self openOn: (StPlaybookBook newDirectory: aDirectory)
]

{ #category : #initialization }
StPlaybookOLD class >> preferredExtent [

	^ PreferredExtent ifNil: [ PreferredExtent := 800@450 ]
]

{ #category : #initialization }
StPlaybookOLD class >> preferredExtent: aPoint [

	PreferredExtent = aPoint ifTrue: [ ^ self ].
	PreferredExtent := aPoint
]

{ #category : #icons }
StPlaybookOLD class >> taskbarIconName [
	"Answer the icon for the receiver in a task bar."

	^ #workspaceIcon
]

{ #category : #actions }
StPlaybookOLD >> addNew [
	| newMove |

	newMove := self playbook addNew.
	pageList 
		items: self playbook allMoves;
		selectItem: newMove
]

{ #category : #actions }
StPlaybookOLD >> deleteCurrent [
]

{ #category : #initialization }
StPlaybookOLD >> flushEnd: ann [

	pageContent popMessage
]

{ #category : #initialization }
StPlaybookOLD >> flushStart: ann [

	pageContent pushMessage: 'Saving...'
]

{ #category : #initialization }
StPlaybookOLD >> initializePresenters [

	pageListHeader := self instantiate: StHeaderBar.
	pageListHeader 
		label: 'Playgrounds';
		shortcut: (self shortcutForPanel: 1).
	pageList := self newList
		items: self playbook allMoves;
		display: #name;
		contextMenu: self pageListMenu;
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
	
	pageList transmitTo: pageContent.
	pageList selectIndex: 1
]

{ #category : #initialization }
StPlaybookOLD >> initializeWindow: aWindowPresenter [
	
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

{ #category : #private }
StPlaybookOLD >> pageListMenu [
	
	^ CmCommandGroup forSpec
		beDisplayedAsGroup;
		register: (StPlaybookRenameCommand forSpecContext: self);
		register: (StPlaybookDeleteCommand forSpecContext: self);
		asMenuPresenter
]

{ #category : #accessing }
StPlaybookOLD >> playbook [

	^ playbook
]

{ #category : #actions }
StPlaybookOLD >> renameCurrent [
]

{ #category : #initialization }
StPlaybookOLD >> setModelBeforeInitialization: aPlaybook [

	playbook := aPlaybook
]

{ #category : #initialization }
StPlaybookOLD >> subscribeToAnnouncements [

	StPlaybookFlushService uniqueInstance announcer
		when: StPlaybookFlushStartAnnouncement send: #flushStart: to: self;
		when: StPlaybookFlushEndAnnouncement send: #flushEnd: to: self
]

{ #category : #initialization }
StPlaybookOLD >> unsubscribeFromAnnouncements [
	
	StPlaybookFlushService uniqueInstance announcer
		unsubscribe: self
]
