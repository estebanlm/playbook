Class {
	#name : #StPlaybook,
	#superclass : #StPresenter,
	#instVars : [
		'pageList',
		'playbook',
		'paginator'
	],
	#category : #'NewTools-Playbook'
}

{ #category : #specs }
StPlaybook class >> defaultSpec [

	^ SpBoxLayout newHorizontal
		add: #paginator expand: false fill: false padding: 0;
		add: (SpScrollableLayout new
			add: #pageList;
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

	pageList := self instantiate: SpPlaybookMillerListPresenter.
	pageList shownPages: 2.
	pageList presenterBlock: [ :aMove |
		StPlaybookMovePresenter on: aMove nextMove ].
	pageList setRootModel: playbook firstMove.
	
	paginator := self instantiate: SpPlaybookMillerPaginatorPresenter.
	paginator millerList: pageList
]

{ #category : #initialization }
StPlaybook >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: 'Playbook';
		initialExtent: 600@300
]
