Class {
	#name : #StPlaybookDeleteCommand,
	#superclass : #StPlaybookCommand,
	#category : #'NewTools-Playbook-Command'
}

{ #category : #default }
StPlaybookDeleteCommand class >> defaultDescription [

	^ 'Delete current page'
]

{ #category : #default }
StPlaybookDeleteCommand class >> defaultName [

	^ 'Delete'
]

{ #category : #executing }
StPlaybookDeleteCommand >> execute [


	self context deleteCurrent
]
