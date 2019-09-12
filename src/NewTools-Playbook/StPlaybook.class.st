Class {
	#name : #StPlaybook,
	#superclass : #Object,
	#instVars : [
		'directory'
	],
	#category : #'NewTools-Playbook'
}

{ #category : #private }
StPlaybook class >> bibliotequeDirectory [

	^ FileLocator localDirectory / 'books'
]

{ #category : #private }
StPlaybook class >> defaultDirectory [

	^ (self bibliotequeDirectory / 'default') ensureCreateDirectory
]

{ #category : #'instance creation' }
StPlaybook class >> newDefault [

	^ self newDirectory: self defaultDirectory
]

{ #category : #'instance creation' }
StPlaybook class >> newDirectory: aDirectory [

	^ self basicNew
		initializeDirectory: aDirectory;
		yourself
]

{ #category : #accessing }
StPlaybook >> directory [

	^ directory
]

{ #category : #accessing }
StPlaybook >> firstMove [

	^ StPlaybookMove 
		newDirectory: self directory 
		number: 1
]

{ #category : #initialization }
StPlaybook >> initializeDirectory: aDirectory [ 

	directory := aDirectory.
	self initialize
]
