!classDefinition: #Caja category: 'FactorioParte2'!
DenotativeObject subclass: #Caja
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FactorioParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Caja class' category: 'FactorioParte2'!
Caja class
	instanceVariableNames: 'contenido'!

!Caja class methodsFor: 'as yet unclassified' stamp: 'jb 5/3/2021 21:30:46'!
agregarMenas: unConjuntoDeMenas
	^contenido addAll: unConjuntoDeMenas.! !

!Caja class methodsFor: 'as yet unclassified' stamp: 'jb 5/3/2021 21:32:39'!
agregarUnaMena: unaMena
	^contenido add: unaMena.! !

!Caja class methodsFor: 'as yet unclassified' stamp: 'FV 5/6/2021 11:52:13'!
cantidadDeMenasDe: tipoDeMena

	^contenido count: [ :cadaElemento | cadaElemento = tipoDeMena ].! !

!Caja class methodsFor: 'as yet unclassified' stamp: 'FV 5/6/2021 12:13:16'!
cantidadDeMenasTotal
	^contenido size.! !

!Caja class methodsFor: 'as yet unclassified' stamp: 'FV 5/10/2021 17:17:19'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	contenido := ((OrderedCollection new) add: 'una mena de carbon'; add: 'una mena de hierro'; add: 'una mena de hierro'; yourself).! !

!Caja class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:09:06'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #CintaA category: 'FactorioParte2'!
DenotativeObject subclass: #CintaA
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FactorioParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CintaA class' category: 'FactorioParte2'!
CintaA class
	instanceVariableNames: 'contenido destino'!

!CintaA class methodsFor: 'as yet unclassified' stamp: 'jb 5/3/2021 21:33:05'!
agregarMenas: unConjuntoDeMenas
	^contenido addAll: unConjuntoDeMenas.! !

!CintaA class methodsFor: 'as yet unclassified' stamp: 'FV 5/6/2021 11:47:25'!
cantidadDeMenasDe: tipoDeMena

	^contenido count: [ :cadaElemento | cadaElemento = tipoDeMena ].! !

!CintaA class methodsFor: 'as yet unclassified' stamp: 'FV 5/6/2021 12:13:16'!
cantidadDeMenasTotal
	^contenido size.! !

!CintaA class methodsFor: 'as yet unclassified' stamp: 'jb 5/3/2021 21:21:36'!
destino: proximoDestino
	destino := proximoDestino.! !

!CintaA class methodsFor: 'as yet unclassified' stamp: 'FV 5/10/2021 17:17:20'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	contenido := ((OrderedCollection new)).
	destino := Caja.! !

!CintaA class methodsFor: 'as yet unclassified' stamp: 'jb 5/3/2021 21:36:16'!
transportar
	destino agregarMenas: contenido.
	self vaciar.! !

!CintaA class methodsFor: 'as yet unclassified' stamp: 'jb 5/3/2021 21:19:52'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #CintaB category: 'FactorioParte2'!
DenotativeObject subclass: #CintaB
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FactorioParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CintaB class' category: 'FactorioParte2'!
CintaB class
	instanceVariableNames: 'contenido destino'!

!CintaB class methodsFor: 'as yet unclassified' stamp: 'FV 5/6/2021 11:17:27'!
agregarMenas: unConjuntoDeMenas
	^contenido addAll: unConjuntoDeMenas.! !

!CintaB class methodsFor: 'as yet unclassified' stamp: 'FV 5/6/2021 11:51:27'!
cantidadDeMenasDe: tipoDeMena

	^contenido count: [ :cadaElemento | cadaElemento = tipoDeMena ].! !

!CintaB class methodsFor: 'as yet unclassified' stamp: 'FV 5/6/2021 12:13:16'!
cantidadDeMenasTotal
	^contenido size.! !

!CintaB class methodsFor: 'as yet unclassified' stamp: 'FV 5/6/2021 11:17:27'!
destino: proximoDestino
	destino := proximoDestino.! !

