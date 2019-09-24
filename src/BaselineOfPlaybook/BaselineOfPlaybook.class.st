Class {
	#name : #BaselineOfPlaybook,
	#superclass : #BaselineOf,
	#category : #BaselineOfPlaybook
}

{ #category : #baselines }
BaselineOfPlaybook >> baseline: spec [

	spec for: #common do: [ 
		spec package: 'NewTools-Playbook' ]
]
