!classDefinition: #OrquestadorDeSeñalesDeTransito category: #Semaforo!
DenotativeObjectMorph subclass: #OrquestadorDeSeñalesDeTransito
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OrquestadorDeSeñalesDeTransito class' category: #Semaforo!
OrquestadorDeSeñalesDeTransito class
	instanceVariableNames: 'señalDeDetencion señalDePrecaucion señalDeAvance'!

!OrquestadorDeSeñalesDeTransito class methodsFor: 'setters' stamp: 'J.S 3/31/2019 18:02:44'!
señalDeAvance: unaSeñalDeAvance
	
	señalDeAvance := unaSeñalDeAvance.! !

!OrquestadorDeSeñalesDeTransito class methodsFor: 'setters' stamp: 'J.S 3/31/2019 18:02:01'!
señalDeDetencion: unaSeñalDeDetencion
	
	señalDeDetencion := unaSeñalDeDetencion.! !

!OrquestadorDeSeñalesDeTransito class methodsFor: 'setters' stamp: 'J.S 3/31/2019 18:02:29'!
señalDePrecaucion: unaSeñalDePrecaucion
	
	señalDePrecaucion := unaSeñalDePrecaucion.! !


!OrquestadorDeSeñalesDeTransito class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 18:05:28'!
activarFlujoDeAvance
	señalDePrecaucion prender.
	(Delay forSeconds: 1) wait.
	señalDeDetencion apagar.
	señalDePrecaucion apagar.
	señalDeAvance prender.! !

!OrquestadorDeSeñalesDeTransito class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 19:04:07'!
activarFlujoDeDetencion
	señalDePrecaucion prender.
	señalDeAvance apagar.
	(Delay forSeconds: 1) wait.
	señalDeDetencion prender.
	señalDePrecaucion apagar.! !

!OrquestadorDeSeñalesDeTransito class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 18:06:30'!
apagarSeñales
	señalDeDetencion apagar.
	señalDePrecaucion apagar.
	señalDeAvance apagar.! !

!OrquestadorDeSeñalesDeTransito class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 18:07:49'!
titilarSeñalDePrecaucion

	señalDePrecaucion prender.
	(Delay forSeconds: 1) wait.
	señalDePrecaucion apagar.
	(Delay forSeconds: 1) wait.! !


!OrquestadorDeSeñalesDeTransito class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 19:11:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.
	señalDeDetencion := nil.
	señalDePrecaucion := nil.
	señalDeAvance := nil.! !


!classDefinition: #OrquestadorDeSeñalesDeTransitoDeCanning category: #Semaforo!
OrquestadorDeSeñalesDeTransito subclass: #OrquestadorDeSeñalesDeTransitoDeCanning
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OrquestadorDeSeñalesDeTransitoDeCanning class' category: #Semaforo!
OrquestadorDeSeñalesDeTransitoDeCanning class
	instanceVariableNames: ''!

!OrquestadorDeSeñalesDeTransitoDeCanning class methodsFor: 'constructor' stamp: 'J.S 3/31/2019 18:03:51'!
inicializar
 
	self señalDeDetencion: SeñalDeDetencionDeCanning.
	self señalDePrecaucion: SeñalDePrecaucionDeCanning.
	self señalDeAvance: SeñalDeAvanceDeCanning.! !


!OrquestadorDeSeñalesDeTransitoDeCanning class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 19:11:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.
	señalDeDetencion := SeñalDeDetencionDeCanning.
	señalDePrecaucion := SeñalDePrecaucionDeCanning.
	señalDeAvance := SeñalDeAvanceDeCanning.! !


!classDefinition: #OrquestadorDeSeñalesDeTransitoDeCorrientes category: #Semaforo!
OrquestadorDeSeñalesDeTransito subclass: #OrquestadorDeSeñalesDeTransitoDeCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OrquestadorDeSeñalesDeTransitoDeCorrientes class' category: #Semaforo!
OrquestadorDeSeñalesDeTransitoDeCorrientes class
	instanceVariableNames: ''!

!OrquestadorDeSeñalesDeTransitoDeCorrientes class methodsFor: 'constructor' stamp: 'J.S 3/31/2019 18:04:41'!
inicializar
 
	self señalDeDetencion: SeñalDeDetencionDeCorrientes.
	self señalDePrecaucion: SeñalDePrecaucionDeCorrientes.
	self señalDeAvance: SeñalDeAvanceDeCorrientes.! !


!OrquestadorDeSeñalesDeTransitoDeCorrientes class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 19:11:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.
	señalDeDetencion := SeñalDeDetencionDeCorrientes.
	señalDePrecaucion := SeñalDePrecaucionDeCorrientes.
	señalDeAvance := SeñalDeAvanceDeCorrientes.! !


