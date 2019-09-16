Class {
	#name : #StPlaybookBook,
	#superclass : #Object,
	#instVars : [
		'directory',
		'playbook'
	],
	#category : #'NewTools-Playbook'
}

{ #category : #private }
StPlaybookBook class >> bibliotequeDirectory [

	^ FileLocator localDirectory / 'books'
]

{ #category : #private }
StPlaybookBook class >> defaultDirectory [

	^ (self bibliotequeDirectory / 'default') ensureCreateDirectory
]

{ #category : #'instance creation' }
StPlaybookBook class >> newDefault [

	^ self newDirectory: self defaultDirectory
]

{ #category : #'instance creation' }
StPlaybookBook class >> newDirectory: aDirectory [

	^ self basicNew
		initializeDirectory: aDirectory;
		yourself
]

{ #category : #initialization }
StPlaybookBook >> addFirstMoveIfNeeded [

	self allFiles ifNotEmpty: [ ^ self ].
	
	(self directory / self firstMoveName) ensureCreateFile
]

{ #category : #private }
StPlaybookBook >> allFiles [

	^ self directory filesMatching: '*.st'
]

{ #category : #accessing }
StPlaybookBook >> allMoves [

	^ self allFiles
		collect: [ :each | StPlaybookMove fromReference: each ]
]

{ #category : #accessing }
StPlaybookBook >> directory [

	^ directory
]

{ #category : #private }
StPlaybookBook >> firstMoveName [

	^ '1.st'
]

{ #category : #initialization }
StPlaybookBook >> initialize [

	super initialize.
	self addFirstMoveIfNeeded
]

{ #category : #initialization }
StPlaybookBook >> initializeDirectory: aDirectory [ 

	directory := aDirectory.
	self initialize
]