!CintaB class methodsFor: 'as yet unclassified' stamp: 'FV 5/10/2021 17:17:20'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	contenido := ((OrderedCollection new)).
	destino := CintaA.! !

!CintaB class methodsFor: 'as yet unclassified' stamp: 'FV 5/6/2021 11:17:27'!
transportar
	destino agregarMenas: contenido.
	self vaciar.! !

!CintaB class methodsFor: 'as yet unclassified' stamp: 'FV 5/6/2021 11:17:27'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #ExtractorDeCarbon category: 'FactorioParte2'!
DenotativeObject subclass: #ExtractorDeCarbon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FactorioParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtractorDeCarbon class' category: 'FactorioParte2'!
ExtractorDeCarbon class
	instanceVariableNames: 'energiaActual destino'!

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/15/2021 21:23:04'!
agregarEnergia: energiaExtra

	energiaActual := energiaActual +	energiaExtra.
	^energiaExtra.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'jb 5/10/2021 10:40:04'!
conjuntoDeMenasDeCarbonCantidad: cantidadDeMenas

	^ Array new: cantidadDeMenas withAll: 'una mena de carbon'! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:30:49'!
costoDeExtraccionPorMena
	^5 * joule.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:29:41'!
destino: aContenedor 
	destino := aContenedor.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/15/2021 21:21:02'!
energiaActual

	^energiaActual.
! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:31:29'!
energiaParaExtraerTodasLasMenasPosibles
	^self menasAExtraerSegunEnergiaActual * self costoDeExtraccionPorMena.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:34:57'!
extraer
	| cantidadDeMenas energiaConsumida |
	cantidadDeMenas := self menasAExtraerSegunEnergiaActual.
	energiaConsumida := self energiaParaExtraerTodasLasMenasPosibles.
	self sacarEnergia: energiaConsumida.
	^destino agregarMenas: (self conjuntoDeMenasDeCarbonCantidad: cantidadDeMenas).! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'FV 5/10/2021 17:17:20'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	energiaActual := (SimpleMeasure basicNew instVarAt: 1 put: 0; instVarAt: 2 put: (BaseUnit basicNew instVarAt: 1 put: 'joule'; instVarAt: 2 put: 'joules'; instVarAt: 3 put: 'j'; yourself); yourself).
	destino := CintaA.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:30:27'!
menasAExtraerSegunEnergiaActual
	^energiaActual // self costoDeExtraccionPorMena.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 5/2/2021 19:36:12'!
ponerEnCeroLaEnergia
	energiaActual := 0 * joule.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:31:57'!
sacarEnergia: energiaASacar
	energiaActual := energiaActual - energiaASacar! !


!classDefinition: #ExtractorDeHierro category: 'FactorioParte2'!
DenotativeObject subclass: #ExtractorDeHierro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FactorioParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtractorDeHierro class' category: 'FactorioParte2'!
ExtractorDeHierro class
	instanceVariableNames: 'energiaActual destino'!

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'FV 5/6/2021 11:14:25'!
agregarEnergia: energiaExtra

	energiaActual := energiaActual +	energiaExtra.
	^energiaExtra.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'jb 5/10/2021 10:39:51'!
conjuntoDeMenasDeHierroCantidad: cantidadDeMenas

	^ Array new: cantidadDeMenas withAll: 'una mena de hierro'! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'FV 5/6/2021 11:14:25'!
costoDeExtraccionPorMena
	^5 * joule.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'FV 5/6/2021 11:14:25'!
destino: aContenedor 
	destino := aContenedor.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'FV 5/6/2021 11:14:25'!
energiaActual

	^energiaActual.
! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'FV 5/6/2021 11:14:25'!
energiaParaExtraerTodasLasMenasPosibles
	^self menasAExtraerSegunEnergiaActual * self costoDeExtraccionPorMena.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'FV 5/6/2021 11:14:58'!