!classDefinition: #Señal category: #Semaforo!
DenotativeObjectMorph subclass: #Señal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Señal class' category: #Semaforo!
Señal class
	instanceVariableNames: ''!

!Señal class methodsFor: 'morph' stamp: 'J.S 3/31/2019 17:46:31'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!Señal class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 17:46:55'!
apagar

self color: Color black.! !


!Señal class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 19:11:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDeAvance category: #Semaforo!
Señal subclass: #SeñalDeAvance
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeAvance class' category: #Semaforo!
SeñalDeAvance class
	instanceVariableNames: ''!

!SeñalDeAvance class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 17:48:42'!
prender

self color: Color green! !


!SeñalDeAvance class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 19:11:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDeAvanceDeCanning category: #Semaforo!
SeñalDeAvance subclass: #SeñalDeAvanceDeCanning
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeAvanceDeCanning class' category: #Semaforo!
SeñalDeAvanceDeCanning class
	instanceVariableNames: ''!

!SeñalDeAvanceDeCanning class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 19:11:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDeAvanceDeCorrientes category: #Semaforo!
SeñalDeAvance subclass: #SeñalDeAvanceDeCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeAvanceDeCorrientes class' category: #Semaforo!
SeñalDeAvanceDeCorrientes class
	instanceVariableNames: ''!

!SeñalDeAvanceDeCorrientes class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 19:11:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDeDetencion category: #Semaforo!
Señal subclass: #SeñalDeDetencion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeDetencion class' category: #Semaforo!
SeñalDeDetencion class
	instanceVariableNames: ''!

!SeñalDeDetencion class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 17:41:11'!
prender

self color: Color red! !


!SeñalDeDetencion class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 19:11:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDeDetencionDeCanning category: #Semaforo!
SeñalDeDetencion subclass: #SeñalDeDetencionDeCanning
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeDetencionDeCanning class' category: #Semaforo!
SeñalDeDetencionDeCanning class
	instanceVariableNames: ''!

!SeñalDeDetencionDeCanning class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 19:11:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDeDetencionDeCorrientes category: #Semaforo!
SeñalDeDetencion subclass: #SeñalDeDetencionDeCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeDetencionDeCorrientes class' category: #Semaforo!
SeñalDeDetencionDeCorrientes class
	instanceVariableNames: ''!

!SeñalDeDetencionDeCorrientes class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 19:11:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDePrecaucion category: #Semaforo!
Señal subclass: #SeñalDePrecaucion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDePrecaucion class' category: #Semaforo!
SeñalDePrecaucion class
	instanceVariableNames: ''!

!SeñalDePrecaucion class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 17:50:16'!
prender

self color: Color yellow.! !


!SeñalDePrecaucion class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 19:11:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDePrecaucionDeCanning category: #Semaforo!
SeñalDePrecaucion subclass: #SeñalDePrecaucionDeCanning
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDePrecaucionDeCanning class' category: #Semaforo!
SeñalDePrecaucionDeCanning class
	instanceVariableNames: ''!

!SeñalDePrecaucionDeCanning class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 19:11:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDePrecaucionDeCorrientes category: #Semaforo!
SeñalDePrecaucion subclass: #SeñalDePrecaucionDeCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDePrecaucionDeCorrientes class' category: #Semaforo!
SeñalDePrecaucionDeCorrientes class
	instanceVariableNames: ''!

!SeñalDePrecaucionDeCorrientes class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 19:11:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #Semaforo category: #Semaforo!
DenotativeObject subclass: #Semaforo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Semaforo class' category: #Semaforo!
Semaforo class
	instanceVariableNames: 'orquestadorDeSeñalesDeTransitoA orquestadorDeSeñalesDeTransitoB'!

!Semaforo class methodsFor: 'setters' stamp: 'J.S 3/31/2019 18:13:51'!
orquestadorDeSeñalesDeTransitoA: unOrquestadorDeSeñalesDeTransito
	
	orquestadorDeSeñalesDeTransitoA := unOrquestadorDeSeñalesDeTransito.! !

!Semaforo class methodsFor: 'setters' stamp: 'J.S 3/31/2019 18:14:00'!
orquestadorDeSeñalesDeTransitoB: unOrquestadorDeSeñalesDeTransito
	
	orquestadorDeSeñalesDeTransitoB := unOrquestadorDeSeñalesDeTransito.! !


!Semaforo class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 18:15:56'!
avisarPrecaucionPorEncendido
	self titilarSeñalDePrecaucion: 5.! !

