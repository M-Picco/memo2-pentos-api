# language: es

@wip
Característica: Registracion de repartidor

    """
    El nombre del repartidor debe ser una cadena de caracteres alfanumericos de entre 8 y 14 caracteres.
    """
    Escenario: RP1 - Registracion exitosa
        Dado el repartidor "juanmotoneta"
        Cuando se registra
        Entonces obtiene un numero unico de repartidor