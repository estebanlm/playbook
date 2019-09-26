Class {
	#name : #StPlaybook,
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

{ #category : #specs }
StPlaybook class >> defaultSpecOLD [

	^ SpPanedLayout newHorizontal
		position: 30 percent;
		add: #pageList;
		add: (SpBoxLayout newHorizontal
			add: (SpScrollableLayout new
				add: #pageContent;
				yourself);
			addLast: #paginator expand: false fill: false padding: 0;
			yourself);
		yourself 
]

{ #category : #icons }
StPlaybook class >> menuCommandOn: aBuilder [
	<worldMenu>
	
	(aBuilder item: #Playbook)
		parent: #Tools;
		action: [ StPlaybook open ];
		order: 15;
		help: 'A window used as a scratchpad area where fragments of Pharo code can be entered, stored, edited, and evaluated.';
		icon: (self iconNamed: #workspaceIcon)
]

{ #category : #'instance creation' }
StPlaybook class >> open [ 
	
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

{ #category : #initialization }
StPlaybook class >> preferredExtent [

	^ PreferredExtent ifNil: [ PreferredExtent := 800@450 ]
]

{ #category : #initialization }
StPlaybook class >> preferredExtent: aPoint [

	PreferredExtent = aPoint ifTrue: [ ^ self ].
	PreferredExtent := aPoint
]

{ #category : #icons }
StPlaybook class >> taskbarIconName [
	"Answer the icon for the receiver in a task bar."

	^ #workspaceIcon
]

{ #category : #actions }
StPlaybook >> addNew [
	| newMove |

	newMove := self playbook addNew.
	pageList 
		items: self playbook allMoves;
		selectItem: newMove
]

{ #category : #actions }
StPlaybook >> deleteCurrent [
]

{ #category : #initialization }
StPlaybook >> flushEnd: ann [

	pageContent popMessage
]

{ #category : #initialization }
StPlaybook >> flushStart: ann [

	pageContent pushMessage: 'Saving...'
]

{ #category : #initialization }
StPlaybook >> initializePresenters [

	pageListHeader := self instantiate: StHeaderBar.
	pageListHeader 
		label: 'Playgrounds';
		shortcut: $1 command mac | $1 control win | $1 control unix.
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
		shortcut: $2 command mac | $2 control win | $2 control unix.	
	pageContent := self instantiate: StPlaybookPlayground.
	
	pageList transmitTo: pageContent.
	pageList selectIndex: 1.	

	"pageContent := self instantiate: SpPlaybookMillerListPresenter.
	pageContent shownPages: 2.
	pageContent presenterBlock: [ :aMove |
		StPlaybookPlayground on: aMove nextMove ].
	pageContent setRootModel: playbook firstMove.
	
	paginator := self instantiate: SpPlaybookMillerPaginatorPresenter.
	paginator millerList: pageContent"
]

{ #category : #initialization }
StPlaybook >> initializeWindow: aWindowPresenter [
	
	aWindowPresenter
		title: 'Playbook: ', self playbook title;
		initialExtent: self class preferredExtent;
		whenOpenedDo: [ self subscribeToAnnouncements ];
		whenClosedDo: [ self unsubscribeFromAnnouncements ];
		whenResizingDo: [ :ann | self class preferredExtent: ann newSize ];
		bindKeyCombination: (self shortcutForPanel: 1) toAction: [ pageList takeKeyboardFocus ];
		bindKeyCombination: (self shortcutForPanel: 2) toAction: [ pageContent takeKeyboardFocus ]
]

{ #category : #private }
StPlaybook >> pageListMenu [
	
	^ CmCommandGroup forSpec
		beDisplayedAsGroup;
		register: (StPlaybookRenameCommand forSpecContext: self);
		register: (StPlaybookDeleteCommand forSpecContext: self);
		asMenuPresenter
]

{ #category : #accessing }
StPlaybook >> playbook [

	^ playbook
]

{ #category : #actions }
StPlaybook >> renameCurrent [
]

{ #category : #initialization }
StPlaybook >> setModelBeforeInitialization: aPlaybook [

	playbook := aPlaybook
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
