# language: es
Característica: Pedido en espera por falta de repartidores

Antecedentes:
  Dado el cliente "jperez"
  Y se registra con domicilio "Cucha Cucha 1234 1 Piso B" y telefono "4123-4123"

@wip
Escenario: CEP4.1.1 - cambio de estado de en_preparacion a en_espera porque no hay repartidores
  Dado que el cliente pidio un "menu_pareja"
  Cuando el estado cambia a "en_entrega"
  Y consulta el estado
  Entonces el estado es "en_espera"
