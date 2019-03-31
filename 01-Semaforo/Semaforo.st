!classDefinition: #OrquestadorDeSeñalesDeTransitoDeCanning category: #Semaforo!
DenotativeObjectMorph subclass: #OrquestadorDeSeñalesDeTransitoDeCanning
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OrquestadorDeSeñalesDeTransitoDeCanning class' category: #Semaforo!
OrquestadorDeSeñalesDeTransitoDeCanning class
	instanceVariableNames: ''!

!OrquestadorDeSeñalesDeTransitoDeCanning class methodsFor: 'morph' stamp: 'J.S 3/31/2019 14:17:56'!
createMorph

	^LayoutMorph newColumn
		morphExtent: 60 @ 130;
		yourself
! !


!OrquestadorDeSeñalesDeTransitoDeCanning class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 17:05:41'!
activarFlujoDeAvance
	SeñalDePrecaucionDeCanning prender.
	(Delay forSeconds: 1) wait.
	SeñalDeDetencionDeCanning apagar.
	SeñalDePrecaucionDeCanning apagar.
	SeñalDeAvanceDeCanning prender.! !

!OrquestadorDeSeñalesDeTransitoDeCanning class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 17:05:36'!
activarFlujoDeDetencion
	SeñalDePrecaucionDeCanning prender.
	(Delay forSeconds: 1) wait.
	SeñalDeDetencionDeCanning prender.
	SeñalDePrecaucionDeCanning apagar.
	SeñalDeAvanceDeCanning apagar.! !

!OrquestadorDeSeñalesDeTransitoDeCanning class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 15:54:19'!
apagarSeñales
	SeñalDeDetencionDeCanning apagar.
	SeñalDePrecaucionDeCanning apagar.
	SeñalDeAvanceDeCanning apagar.! !

!OrquestadorDeSeñalesDeTransitoDeCanning class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 17:19:16'!
titilarSeñalDePrecaucion

	SeñalDePrecaucionDeCanning prender.
	(Delay forSeconds: 1) wait.
	SeñalDePrecaucionDeCanning apagar.
	(Delay forSeconds: 1) wait.! !


!OrquestadorDeSeñalesDeTransitoDeCanning class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 17:25:13'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #OrquestadorDeSeñalesDeTransitoDeCorrientes category: #Semaforo!
DenotativeObjectMorph subclass: #OrquestadorDeSeñalesDeTransitoDeCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OrquestadorDeSeñalesDeTransitoDeCorrientes class' category: #Semaforo!
OrquestadorDeSeñalesDeTransitoDeCorrientes class
	instanceVariableNames: ''!

!OrquestadorDeSeñalesDeTransitoDeCorrientes class methodsFor: 'morph' stamp: 'J.S 3/31/2019 15:51:49'!
createMorph

	^LayoutMorph newColumn
		morphExtent: 60 @ 130;
		yourself
! !


!OrquestadorDeSeñalesDeTransitoDeCorrientes class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 17:06:05'!
activarFlujoDeAvance
	SeñalDePrecaucionDeCorrientes prender.
	(Delay forSeconds: 1) wait.
	SeñalDeDetencionDeCorrientes apagar.
	SeñalDePrecaucionDeCorrientes apagar.
	SeñalDeAvanceDeCorrientes prender.! !

!OrquestadorDeSeñalesDeTransitoDeCorrientes class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 17:10:49'!
activarFlujoDeDetencion
	SeñalDePrecaucionDeCorrientes prender.
	SeñalDeAvanceDeCorrientes apagar.
	(Delay forSeconds: 1) wait.
	SeñalDeDetencionDeCorrientes prender.
	SeñalDePrecaucionDeCorrientes apagar.! !

!OrquestadorDeSeñalesDeTransitoDeCorrientes class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 16:00:46'!
apagarSeñales
	SeñalDeDetencionDeCorrientes apagar.
	SeñalDePrecaucionDeCorrientes apagar.
	SeñalDeAvanceDeCorrientes apagar.! !

!OrquestadorDeSeñalesDeTransitoDeCorrientes class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 17:19:05'!
titilarSeñalDePrecaucion

	SeñalDePrecaucionDeCorrientes prender.
	(Delay forSeconds: 1) wait.
	SeñalDePrecaucionDeCorrientes apagar.
	(Delay forSeconds: 1) wait.! !


!OrquestadorDeSeñalesDeTransitoDeCorrientes class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 17:25:13'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDeAvanceDeCanning category: #Semaforo!
DenotativeObjectMorph subclass: #SeñalDeAvanceDeCanning
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeAvanceDeCanning class' category: #Semaforo!
SeñalDeAvanceDeCanning class
	instanceVariableNames: ''!

!SeñalDeAvanceDeCanning class methodsFor: 'morph' stamp: 'J.S 3/31/2019 13:21:43'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!SeñalDeAvanceDeCanning class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 14:37:15'!
apagar

self color: Color black.! !

!SeñalDeAvanceDeCanning class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 14:35:35'!
prender

self color: Color green! !


!SeñalDeAvanceDeCanning class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 17:25:13'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDeAvanceDeCorrientes category: #Semaforo!
DenotativeObjectMorph subclass: #SeñalDeAvanceDeCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeAvanceDeCorrientes class' category: #Semaforo!
SeñalDeAvanceDeCorrientes class
	instanceVariableNames: ''!

!SeñalDeAvanceDeCorrientes class methodsFor: 'morph' stamp: 'J.S 3/31/2019 15:57:25'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!SeñalDeAvanceDeCorrientes class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 15:57:25'!
apagar

self color: Color black.! !

!SeñalDeAvanceDeCorrientes class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 15:57:25'!
prender

