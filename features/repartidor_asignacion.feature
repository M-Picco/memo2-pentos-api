# language: es

Característica: Asignacion de repartidor

    """
    La asignación se realiza de la siguiente forma: cada repartidor tiene un bolso en el que entran o bien 3 menues individuales, o 1 individual +  1 de pareja, o solo 1 familiar. 
    El pedido se debe asignar al repartidor que tiene el bolso mas cercano a estar completo. 
    Si se encuentra mas de un repartidor con este metodo, entonces de esos repartidores se debe elegir el que menos pedidos entrego en el día.
    """

    Antecedentes:
        Dado el cliente "afernandez"
        Y se registra con domicilio "Mexico 987 10 Piso" y telefono "3131-6789"
        Y el repartidor "pepebicicleta" que entrego 1 pedidos
        Y el repartidor "juanmotoneta" que entrego 0 pedidos

    Escenario: A0 - Menu individual es asignado cualquier repartidor
      Dado el cliente pide un "menu_individual"
      Cuando el estado cambia a "en_entrega"
      Entonces pedido esta asignado a "juanmotoneta" o a "pepebicicleta"

    Escenario: A1 - Menu individual es asignado al repartidor con menos pedidos
      Dado el cliente pide un "menu_familiar"
      Cuando el estado cambia a "en_entrega"
      Entonces pedido esta asignado a "juanmotoneta"

    Escenario: A2 - menu individual es asignado al repartidor con bolso mas lleno
      Dado que el cliente pidio un "menu_individual"
      Cuando el estado cambia a "en_entrega"
      Entonces pedido esta asignado a "juanmotoneta"
      Dado que el cliente pidio un "menu_pareja"
      Cuando el estado cambia a "en_entrega"
      Entonces pedido esta asignado a "juanmotoneta"

    Escenario: A3 - Menu familiar es asignado al repartido con bolso vacio
      Dado que el cliente pidio un "menu_individual"
      Cuando el estado cambia a "en_entrega"
      Entonces pedido esta asignado a "juanmotoneta"
      Dado que el cliente pidio un "menu_familiar"
      Cuando el estado cambia a "en_entrega"
      Entonces pedido esta asignado a "pepebicicleta"
@wip
    Escenario: AA1 - Repartido espera a lo sumo 10 minutos el llenado de su bolso
      Dado el cliente pide un "menu_individual"
      Cuando el estado cambia a "en_entrega"
      Entonces pedido esta asignado a "juanmotoneta"
      Cuando "juanmotoneta" pasa 10 minutos esperando el llenado de su bolso
      Entonces "juanmotoneta" comienza la entrega