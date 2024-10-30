Algoritmo gatitoestamalo
	// Juego del Gato en PSeInt con un jugador contra la computadora
	
	// Definición de variables
	Dimension tablero[3,3]
	jugadorActual <- "X"
	ganador <- ""
	empate <- FALSO
	fila <- 0
	columna <- 0
	
	// Inicializar tablero
	SubProceso InicializarTablero
		Para i <- 1 Hasta 3 Con Paso 1 Hacer
			Para j <- 1 Hasta 3 Con Paso 1 Hacer
				tablero[i,j] <- "-"
			FinPara
		FinPara
FinSubProceso

// Mostrar tablero
SubProceso MostrarTablero
    Para i <- 1 Hasta 3 Con Paso 1 Hacer
        Escribir Sin Saltar tablero[i,1], " | ", tablero[i,2], " | ", tablero[i,3]
        Escribir ""
    FinPara
FinSubProceso

// Cambiar turno
SubProceso CambiarTurno
    Si jugadorActual = "X" Entonces
        jugadorActual <- "O"  // Turno de la computadora
    SiNo
        jugadorActual <- "X"  // Turno del jugador
    FinSi
FinSubProceso

// Verificar ganador
SubProceso VerificarGanador
    Para i <- 1 Hasta 3 Con Paso 1 Hacer
        // Verificar filas
        Si tablero[i,1] = tablero[i,2] Y tablero[i,2] = tablero[i,3] Y tablero[i,1] <> "-" Entonces
            ganador <- tablero[i,1]
        FinSi
        // Verificar columnas
        Si tablero[1,i] = tablero[2,i] Y tablero[2,i] = tablero[3,i] Y tablero[1,i] <> "-" Entonces
            ganador <- tablero[1,i]
        FinSi
    FinPara
    // Verificar diagonales
    Si tablero[1,1] = tablero[2,2] Y tablero[2,2] = tablero[3,3] Y tablero[1,1] <> "-" Entonces
        ganador <- tablero[1,1]
    FinSi
    Si tablero[1,3] = tablero[2,2] Y tablero[2,2] = tablero[3,1] Y tablero[1,3] <> "-" Entonces
        ganador <- tablero[1,3]
    FinSi
FinSubProceso

// Verificar empate
SubProceso VerificarEmpate
    empate <- VERDADERO
    Para i <- 1 Hasta 3 Con Paso 1 Hacer
        Para j <- 1 Hasta 3 Con Paso 1 Hacer
            Si tablero[i,j] = "-" Entonces
                empate <- FALSO
            FinSi
        FinPara
    FinPara
FinSubProceso

// Movimiento de la computadora (jugador "O")
SubProceso MovimientoComputadora
    Repetir
        fila <- Aleatorio(1, 3)
        columna <- Aleatorio(1, 3)
    Hasta Que tablero[fila, columna] = "-"
    tablero[fila, columna] <- "O"
FinSubProceso

// Juego principal
Proceso JuegoGato
    InicializarTablero()
    Mientras ganador = "" Y NO empate Hacer
        MostrarTablero()
        Si jugadorActual = "X" Entonces
            // Turno del jugador humano
            Escribir "Jugador ", jugadorActual, ", es tu turno."
            Escribir "Ingresa la fila (1-3): "
            Leer fila
            Escribir "Ingresa la columna (1-3): "
            Leer columna
            // Validar movimiento
            Si tablero[fila, columna] = "-" Entonces
                tablero[fila, columna] <- jugadorActual
                VerificarGanador()
                Si ganador = "" Entonces
                    VerificarEmpate()
                    Si NO empate Entonces
                        CambiarTurno()
                    FinSi
                FinSi
            SiNo
                Escribir "Movimiento inválido. Intenta de nuevo."
            FinSi
        SiNo
            // Turno de la computadora
            Escribir "Turno de la computadora..."
            MovimientoComputadora()
            VerificarGanador()
            Si ganador = "" Entonces
                VerificarEmpate()
                Si NO empate Entonces
                    CambiarTurno()
                FinSi
            FinSi
        FinSi
    FinMientras
    MostrarTablero()
    Si ganador <> "" Entonces
        Escribir "¡El jugador ", ganador, " ha ganado!"
    SiNo
        Escribir "¡Es un empate!"
    FinSi
FinProceso