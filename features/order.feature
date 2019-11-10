# language: es

Característica: Realizar un pedido

    Antecedentes:
        Dado el cliente "jperez"
        Y se registra con domicilio "Cucha Cucha 1234 1 Piso B" y telefono "4123-4123"
        Y el repartidor "juanmotoneta"

    Escenario: P1 - Hace pedido exitoso
        Cuando el cliente pide un "menu_individual"
        Entonces obtiene numero de pedido único

    Escenario: CEP1 - cambio de estado de recibida a en_preparacion
      Dado que el cliente pidio un "menu_pareja"
      Cuando el estado cambia a "en_preparacion"
      Y consulta el estado
      Entonces el estado es "en_preparacion"

    Escenario: CEP2 - cambio de estado de en_preparacion a en_entrega
        Dado que el cliente pidio un "menu_familiar"
        Cuando el estado cambia a "en_entrega"
        Y consulta el estado
        Entonces el estado es "en_entrega"