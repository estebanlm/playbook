Class {
	#name : #StPlaybookPage,
	#superclass : #SpPresenter,
	#instVars : [
		'titleLabel',
		'dateLabel',
		'move'
	],
	#category : #'NewTools-Playbook-View'
}

{ #category : #specs }
StPlaybookPage class >> defaultSpec [

	^ SpBoxLayout newVertical 
		add: #titleLabel expand: false;
		add: #dateLabel expand: false;
		yourself
]

{ #category : #initialization }
StPlaybookPage >> initializePresenters [

	titleLabel := self newLabel label: self move name.
	dateLabel := self newLabel 
		label: self move modificationTimeAsHumanReadable;
		addStyle: 'dim';
		yourself
]

{ #category : #accessing }
StPlaybookPage >> move [

	^ move
]

{ #category : #initialization }
StPlaybookPage >> setModelBeforeInitialization: aMove [

	move := aMove
]
