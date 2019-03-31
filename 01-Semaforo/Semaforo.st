!classDefinition: #OrquestadorDeSe�alesDeTransito category: #Semaforo!
DenotativeObjectMorph subclass: #OrquestadorDeSe�alesDeTransito
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OrquestadorDeSe�alesDeTransito class' category: #Semaforo!
OrquestadorDeSe�alesDeTransito class
	instanceVariableNames: ''!

!OrquestadorDeSe�alesDeTransito class methodsFor: 'morph' stamp: 'J.S 3/31/2019 14:17:56'!
createMorph

	^LayoutMorph newColumn
		morphExtent: 60 @ 130;
		yourself
! !


!OrquestadorDeSe�alesDeTransito class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 15:25:36'!
apagarSe�ales
	UnaSe�alDeDetencion apagar.
	UnaSe�alDePrecaucion apagar.
	UnaSe�alDeAvance apagar.! !

!OrquestadorDeSe�alesDeTransito class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 15:28:38'!
titilarSe�alDePrevencion: unaCantidadDeVeces
	unaCantidadDeVeces timesRepeat: [
		UnaSe�alDePrecaucion prender.
		(Delay forSeconds: 1) wait.
		UnaSe�alDePrecaucion apagar.
		(Delay forSeconds: 1) wait.
	]! !


!OrquestadorDeSe�alesDeTransito class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 15:42:23'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #UnaSe�alDeAvance category: #Semaforo!
DenotativeObjectMorph subclass: #UnaSe�alDeAvance
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UnaSe�alDeAvance class' category: #Semaforo!
UnaSe�alDeAvance class
	instanceVariableNames: ''!

!UnaSe�alDeAvance class methodsFor: 'morph' stamp: 'J.S 3/31/2019 13:21:43'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!UnaSe�alDeAvance class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 14:37:15'!
apagar

self color: Color black.! !

!UnaSe�alDeAvance class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 14:35:35'!
prender

self color: Color green! !


!UnaSe�alDeAvance class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 15:42:23'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #UnaSe�alDeDetencion category: #Semaforo!
DenotativeObjectMorph subclass: #UnaSe�alDeDetencion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UnaSe�alDeDetencion class' category: #Semaforo!
UnaSe�alDeDetencion class
	instanceVariableNames: ''!

!UnaSe�alDeDetencion class methodsFor: 'morph' stamp: 'J.S 3/31/2019 14:16:39'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!UnaSe�alDeDetencion class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 14:39:00'!
apagar

self color: Color black.! !

!UnaSe�alDeDetencion class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 14:40:26'!
prender

self color: Color red! !


!UnaSe�alDeDetencion class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 15:42:23'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #UnaSe�alDePrecaucion category: #Semaforo!
DenotativeObjectMorph subclass: #UnaSe�alDePrecaucion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UnaSe�alDePrecaucion class' category: #Semaforo!
UnaSe�alDePrecaucion class
	instanceVariableNames: ''!

!UnaSe�alDePrecaucion class methodsFor: 'morph' stamp: 'J.S 3/31/2019 14:16:48'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!UnaSe�alDePrecaucion class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 14:39:10'!
apagar

self color: Color black.! !

!UnaSe�alDePrecaucion class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 14:40:36'!
prender

self color: Color yellow.! !


!UnaSe�alDePrecaucion class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 15:42:23'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SemaforoDeCanningYCorrientes category: #Semaforo!
DenotativeObject subclass: #SemaforoDeCanningYCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SemaforoDeCanningYCorrientes class' category: #Semaforo!
SemaforoDeCanningYCorrientes class
	instanceVariableNames: ''!

!SemaforoDeCanningYCorrientes class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 15:30:43'!
avisarPrecaucionPorEncendido
	OrquestadorDeSe�alesDeTransito apagarSe�ales.
	OrquestadorDeSe�alesDeTransito titilarSe�alDePrevencion: 5.
	! !

!SemaforoDeCanningYCorrientes class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 15:32:26'!
prender
	self avisarPrecaucionPorEncendido.
	
	
	! !

OrquestadorDeSe�alesDeTransito initializeAfterFileIn!
UnaSe�alDeAvance initializeAfterFileIn!
UnaSe�alDeDetencion initializeAfterFileIn!
UnaSe�alDePrecaucion initializeAfterFileIn!