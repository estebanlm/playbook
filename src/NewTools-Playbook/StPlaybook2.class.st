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
	#category : #'NewTools-Playbook-View'
}

{ #category : #'as yet unclassified' }
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

{ #category : #initialization }
StPlaybook2 >> initializePresenters [

	pageListHeader := self instantiate: StHeaderBar.
	pageListHeader 
		label: 'Playgrounds';
		shortcut: $1 command mac | $1 control win | $1 control unix.
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
		shortcut: $2 command mac | $2 control win | $2 control unix.	
	pageContent := self instantiate: StPlaybookPlayground.
	
	pageList transmitTo: pageContent transform: [ :page | page move ].
	pageList selectIndex: 1
]

{ #category : #accessing }
StPlaybook2 >> playbook [

	^ playbook ifNil: [ playbook := self class defaultPlaybook ]
]
