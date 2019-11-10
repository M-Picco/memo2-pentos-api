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

    Escenario: CP1 - Consulta de pedido
      Dado que el cliente pidio un "menu_individual"
      Cuando consulta el estado
      Entonces el estado es "recibido"
    

    Escenario: CP2 - Consulta de pedido inexistente
      Dado que el cliente no hizo pedidos
      Cuando consulta el estado de un pedido
      Entonces obtiene un mensaje indicando que no realizo pedidos

    @wip
    Escenario: CP3 - Consulta de pedido de otro cliente
      Dado que el cliente pidio un "menu_individual"
      Cuando consulta el estado de un pedido que no hizo el
      Entonces obtiene un mensaje de error indicando que la orden no existe
