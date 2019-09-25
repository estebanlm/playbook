Class {
	#name : #StPlaybookFlushService,
	#superclass : #TKTService,
	#instVars : [
		'mutex',
		'moves',
		'announcer'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'NewTools-Playbook-Model'
}

{ #category : #'instance creation' }
StPlaybookFlushService class >> new [

	self error: 'Use #uniqueInstance'
]

{ #category : #accessing }
StPlaybookFlushService class >> stepDelay [

	^ 30 seconds
]

{ #category : #'instance creation' }
StPlaybookFlushService class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self basicNew initialize ]
]

{ #category : #accessing }
StPlaybookFlushService >> announcer [

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #stepping }
StPlaybookFlushService >> basicStepService [

	moves ifEmpty: [ ^ self ].
	self announcer announce: StPlaybookFlushStartAnnouncement.
	[	
		moves do: #flush.
	 	moves removeAll ]
	ensure: [
		self announcer announce: StPlaybookFlushEndAnnouncement ]
]

{ #category : #private }
StPlaybookFlushService >> ensureRunning [
	
	self isRunning ifTrue: [ ^ self ].
	self start
]

{ #category : #initialization }
StPlaybookFlushService >> initialize [

	super initialize.
	self stepDelay: self class stepDelay.
	mutex := Mutex new.
	moves := Set new
]

{ #category : #accessing }
StPlaybookFlushService >> name [
	
	^ 'StPlaybook Flush Service'
]

{ #category : #accessing }
StPlaybookFlushService >> queue: aMove [

	self ensureRunning.
	mutex critical: [ 
		moves add: aMove ]
]

{ #category : #stepping }
StPlaybookFlushService >> stepService [

	mutex critical: [ 
		self basicStepService ]
]
