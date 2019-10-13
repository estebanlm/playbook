Class {
	#name : #StPlaybookMove,
	#superclass : #Object,
	#instVars : [
		'reference',
		'buffer'
	],
	#category : #'NewTools-Playbook-Model'
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

	^ buffer ifNil: [ 
		self reference exists ifFalse: [ ^ '' ].
		self reference contents ]
]

{ #category : #accessing }
StPlaybookMove >> contents: aString [

	buffer := aString.
	StPlaybookFlushService uniqueInstance queue: self
]

{ #category : #accessing }
StPlaybookMove >> flush [

	[ 
		self reference
			ensureDelete;
			writeStreamDo: [ :stream | stream nextPutAll: buffer ] ]
	ensure: [ 
		buffer := nil ]
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
StPlaybookMove >> modificationTimeAsHumanReadable [

	^ (DateAndTime now - self reference accessTime) humanReadablePrintString 
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
