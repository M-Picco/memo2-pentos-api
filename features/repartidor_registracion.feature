# language: es

Característica: Registracion de repartidor

    """
    El nombre del repartidor debe ser una cadena de caracteres alfanumericos de entre 8 y 14 caracteres.
    """
    Escenario: RP1 - Registracion exitosa
        Dado el repartidor "juanmotoneta"
        Cuando se registra
        Entonces obtiene un numero unico de repartidor

    Escenario: RP2 - Registracion con nombre muy corto
        Dado el repartidor "pepe"
        Cuando se registra
        Entonces obtiene un error por nombre de usuario invalido

    Escenario: RP3 - Registracion con nombre muy largo
        Dado el repartidor "elseniordelosanillos"
        Cuando se registra
        Entonces obtiene un error por nombre de usuario invalido

    Escenario: RP4 - Registración Repetida
        Dado que el repartidor "juanmotoneta" esta registrado
        Cuando se registra
        Entonces obtiene un mensaje de error por ya estar registrado