self color: Color green! !


!SeñalDeAvanceDeCorrientes class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 17:25:13'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDeDetencionDeCanning category: #Semaforo!
DenotativeObjectMorph subclass: #SeñalDeDetencionDeCanning
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeDetencionDeCanning class' category: #Semaforo!
SeñalDeDetencionDeCanning class
	instanceVariableNames: ''!

!SeñalDeDetencionDeCanning class methodsFor: 'morph' stamp: 'J.S 3/31/2019 14:16:39'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!SeñalDeDetencionDeCanning class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 14:39:00'!
apagar

self color: Color black.! !

!SeñalDeDetencionDeCanning class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 14:40:26'!
prender

self color: Color red! !


!SeñalDeDetencionDeCanning class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 17:25:13'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDeDetencionDeCorrientes category: #Semaforo!
DenotativeObjectMorph subclass: #SeñalDeDetencionDeCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeDetencionDeCorrientes class' category: #Semaforo!
SeñalDeDetencionDeCorrientes class
	instanceVariableNames: ''!

!SeñalDeDetencionDeCorrientes class methodsFor: 'morph' stamp: 'J.S 3/31/2019 15:57:32'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!SeñalDeDetencionDeCorrientes class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 15:57:32'!
apagar

self color: Color black.! !

!SeñalDeDetencionDeCorrientes class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 15:57:32'!
prender

self color: Color red! !


!SeñalDeDetencionDeCorrientes class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 17:25:13'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDePrecaucionDeCanning category: #Semaforo!
DenotativeObjectMorph subclass: #SeñalDePrecaucionDeCanning
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDePrecaucionDeCanning class' category: #Semaforo!
SeñalDePrecaucionDeCanning class
	instanceVariableNames: ''!

!SeñalDePrecaucionDeCanning class methodsFor: 'morph' stamp: 'J.S 3/31/2019 14:16:48'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!SeñalDePrecaucionDeCanning class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 14:39:10'!
apagar

self color: Color black.! !

!SeñalDePrecaucionDeCanning class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 14:40:36'!
prender

self color: Color yellow.! !


!SeñalDePrecaucionDeCanning class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 17:25:13'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDePrecaucionDeCorrientes category: #Semaforo!
DenotativeObjectMorph subclass: #SeñalDePrecaucionDeCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDePrecaucionDeCorrientes class' category: #Semaforo!
SeñalDePrecaucionDeCorrientes class
	instanceVariableNames: ''!

!SeñalDePrecaucionDeCorrientes class methodsFor: 'morph' stamp: 'J.S 3/31/2019 15:57:43'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!SeñalDePrecaucionDeCorrientes class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 15:57:43'!
apagar

self color: Color black.! !

!SeñalDePrecaucionDeCorrientes class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 15:57:43'!
prender

self color: Color yellow.! !


!SeñalDePrecaucionDeCorrientes class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 17:25:13'!
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

!SemaforoDeCanningYCorrientes class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 17:23:51'!
avisarPrecaucionPorEncendido
	self titilarSeñalDePrecaucion: 5.! !

!SemaforoDeCanningYCorrientes class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 17:06:48'!
bloquearPaso: unOrquestadorDeSeñalesDeTransito
	
	unOrquestadorDeSeñalesDeTransito activarFlujoDeDetencion.! !

!SemaforoDeCanningYCorrientes class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 17:06:31'!
habilitarPaso: unOrquestadorDeSeñalesDeTransito
	
	unOrquestadorDeSeñalesDeTransito activarFlujoDeAvance! !

!SemaforoDeCanningYCorrientes class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 17:23:58'!
prender
	OrquestadorDeSeñalesDeTransitoDeCanning apagarSeñales.
	OrquestadorDeSeñalesDeTransitoDeCorrientes apagarSeñales.

	self avisarPrecaucionPorEncendido.
	self señalizarCirculacion.
	! !

!SemaforoDeCanningYCorrientes class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 16:30:49'!
señalizarCirculacion
	
	| intervaloCambioDePaso |
	
	intervaloCambioDePaso := 3.
	
	5 timesRepeat: [
		self bloquearPaso: OrquestadorDeSeñalesDeTransitoDeCorrientes.
		self habilitarPaso: OrquestadorDeSeñalesDeTransitoDeCanning.
		
		(Delay forSeconds: intervaloCambioDePaso) wait.
		
		self bloquearPaso: OrquestadorDeSeñalesDeTransitoDeCanning.
		self habilitarPaso: OrquestadorDeSeñalesDeTransitoDeCorrientes.
		
		(Delay forSeconds: intervaloCambioDePaso) wait.
	]! !

!SemaforoDeCanningYCorrientes class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 17:19:40'!
titilarSeñalDePrecaucion: unaCantidadDeVeces

	unaCantidadDeVeces timesRepeat: [
		OrquestadorDeSeñalesDeTransitoDeCanning titilarSeñalDePrecaucion.
		OrquestadorDeSeñalesDeTransitoDeCorrientes titilarSeñalDePrecaucion.
	]! !

OrquestadorDeSeñalesDeTransitoDeCanning initializeAfterFileIn!
OrquestadorDeSeñalesDeTransitoDeCorrientes initializeAfterFileIn!
SeñalDeAvanceDeCanning initializeAfterFileIn!
SeñalDeAvanceDeCorrientes initializeAfterFileIn!
SeñalDeDetencionDeCanning initializeAfterFileIn!
SeñalDeDetencionDeCorrientes initializeAfterFileIn!
SeñalDePrecaucionDeCanning initializeAfterFileIn!
SeñalDePrecaucionDeCorrientes initializeAfterFileIn!