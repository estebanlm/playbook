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

{ #category : #accessing }
StPlaybook class >> defaultExtent [

	^ 600@400
]

{ #category : #specs }
StPlaybook class >> defaultSpec [

	^ SpPanedLayout newHorizontal
		position: 25 percent;
		add: (SpBoxLayout newVertical
			add: #pageList;
			addLast: #actionBar expand: false fill: false padding: 0);
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

{ #category : #actions }
StPlaybook >> addNew [

	
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
		initialExtent: self preferredExtent
]

{ #category : #accessing }
StPlaybook >> playbook [

	^ playbook
]

{ #category : #initialization }
StPlaybook >> preferredExtent [

	^ PreferredExtent ifNil: [ PreferredExtent := self class defaultExtent ]
]
