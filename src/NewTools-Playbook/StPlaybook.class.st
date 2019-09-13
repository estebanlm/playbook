Class {
	#name : #StPlaybook,
	#superclass : #StPresenter,
	#instVars : [
		'pageList',
		'playbook'
	],
	#category : #'NewTools-Playbook'
}

{ #category : #accessing }
StPlaybook >> firstMove [

	^ StPlaybookMove 
		newDirectory: self directory 
		number: 1
]

{ #category : #initialization }
StPlaybook >> initialize [
	
	playbook := StPlaybookBook newDefault.
	super initialize
]

{ #category : #initialization }
StPlaybook >> initializeWidgets [

	pageList := self instantiate: SpMillerColumnPresenter.
	pageList presenterBlock: [ :aMove |
		StPlaybookMovePresenter on: aMove nextMove ].
	pageList setRootModel: playbook firstMove
]

{ #category : #initialization }
StPlaybook >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: 'Playbook';
		initialExtent: 600@300
]
