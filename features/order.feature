# language: es

Característica: Realizar un pedido

    Antecedentes:
        Dado el cliente "jperez"
        Y se registra con domicilio "Cucha Cucha 1234 1 Piso B" y telefono "4123-4123"
        Y el repartidor "juanmotoneta"

    Escenario: P1 - Hace pedido exitoso
        Cuando el cliente pide un "menu_individual"
        Entonces obtiene numero de pedido único
