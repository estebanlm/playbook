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
		add: (SpScrollableLayout new
			add: #pageList;
			yourself);
		addLast: #paginator expand: false fill: false padding: 0;
		yourself 
]

{ #category : #initialization }
StPlaybook >> initialize [
	
	playbook := StPlaybookBook newDefault.
	super initialize
]

{ #category : #initialization }
StPlaybook >> initializeWidgets [

	pageList := self instantiate: SpPlaybookMillerListPresenter.
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
