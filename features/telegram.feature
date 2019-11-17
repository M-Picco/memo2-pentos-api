# language: es

@wip
Característica: Flujo completo via telegram

    """
    Estos escenarios son para ejecucion manual de todo el flujo y por ello no son gherkin estricto

    """

    Escenario: TELE1 - Registracion exitosa
        Cuando envio "/registracion: Paseo Colon 850, 4576-4566"
        Entonces recibo "Registración exitosa"

    Escenario: TELE1.2 - Registracion fallida. Dirección inválida
        Cuando envio "/registracion av,4578-3214"
        Entonces recibo "Registración fallida,: Dirección inválida"

    Escenario: TELE1.3 - Registracion fallida. Teléfono inválido
        Cuando envio "/registracion paseo colon 850, 444ABC"
        Entonces recibo "Registración fallida: Teléfono inválido"

    Escenario: TELE1.4 - Registracion fallida, formato incorrecto (menos de 2 campos)
        Cuando envio "/registracion paseo colon 850 4578-3214"
        Entonces recibo "Registración fallida: Formato inválido (separar dirección y teléfono con ,)"

    Escenario: TELE2 - Hacer pedido
        Cuando ya complete la registracion
        Cuando envio "/pedido menu_invidivual"
        Entonces recibo "Su pedido ha sido recibido, su número es: N"

    Escenario: TELE3 - Consultar pedido que esta recibido
        Cuando ya hice un pedido y me dieron numero N
        Cuando envio "/estado N"
        Entonces recibo "Su pedido N ha sido RECIBIDO"

    Escenario: TELE4 - Consultar pedido que esta en preparacion
        Cuando ya hice un pedido y me dieron numero N
        Cuando envio "/estado N"
        Entonces recibo "Su pedido N esta EN PREPARACION"

    Escenario: TELE5 - Consultar pedido que esta en en_entrega
        Dado que ya hice un pedido y me dieron numero N
        Cuando envio "/estado N"
        Entonces recibo "Su pedido N esta EN ENTREGA"

    Escenario: TELE6 - Consultar pedido que esta en entregado
        Dado que ya hice un pedido y me dieron numero N
        Cuando envio "/estado N"
        Entonces recibo "Su pedido N esta ENTREGADO"

    Escenario: TELE7 - Calificar pedido exitosamente
        Dado que ya hice un pedido y me dieron numero N
        Cuando envío "/calificar N 3"
        Entonces recibo "Su pedido N ha sido calificado exitosamente"

    Escenario: TELE8 - Calificar pedido de forma fallida por calificación no válida, error
        Dado que ya hice un pedido y me dieron numero N
        Cuando envío "/calificar N -1"
        Entonces recibo "La calificación '-1' no es válida, ingresa un número entre 1 y 5"

    Escenario: TELE9 - Hacer pedido antes de registrarse, error
        Cuando envio "/pedido menu_invidivual"
        Entonces recibo "Error: primero debes registrarte"

    Escenario: TELE9.1 - Consultar pedido antes de registrarse, error
        Dado que no estoy registrado
        Cuando envio "/estado N"
        Entonces recibo "Error: primero debes registrarte"

    Escenario: TELE9.2 - Calificar pedido antes de registrarse, error
        Dado que no estoy registrado
        Cuando envio "/calificar N 3"
        Entonces recibo "Error: primero debes registrarte"

    Escenario: TELE10 - Calificar pedido antes de tiempo, error
        Dado que ya hice un pedido y me dieron numero N
        Y que el pedido todavía no fue entregado
        Cuando envío "/calificar N 5"
        Entonces recibo "El pedido solo puede calificarse una vez ENTREGADO"

    Escenario: TELE11 - Consultar pedido inexistente
        Dado que no hice ningún pedido
        Cuando envio "/estado N"
        Entonces recibo "Consulta fallida: El pedido indicado no existe"
