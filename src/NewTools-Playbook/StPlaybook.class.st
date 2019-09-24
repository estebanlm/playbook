Class {
	#name : #StPlaybook,
	#superclass : #StPresenter,
	#instVars : [
		'pageList',
		'pageContent',
		'paginator',
		'playbook',
		'actionBar'
	],
	#classVars : [
		'PreferredExtent'
	],
	#category : #'NewTools-Playbook'
}

{ #category : #specs }
StPlaybook class >> defaultSpec [

	^ SpBoxLayout newHorizontal
		spacing: 5;
		add: (SpBoxLayout newVertical
				add: #pageList;
				addLast: #actionBar expand: false fill: false padding: 0;
				yourself)
			expand: false 
			fill: false
			padding: 0;
		add: #pageContent;
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
	
	^ self new openWithSpec
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
StPlaybook >> initialize [
	
	playbook := StPlaybookBook newDefault.
	super initialize
]

{ #category : #initialization }
StPlaybook >> initializePresenters [

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
		title: 'Playbook';
		initialExtent: self preferredExtent;
		whenResizingDo: [ :ann | self preferredExtent: ann newSize ]
]

{ #category : #initialization }
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

{ #category : #initialization }
StPlaybook >> preferredExtent [

	^ PreferredExtent ifNil: [ PreferredExtent := super preferredExtent ]
]

{ #category : #initialization }
StPlaybook >> preferredExtent: aPoint [

	PreferredExtent = aPoint ifTrue: [ ^ self ].
	PreferredExtent := aPoint
]

{ #category : #actions }
StPlaybook >> renameCurrent [
]
