Class {
	#name : #StPlaybook,
	#superclass : #StPresenter,
	#instVars : [
		'pageList',
		'pageContent',
		'paginator',
		'playbook'
	],
	#category : #'NewTools-Playbook'
}

{ #category : #specs }
StPlaybook class >> defaultSpec [

	^ SpPanedLayout newHorizontal
		position: 25 percent;
		add: #pageList;
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
	pageContent := self instantiate: StPlaybookPlayground.
	
	pageList transmitTo: pageContent.

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
		initialExtent: 700@400
]

{ #category : #accessing }
StPlaybook >> playbook [

	^ playbook
]
