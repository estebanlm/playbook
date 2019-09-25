Class {
	#name : #StPlaybookRenameCommand,
	#superclass : #StPlaybookCommand,
	#category : #'NewTools-Playbook-Command'
}

{ #category : #default }
StPlaybookRenameCommand class >> defaultDescription [

	^ 'Rename current page'
]

{ #category : #default }
StPlaybookRenameCommand class >> defaultName [

	^ 'Rename'
]

{ #category : #executing }
StPlaybookRenameCommand >> execute [

	self context renameCurrent
]
