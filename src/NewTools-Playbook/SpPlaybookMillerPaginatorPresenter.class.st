Class {
	#name : #SpPlaybookMillerPaginatorPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'shownPages',
		'thumbnailList',
		'millerList'
	],
	#category : #'NewTools-Playbook'
}

{ #category : #specs }
SpPlaybookMillerPaginatorPresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		borderWidth: 5;
		spacing: 5;
		add: #shownPages expand: false fill: false padding: 0;
		add: #thumbnailList;
		yourself
]

{ #category : #initialization }
SpPlaybookMillerPaginatorPresenter >> initializeWidgets [
	
	shownPages := self newDropList 
		items: (1 to: 10) asArray;
		display: [ :each | each asString ];
		yourself.
		
	thumbnailList := self newList.
]

{ #category : #accessing }
SpPlaybookMillerPaginatorPresenter >> millerList: aMillerListPresenter [

	millerList := aMillerListPresenter.
	self reset
]

{ #category : #accessing }
SpPlaybookMillerPaginatorPresenter >> reset [

	shownPages selectItem: millerList shownPages
]