extraer
	| cantidadDeMenas energiaConsumida |
	cantidadDeMenas := self menasAExtraerSegunEnergiaActual.
	energiaConsumida := self energiaParaExtraerTodasLasMenasPosibles.
	self sacarEnergia: energiaConsumida.
	^destino agregarMenas: (self conjuntoDeMenasDeHierroCantidad: cantidadDeMenas).! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'FV 5/10/2021 17:17:20'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	energiaActual := (SimpleMeasure basicNew instVarAt: 1 put: 0; instVarAt: 2 put: (BaseUnit basicNew instVarAt: 1 put: 'joule'; instVarAt: 2 put: 'joules'; instVarAt: 3 put: 'j'; yourself); yourself).
	destino := CintaB.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'FV 5/6/2021 11:14:25'!
menasAExtraerSegunEnergiaActual
	^energiaActual // self costoDeExtraccionPorMena.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'FV 5/6/2021 11:14:25'!
ponerEnCeroLaEnergia
	energiaActual := 0 * joule.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'FV 5/6/2021 11:14:25'!
sacarEnergia: energiaASacar
	energiaActual := energiaActual - energiaASacar! !


!classDefinition: #PruebasDeCinta category: 'FactorioParte2'!
DenotativeObject subclass: #PruebasDeCinta
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FactorioParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PruebasDeCinta class' category: 'FactorioParte2'!
PruebasDeCinta class
	instanceVariableNames: ''!

!PruebasDeCinta class methodsFor: 'as yet unclassified' stamp: 'FV 5/10/2021 17:04:31'!
test01
	|menas|
	
	"Preparacion"
	menas:=#('una mena de carbon' 'una mena de carbon' 'una mena de hierro').
	CintaA vaciar.
	
	"Agrego las menas a la cinta"
	CintaA agregarMenas: menas.
	
	Assert that: CintaA cantidadDeMenasTotal isEqualTo: 3.
	Assert that: (CintaA cantidadDeMenasDe: 'una mena de carbon') isEqualTo: 2.
	Assert that: (CintaA cantidadDeMenasDe: 'una mena de hierro') isEqualTo: 1.
	
	! !


!classDefinition: #PruebasDeExtractorDeCarbon category: 'FactorioParte2'!
DenotativeObject subclass: #PruebasDeExtractorDeCarbon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FactorioParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PruebasDeExtractorDeCarbon class' category: 'FactorioParte2'!
PruebasDeExtractorDeCarbon class
	instanceVariableNames: ''!

!PruebasDeExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 5/2/2021 19:37:39'!
setUp
	ExtractorDeCarbon destino: Caja.
	Caja vaciar.! !

!PruebasDeExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:41:43'!
test01UnExtractorSinEnergiaNoExtraeMenas
	"Cuando no cargue energia en el extractor, no saco menas"
	ExtractorDeCarbon ponerEnCeroLaEnergia.
	Assert isTrue: ExtractorDeCarbon extraer isEmpty.
! !

!PruebasDeExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:46:54'!
test02UnExtractorConInsuficienteEnergiaNoExtraeMenas
	ExtractorDeCarbon ponerEnCeroLaEnergia.
	ExtractorDeCarbon agregarEnergia: 1 * joule.
	Assert isTrue: ExtractorDeCarbon extraer isEmpty.
! !

!PruebasDeExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:47:56'!
test03UnExtractorConSuficienteEnergiaExtrae1Mena
	ExtractorDeCarbon ponerEnCeroLaEnergia.
	ExtractorDeCarbon agregarEnergia: 5 * joule.
	Assert that: ExtractorDeCarbon extraer size isEqualTo: 1.
! !

!PruebasDeExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:49:57'!
test04UnExtractorConservaLaEnergiaNoUtilizada
	ExtractorDeCarbon ponerEnCeroLaEnergia.
	ExtractorDeCarbon agregarEnergia: 7 * joule.
	Assert that: ExtractorDeCarbon extraer size isEqualTo: 1.
	Assert that: ExtractorDeCarbon energiaActual isEqualTo: 2 * joule.
! !

!PruebasDeExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:50:53'!
test05UnExtractorPuedeExtraerMultiplesMenasConMuchaEnergia
	ExtractorDeCarbon ponerEnCeroLaEnergia.
	ExtractorDeCarbon agregarEnergia: 50 * joule.
	Assert that: ExtractorDeCarbon extraer size isEqualTo: 10.
	Assert that: ExtractorDeCarbon energiaActual isEqualTo: 0 * joule.
! !


!classDefinition: #PruebasDeFactorio category: 'FactorioParte2'!
DenotativeObject subclass: #PruebasDeFactorio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FactorioParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PruebasDeFactorio class' category: 'FactorioParte2'!
PruebasDeFactorio class
	instanceVariableNames: ''!

!PruebasDeFactorio class methodsFor: 'as yet unclassified' stamp: 'jb 5/10/2021 10:49:58'!
testEscenarioExtractorCaja
	ExtractorDeCarbon ponerEnCeroLaEnergia.
	ExtractorDeCarbon agregarEnergia: 5 * joule.
	ExtractorDeCarbon destino: Caja.
	Caja vaciar.
	
	ExtractorDeCarbon extraer.
	Assert that: Caja cantidadDeMenasTotal isEqualTo: 1.
	Assert that: (Caja cantidadDeMenasDe: 'una mena de carbon') isEqualTo: 1.! !

!PruebasDeFactorio class methodsFor: 'as yet unclassified' stamp: 'FV 5/10/2021 17:14:06'!
testEscenarioExtractorCintaCaja
	
	ExtractorDeCarbon ponerEnCeroLaEnergia.
	ExtractorDeCarbon agregarEnergia: 5 * joule.
	
	ExtractorDeCarbon destino: CintaA.
	CintaA vaciar.
	
	CintaA destino: Caja.
	Caja vaciar.
	
	"Se extrae la mena y se deposita en la cinta"
	ExtractorDeCarbon extraer.
	
	"Se transporta la mena de la cinta a la caja"
	CintaA transportar.
	Assert that: CintaA cantidadDeMenasTotal isEqualTo: 0.
	Assert that: Caja cantidadDeMenasTotal isEqualTo: 1.
	Assert that: (Caja cantidadDeMenasDe: 'una mena de carbon') isEqualTo: 1.! !

!PruebasDeFactorio class methodsFor: 'as yet unclassified' stamp: 'FV 5/10/2021 17:16:05'!
testEscenarioExtractorCintaCintaCaja
	"Preparacion"
	ExtractorDeCarbon ponerEnCeroLaEnergia.
	ExtractorDeCarbon agregarEnergia: 5 * joule.
	
	ExtractorDeHierro ponerEnCeroLaEnergia.
	ExtractorDeHierro agregarEnergia: 10 * joule.
	
	CintaA vaciar.
	CintaB vaciar.
	Caja vaciar.
	
	ExtractorDeCarbon destino: CintaA.
	ExtractorDeHierro destino: CintaB.
	CintaA destino: Caja.
	CintaB destino: CintaA.
	
	"Se extrae una mena de carbon y se deposita en la cintaA"
	ExtractorDeCarbon extraer.
	
	"Se extrae una mena de hierro y se deposita en la cintaB"
	ExtractorDeHierro extraer.
	
	"Se transporta el contenido de la cinta B a la cinta A"
	CintaB transportar.
	
	"Se transporta el contenido de la cintaA a la caja"
	CintaA transportar.
	
	
	Assert that: CintaA cantidadDeMenasTotal isEqualTo: 0.
	Assert that: CintaB cantidadDeMenasTotal isEqualTo: 0.
	
	Assert that: Caja cantidadDeMenasTotal isEqualTo: 3.
	Assert that: (Caja cantidadDeMenasDe: 'una mena de carbon')  isEqualTo: 1.
	Assert that: (Caja cantidadDeMenasDe: 'una mena de hierro')  isEqualTo: 2.
	! !

Caja initializeAfterFileIn!
CintaA initializeAfterFileIn!
CintaB initializeAfterFileIn!
ExtractorDeCarbon initializeAfterFileIn!
ExtractorDeHierro initializeAfterFileIn!