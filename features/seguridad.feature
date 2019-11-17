# language: es

Característica: Seguridad

    """
    Esta feature es un requerimiento no funcional, por eso el gherking habla de cuestiones de técnicas de implementacion
    """

    @wip
    Escenario: ERR1 - Los requests sin api-key deben ser rechazados
        Dado el repartidor "pepeinseguro"
        Cuando se registra pero no envia api-ley
        Entonces obtiene error 403