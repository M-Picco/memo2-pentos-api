# language: es

Característica: Creacion y Cambios de estado de Pedidos

  """
  Se ofrecen 3 menus:
    Menu individual => $100)
    Menu parejas ====> $175
    Menu familiar ===> $250
  
  Para hacer pedidos el cliente debe previamente haber completado su registacion con domicilio y telefono
  """

  Antecedentes:
    Dado el cliente "jperez"
    Y se registra con domicilio "Cucha Cucha 1234 1 Piso B" y telefono "4123-4123"
    Y que el repartidor "juanmotoneta" esta registrado

  Escenario: P1 - Hace pedido exitoso
    Cuando el cliente pide un "menu_individual"
    Entonces obtiene numero de pedido único

  Escenario: P2 - menu invalido
    Cuando el cliente pide un "menu_ejecutivo"
    Entonces obtiene error por pedido inválido

  Escenario: CP1 - Consulta de pedido
    Dado que el cliente pidio un "menu_individual"
    Cuando consulta el estado
    Entonces el estado es "recibido"

  Escenario: CP2 - Consulta de pedido inexistente
    Dado que el cliente no hizo pedidos
    Cuando consulta el estado de un pedido
    Entonces obtiene un mensaje indicando que no realizo pedidos

  Escenario: CP3 - Consulta de pedido de otro cliente
    Dado que el cliente pidio un "menu_individual"
    Cuando consulta el estado de un pedido que no hizo el
    Entonces obtiene un mensaje de error indicando que la orden no existe

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

  Escenario: CEP3 - cambio de estado de en_entrega a entregada
      Dado que el cliente pidio un "menu_familiar"
      Cuando el estado cambia a "entregado"
      Y consulta el estado
      Entonces el estado es "entregado"

  @wip
  Escenario: CEP4 - cambio de estado de en_preparacion a en_entrega cuando no hay repartidores disponibles
      Dado que el cliente pidio un "menu_familiar"
      Y el estado cambia a "en_entrega"
      Y consulta el estado
      Y el estado es "en_entrega"
      Y que otro cliente pidio un 'menu_familiar'
      Y no hay repartidor disponible
      Cuando el estado cambia a "en_entrega"
      Y consulta el estado
      Entonces el estado es "en_espera"
      
  Escenario: CEP5 - cambio de estado a un estado invalido
      Dado que el cliente pidio un "menu_familiar"
      Cuando el estado cambia a "cocinando_al_vapor"
      Entonces obtiene un mensaje de error por estado invalido

  Escenario: CANP1 - cancelar pedido recibido
      Dado que el cliente pidio un "menu_individual"
      Cuando se cancela el pedido
      Y consulta el estado
      Entonces el estado es "cancelado"

  Escenario: CANP2 - cancelar pedido en_preparacion
      Dado que el cliente pidio un "menu_individual"
      Y el estado cambio a "en_preparacion"
      Cuando se cancela el pedido
      Y consulta el estado
      Entonces el estado es "cancelado"

  Escenario: CANP3 - cancelar pedido en_entrega
      Dado que el cliente pidio un "menu_individual"
      Y el estado cambio a "en_entrega"
      Cuando se cancela el pedido
      Entonces recibe un error indicando que no puede cancelar el pedido

  Escenario: CANP4 - cancelar pedido entregado
      Dado que el cliente pidio un "menu_individual"
      Y el estado cambio a "entregado"
      Cuando se cancela el pedido
      Entonces recibe un error indicando que no puede cancelar el pedido

  @wip
  Escenario: CANP5 - cancelar pedido en_espera
        Dado que el cliente pidio un "menu_individual"
        Y el estado cambio a "en_espera"
        Cuando se cancela el pedido
        Entonces recibe un error indicando que no puede cancelar el pedido

  Escenario: CH1 - Consulta historica sin pedido en curso
      Dado que el cliente pidio un "menu_individual"
      Y el pedido es entregado por "juanmotoneta"
      Cuando se consultan los pedidos historicos
      Entonces hay un solo pedido historico
      Y hay un pedido de "menu_individual" con id unico entregado por "juanmotoneta" con fecha correcta

  Escenario: CH2 - Consulta historica con pedido en curso
      Dado que el cliente pidio un "menu_individual"
      Y el estado cambia a "en_entrega"
      Cuando se consultan los pedidos historicos
      Entonces no hay ningun pedido en el registro

  Escenario: CH3 - Consulta historica con pedidos multiples
    Dado que el cliente pidio un "menu_individual"
    Y el pedido es entregado por "juanmotoneta"
    Y que el cliente pidio un "menu_pareja"
    Y el pedido es entregado por "juanmotoneta"
    Cuando se consultan los pedidos historicos
    Entonces hay dos pedidos historicos
    Y hay un pedido de "menu_individual" con id unico entregado por "juanmotoneta" con fecha correcta
    Y hay un pedido de "menu_pareja" con id unico entregado por "juanmotoneta" con fecha correcta

  # Escenario: CT1 - Consulta con tiempo de entrega estimado menu_individual y lluvia
  # Escenario: CT2 - Consulta con tiempo de entrega estimado menu_individual y sin lluvia
  # Escenario: CT3 - Consulta con tiempo de entrega estimado menu_familiar y lluvia
  # Escenario: CT4 - Consulta con tiempo de entrega estimado menu_pareja y lluvia
  
