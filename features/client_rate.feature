# language: es

Característica: Calificacion de Pedidos

  Antecedentes:
    Dado el cliente "jperez"
    Y se registra con domicilio "Cucha Cucha 1234 1 Piso B" y telefono "4123-4123"

  @wip
  Escenario: CAP1 - Calificacion exitosa
    Dado el cliente pide un "menu_individual"
    Y el pedido es entregado por "juanmotoneta"
    Cuando el cliente califica con 5
    Entonces se registra la calificacion
