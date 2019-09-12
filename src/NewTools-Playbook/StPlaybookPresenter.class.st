Class {
	#name : #StPlaybookPresenter,
	#superclass : #StPresenter,
	#instVars : [
		'pageList',
		'playbook'
	],
	#category : #'NewTools-Playbook'
}

{ #category : #specs }
StPlaybookPresenter class >> defaultSpec [

	^ SpScrollableLayout new
		add: #pageList;
		yourself
]

{ #category : #initialization }
StPlaybookPresenter >> initialize [
	
	playbook := StPlaybook newDefault.
	super initialize
]

{ #category : #initialization }
StPlaybookPresenter >> initializeWidgets [

	pageList := self instantiate: SpPlaybookMillerPresenter.
	pageList presenterBlock: [ :aMove |
		(StPlaybookMovePresenter on: aMove)
			onExpand: [ :aPresenter | 
				pageList 
					changeSelection: aMove nextMove
					from: aPresenter ];
			yourself ].
	pageList setRootModel: playbook firstMove
]

{ #category : #initialization }
StPlaybookPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: 'Playbook';
		initialExtent: 600@300
]
