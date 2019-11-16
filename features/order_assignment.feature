# language: es

Característica: Asignacion de repartidor

    """
    La asignación se realiza de la siguiente forma: cada repartidor tiene un bolso en el que entran o bien 3 menues individuales, o 1 individual +  1 de pareja, o solo 1 familiar. 
    El pedido se debe asignar al repartidor que tiene el bolso mas cercano a estar completo. 
    Si se encuentra mas de un repartidor con este metodo, entonces de esos repartidores se debe elegir el que menos pedidos entrego en el día.
    """

    Antecedentes:
      Dado el repartidor "pepebicicleta" que entrego 1 pedidos
      Y el repartidor "juanmotoneta" que entrego 0 pedidos
      Y el cliente "jperez"
      Y se registra con domicilio "Cucha Cucha 1234 1 Piso B" y telefono "4123-4123"

    Escenario: A0 - Menu individual es asignado cualquier repartidor
      Dado que el cliente pidio un "menu_individual"
      Cuando el estado cambia a "en_entrega"
      Entonces pedido esta asignado a "juanmotoneta" o a "pepebicicleta"
