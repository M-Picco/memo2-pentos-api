# language: es

Característica: Calculo de comisiones de repartidor

"""
Menu individual ($100), Menu parejas ($175), Menu familiar ($250).

Las comisiones son de 5% del valor de cada pedido entregado, pero si la entrega tuvo una calificación de 1,
entonces la comisión es de 3% y si fue de 5 la calificación, la comisión es del 7%.
A su vez los dias de lluvia las comisiones se incrementan en un 1% (*)
"""


    Antecedentes:
        Dado el cliente "jperez"
        Y se registra con domicilio "Cucha Cucha 1234 1 Piso B" y telefono "4123-4123"
        Y el repartidor "juanmotoneta" está registrado

    Escenario: COM1 - Comision por menu_individual con buena calificacion y sin lluvia
      Dado que el cliente pidio un "menu_individual"
      Cuando el pedido es entregado por "juanmotoneta"
      Y el cliente califica con 3
      Y no llueve
      Entonces la comision 5.0
    
    Escenario: COM2 - Comision por menu_parejas con buena calificacion y sin lluvia
      Dado que el cliente pidio un "menu_pareja"
      Cuando el pedido es entregado por "juanmotoneta"
      Y el cliente califica con 4
      Y no llueve
      Entonces la comision 8.75

    Escenario: COM3 - Comision por menu_familiar con buena calificacion y sin lluvia
      Dado que el cliente pidio un "menu_familiar"
      Cuando el pedido es entregado por "juanmotoneta"
      Y el cliente califica con 4
      Y no llueve
      Entonces la comision 12.5

    @wip
    Escenario: COM4 - Comision por menu_familiar con mala calificacion y sin lluvia
      Dado que el cliente pidio un "menu_familiar"
      Cuando el pedido es entregado por "juanmotoneta"
      Y el cliente califica con 1
      Y no llueve
      Entonces la comision 7.5

    @wip
    Escenario: COM5 - Comision por menu_familiar con excelente calificacion y con lluvia
      Dado que el cliente pidio un "menu_familiar"
      Cuando el pedido es entregado por "matipatineta"
      Y el cliente califica con 5
      Y llueve
      Entonces la comision 20

    @wip
    Escenario: COM6 - Comision por menu_familiar con mala calificacion y con lluvia
      Dado que el cliente pidio un "menu_familiar"
      Cuando el pedido es entregado por "matipatineta"
      Y el cliente califica con 1
      Y llueve
      Entonces la comision 10
