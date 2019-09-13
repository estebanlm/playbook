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

{ #category : #accessing }
StPlaybookBook >> directory [

	^ directory
]

{ #category : #accessing }
StPlaybookBook >> firstMove [

	^ StPlaybookMove 
		newDirectory: self directory 
		number: 1
]

{ #category : #initialization }
StPlaybookBook >> initializeDirectory: aDirectory [ 

	directory := aDirectory.
	self initialize
]
