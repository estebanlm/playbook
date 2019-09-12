Class {
	#name : #StPlaybookMove,
	#superclass : #Object,
	#instVars : [
		'name',
		'contents'
	],
	#category : #'NewTools-Playbook'
}

{ #category : #'instance creation' }
StPlaybookMove class >> newName: aName [

	^ self new
		name: aName;
		yourself
]

{ #category : #'instance creation' }
StPlaybookMove class >> newReference: aReference [

	aReference exists ifFalse: [ 
		^ self newName: aReference basenameWithoutExtension ].

	^ aReference readStreamDo: [ :stream | 
		self newStream: stream ]
]

{ #category : #'instance creation' }
StPlaybookMove class >> newStream: stream [

	^ STON fromStream: stream
]

{ #category : #accessing }
StPlaybookMove >> contents [

	^ contents ifNil: [ contents := '' ]
]

{ #category : #accessing }
StPlaybookMove >> contents: aString [

	contents := aString
]

{ #category : #accessing }
StPlaybookMove >> name [
	^ name
]

{ #category : #accessing }
StPlaybookMove >> name: aString [

	name := aString
]
