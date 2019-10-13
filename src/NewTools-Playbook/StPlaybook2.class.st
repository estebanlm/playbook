Class {
	#name : #StPlaybook2,
	#superclass : #StPresenter,
	#instVars : [
		'pageList',
		'playbook'
	],
	#category : #'NewTools-Playbook-View'
}

{ #category : #'as yet unclassified' }
StPlaybook2 class >> defaultPlaybook [

	^ StPlaybookBook newDefault
]

{ #category : #specs }
StPlaybook2 class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #pageList;
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

	pageList := self newComponentList
		presenters: self allMovePresenters;
		yourself
]

{ #category : #accessing }
StPlaybook2 >> playbook [

	^ playbook ifNil: [ playbook := self class defaultPlaybook ]
]
