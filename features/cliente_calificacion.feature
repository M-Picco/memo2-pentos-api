# language: es

Característica: Calificacion de Pedidos

  Antecedentes:
    Dado el cliente "jperez"
    Y se registra con domicilio "Cucha Cucha 1234 1 Piso B" y telefono "4123-4123"
    Y el repartidor "juanmotoneta" está registrado

  Escenario: CAP1 - Calificacion exitosa
    Dado que el cliente pidio un "menu_individual"
    Y el pedido es entregado por "juanmotoneta"
    Cuando el cliente califica con 5
    Entonces se registra la calificacion

  Escenario: CAP2 - calificacion de orden recibida
    Dado que el cliente pidio un "menu_individual"
    Cuando el cliente califica con 5
    Entonces recibe un error indicando que no puede calificar un pedido no entregado

  Escenario: CAP3 - calificacion de orden en_preparacion
    Dado que el cliente pidio un "menu_individual"
    Y el estado cambia a "en_preparacion"
    Cuando el cliente califica con 5
    Entonces recibe un error indicando que no puede calificar un pedido no entregado

  Escenario: CAP4 - calificacion de orden en_entrega
    Dado que el cliente pidio un "menu_individual"
    Y el estado cambia a "en_entrega"
    Cuando el cliente califica con 5
    Entonces recibe un error indicando que no puede calificar un pedido no entregado

  Escenario: CAP5 - calificacion de orden inexistente
    Dado que el cliente pidio un "menu_individual"
    Cuando el cliente califica con 5 un pedido inexistente
    Entonces obtiene un mensaje de error indicando que la orden no existe

  Escenario: CAP6 - calificacion de orden de otro cliente
    Dado que el cliente pidio un "menu_individual"
    Cuando califica un pedido que no hizo el
    Entonces obtiene un mensaje de error indicando que la orden no existe

  Escenario: CAP7 - calificacion de orden sin haber hecho pedidos
    Dado que el cliente no hizo pedidos
    Cuando califica un pedido que no hizo el
    Entonces obtiene un mensaje indicando que no realizo pedidos

  Escenario: CAP8 - calificacion por debajo de 1
    Dado que el cliente pidio un "menu_individual"
    Y el pedido es entregado por "juanmotoneta"
    Cuando el cliente califica con 0
    Entonces recibe un error indicando que la calificación es inválida

  Escenario: CAP9 - calificacion por encima de 5
    Dado que el cliente pidio un "menu_individual"
    Y el pedido es entregado por "juanmotoneta"
    Cuando el cliente califica con 6
    Entonces recibe un error indicando que la calificación es inválida
