# language: es

Característica: Registracion de repartidor

    """
    El nombre del repartidor debe ser una cadena de caracteres alfanumericos de entre 8 y 14 caracteres.
    """
    Escenario: RP1 - Registracion exitosa
        Dado el nombre del repartidor "juanmotoneta"
        Cuando se registra
        Entonces obtiene un numero unico de repartidor

    @wip
    Escenario: RP2 - Registracion con nombre muy corto
        Dado el repartidor "pepe"
        Cuando se registra
        Entonces obtiene un error por nombre de usuario invalido
