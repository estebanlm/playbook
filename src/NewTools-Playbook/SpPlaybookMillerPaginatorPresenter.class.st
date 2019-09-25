Class {
	#name : #SpPlaybookMillerPaginatorPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'shownPages',
		'thumbnailList',
		'millerList'
	],
	#category : #'NewTools-Playbook-View'
}

{ #category : #specs }
SpPlaybookMillerPaginatorPresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		"add: #shownPages expand: false fill: false padding: 0;"
		add: #thumbnailList;
		yourself
]

{ #category : #initialization }
SpPlaybookMillerPaginatorPresenter >> initializePresenters [
	
	"shownPages := self newDropList 
		items: (1 to: 10) asArray;
		display: [ :each | each asString ];
		whenSelectionChangedDo: [ millerList shownPages: shownPages selectedItem ];
		yourself."
		
	thumbnailList := self newList
		display: [ :each | each asString ];
		yourself.
]

{ #category : #accessing }
SpPlaybookMillerPaginatorPresenter >> millerList: aMillerListPresenter [

	"To avoid cycles"
	millerList = aMillerListPresenter ifTrue: [ ^ self ].
	
	millerList := aMillerListPresenter.
	millerList paginator: self.
	self reset
]

{ #category : #accessing }
SpPlaybookMillerPaginatorPresenter >> reset [

	"shownPages selectItem: millerList shownPages."
	thumbnailList items: (millerList pages withIndexCollect: [ :each :index | index ]).
	
]
