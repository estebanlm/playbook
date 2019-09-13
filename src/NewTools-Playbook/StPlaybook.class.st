Class {
	#name : #StPlaybook,
	#superclass : #StPresenter,
	#instVars : [
		'pageList',
		'playbook',
		'showPages',
		'pageThumbs'
	],
	#category : #'NewTools-Playbook'
}

{ #category : #specs }
StPlaybook class >> defaultSpec [

	^ SpBoxLayout newHorizontal 
		add: (SpScrollableLayout new
			add: #pageList;
			yourself);
		addLast: (SpBoxLayout newVertical
				add: #showPages expand: false fill: false padding: 0;
				add: #pageThumbs;
				yourself) 
			expand: false 
			fill: false 
			padding: 0;
		yourself 
]

{ #category : #initialization }
StPlaybook >> initialize [
	
	playbook := StPlaybookBook newDefault.
	super initialize
]

{ #category : #initialization }
StPlaybook >> initializeWidgets [

	pageList := self instantiate: SpPlaybookMillerPresenter.
	pageList presenterBlock: [ :aMove |
		StPlaybookMovePresenter on: aMove nextMove ].
	pageList setRootModel: playbook firstMove.
	
	showPages := self newDropList 
		items: (1 to: 10) asArray;
		display: [ :each | each asString ];
		yourself.
		
	pageThumbs := self newLabel label: '?'
]

{ #category : #initialization }
StPlaybook >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: 'Playbook';
		initialExtent: 600@300
]
