Class {
	#name : #StPlaybookMove,
	#superclass : #Object,
	#instVars : [
		'reference'
	],
	#category : #'NewTools-Playbook'
}

{ #category : #'instance creation' }
StPlaybookMove class >> fromReference: aReference [

	^ self new fromReference: aReference.

]

{ #category : #'instance creation' }
StPlaybookMove class >> newDirectory: aDirectory name: aName [

	^ self fromReference: aDirectory / aName
]

{ #category : #'instance creation' }
StPlaybookMove class >> newDirectory: aDirectory number: aNumber [

	^ self 
		newDirectory: aDirectory 
		name: ('{1}.st' format: { aNumber }) 
]

{ #category : #comparing }
StPlaybookMove >> = aMove [

	^ self species = aMove species 
		and: [ self reference = aMove reference ]
]

{ #category : #accessing }
StPlaybookMove >> contents [

	self reference exists ifFalse: [ ^ '' ].
	^ self reference contents
]

{ #category : #accessing }
StPlaybookMove >> contents: aString [

	self reference 
		ensureDelete;
		writeStreamDo: [ :stream | 
			stream nextPutAll: aString ]
]

{ #category : #initialize }
StPlaybookMove >> fromReference: aReference [

	reference := aReference.
	reference ensureCreateFile
]

{ #category : #comparing }
StPlaybookMove >> hash [
		
	^ self species hash bitXor: self reference hash
]

{ #category : #accessing }
StPlaybookMove >> name [

	^ self reference basenameWithoutExtension
]

{ #category : #accessing }
StPlaybookMove >> nextMove [

	^ self class 
		newDirectory: self reference parent 
		number: self number + 1
]

{ #category : #accessing }
StPlaybookMove >> number [

	^ self reference basenameWithoutExtension asNumber
]

{ #category : #accessing }
StPlaybookMove >> reference [

	^ reference
]
