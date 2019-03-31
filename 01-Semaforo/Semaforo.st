!classDefinition: #OrquestadorDeSeñalesDeTransito category: #Semaforo!
DenotativeObjectMorph subclass: #OrquestadorDeSeñalesDeTransito
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OrquestadorDeSeñalesDeTransito class' category: #Semaforo!
OrquestadorDeSeñalesDeTransito class
	instanceVariableNames: ''!

!OrquestadorDeSeñalesDeTransito class methodsFor: 'morph' stamp: 'J.S 3/31/2019 14:17:56'!
createMorph

	^LayoutMorph newColumn
		morphExtent: 60 @ 130;
		yourself
! !


!OrquestadorDeSeñalesDeTransito class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 15:25:36'!
apagarSeñales
	UnaSeñalDeDetencion apagar.
	UnaSeñalDePrecaucion apagar.
	UnaSeñalDeAvance apagar.! !

!OrquestadorDeSeñalesDeTransito class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 15:28:38'!
titilarSeñalDePrevencion: unaCantidadDeVeces
	unaCantidadDeVeces timesRepeat: [
		UnaSeñalDePrecaucion prender.
		(Delay forSeconds: 1) wait.
		UnaSeñalDePrecaucion apagar.
		(Delay forSeconds: 1) wait.
	]! !


!OrquestadorDeSeñalesDeTransito class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 15:42:23'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #UnaSeñalDeAvance category: #Semaforo!
DenotativeObjectMorph subclass: #UnaSeñalDeAvance
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UnaSeñalDeAvance class' category: #Semaforo!
UnaSeñalDeAvance class
	instanceVariableNames: ''!

!UnaSeñalDeAvance class methodsFor: 'morph' stamp: 'J.S 3/31/2019 13:21:43'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!UnaSeñalDeAvance class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 14:37:15'!
apagar

self color: Color black.! !

!UnaSeñalDeAvance class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 14:35:35'!
prender

self color: Color green! !


!UnaSeñalDeAvance class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 15:42:23'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #UnaSeñalDeDetencion category: #Semaforo!
DenotativeObjectMorph subclass: #UnaSeñalDeDetencion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UnaSeñalDeDetencion class' category: #Semaforo!
UnaSeñalDeDetencion class
	instanceVariableNames: ''!

!UnaSeñalDeDetencion class methodsFor: 'morph' stamp: 'J.S 3/31/2019 14:16:39'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!UnaSeñalDeDetencion class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 14:39:00'!
apagar

self color: Color black.! !

!UnaSeñalDeDetencion class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 14:40:26'!
prender

self color: Color red! !


!UnaSeñalDeDetencion class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 15:42:23'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #UnaSeñalDePrecaucion category: #Semaforo!
DenotativeObjectMorph subclass: #UnaSeñalDePrecaucion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UnaSeñalDePrecaucion class' category: #Semaforo!
UnaSeñalDePrecaucion class
	instanceVariableNames: ''!

!UnaSeñalDePrecaucion class methodsFor: 'morph' stamp: 'J.S 3/31/2019 14:16:48'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!UnaSeñalDePrecaucion class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 14:39:10'!
apagar

self color: Color black.! !

!UnaSeñalDePrecaucion class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 14:40:36'!
prender

self color: Color yellow.! !


!UnaSeñalDePrecaucion class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 15:42:23'!
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
	OrquestadorDeSeñalesDeTransito apagarSeñales.
	OrquestadorDeSeñalesDeTransito titilarSeñalDePrevencion: 5.
	! !

!SemaforoDeCanningYCorrientes class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 15:32:26'!
prender
	self avisarPrecaucionPorEncendido.
	
	
	! !

OrquestadorDeSeñalesDeTransito initializeAfterFileIn!
UnaSeñalDeAvance initializeAfterFileIn!
UnaSeñalDeDetencion initializeAfterFileIn!
UnaSeñalDePrecaucion initializeAfterFileIn!