!Semaforo class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 18:16:28'!
bloquearPaso: unOrquestadorDeSeñalesDeTransito
	
	unOrquestadorDeSeñalesDeTransito activarFlujoDeDetencion.! !

!Semaforo class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 18:16:38'!
habilitarPaso: unOrquestadorDeSeñalesDeTransito
	
	unOrquestadorDeSeñalesDeTransito activarFlujoDeAvance! !

!Semaforo class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 19:03:15'!
prender
	orquestadorDeSeñalesDeTransitoA apagarSeñales.
	orquestadorDeSeñalesDeTransitoB apagarSeñales.

	self avisarPrecaucionPorEncendido.
	self señalizarCirculacion.
	! !

!Semaforo class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 19:04:32'!
señalizarCirculacion
	
	| intervaloCambioDePaso |
	
	intervaloCambioDePaso := 3.
	
	500 timesRepeat: [
		self bloquearPaso: orquestadorDeSeñalesDeTransitoA.
		self habilitarPaso: orquestadorDeSeñalesDeTransitoB.
		
		(Delay forSeconds: intervaloCambioDePaso) wait.
		
		self bloquearPaso: orquestadorDeSeñalesDeTransitoB.
		self habilitarPaso: orquestadorDeSeñalesDeTransitoA.
		
		(Delay forSeconds: intervaloCambioDePaso) wait.
	]! !

!Semaforo class methodsFor: 'funcionamiento' stamp: 'J.S 3/31/2019 18:18:20'!
titilarSeñalDePrecaucion: unaCantidadDeVeces

	unaCantidadDeVeces timesRepeat: [
		orquestadorDeSeñalesDeTransitoA titilarSeñalDePrecaucion.
		orquestadorDeSeñalesDeTransitoB titilarSeñalDePrecaucion.
	]! !


!Semaforo class methodsFor: 'getters' stamp: 'J.S 3/31/2019 19:10:01'!
orquestadorDeSeñalesDeTransitoA

	^ orquestadorDeSeñalesDeTransitoA! !

!Semaforo class methodsFor: 'getters' stamp: 'J.S 3/31/2019 19:10:11'!
orquestadorDeSeñalesDeTransitoB

	^ orquestadorDeSeñalesDeTransitoB! !


!Semaforo class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 19:11:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	orquestadorDeSeñalesDeTransitoA := nil.
	orquestadorDeSeñalesDeTransitoB := nil.! !


!classDefinition: #SemaforoDeCanningYCorrientes category: #Semaforo!
Semaforo subclass: #SemaforoDeCanningYCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SemaforoDeCanningYCorrientes class' category: #Semaforo!
SemaforoDeCanningYCorrientes class
	instanceVariableNames: ''!

!SemaforoDeCanningYCorrientes class methodsFor: 'constructor' stamp: 'J.S 3/31/2019 19:09:37'!
inicializar
	
	self orquestadorDeSeñalesDeTransitoA: OrquestadorDeSeñalesDeTransitoDeCanning.
	self orquestadorDeSeñalesDeTransitoB: OrquestadorDeSeñalesDeTransitoDeCorrientes.
	
	self orquestadorDeSeñalesDeTransitoA inicializar.
	self orquestadorDeSeñalesDeTransitoB inicializar.
	
	self prender.! !


!SemaforoDeCanningYCorrientes class methodsFor: 'as yet unclassified' stamp: 'J.S 3/31/2019 19:11:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	orquestadorDeSeñalesDeTransitoA := OrquestadorDeSeñalesDeTransitoDeCanning.
	orquestadorDeSeñalesDeTransitoB := OrquestadorDeSeñalesDeTransitoDeCorrientes.! !

OrquestadorDeSeñalesDeTransito initializeAfterFileIn!
OrquestadorDeSeñalesDeTransitoDeCanning initializeAfterFileIn!
OrquestadorDeSeñalesDeTransitoDeCorrientes initializeAfterFileIn!
Señal initializeAfterFileIn!
SeñalDeAvance initializeAfterFileIn!
SeñalDeAvanceDeCanning initializeAfterFileIn!
SeñalDeAvanceDeCorrientes initializeAfterFileIn!
SeñalDeDetencion initializeAfterFileIn!
SeñalDeDetencionDeCanning initializeAfterFileIn!
SeñalDeDetencionDeCorrientes initializeAfterFileIn!
SeñalDePrecaucion initializeAfterFileIn!
SeñalDePrecaucionDeCanning initializeAfterFileIn!
SeñalDePrecaucionDeCorrientes initializeAfterFileIn!
Semaforo initializeAfterFileIn!
SemaforoDeCanningYCorrientes initializeAfterFileIn!