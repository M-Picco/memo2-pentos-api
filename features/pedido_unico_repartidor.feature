# language: es
Característica: Pedido en espera por un repartidor con bolso lleno

Antecedentes:
  Dado el cliente "jperez"
  Y se registra con domicilio "Cucha Cucha 1234 1 Piso B" y telefono "4123-4123"
  Y el repartidor "juanmotoneta"

Escenario: CEP4.2.1 - cambio de estado de en_preparacion a en_espera por tres menus individuales
  Dado que el cliente pidio un "menu_individual"
  Y el estado cambio a "en_entrega"
  Y que el cliente pidio un "menu_individual"
  Y el estado cambio a "en_entrega"
  Y que el cliente pidio un "menu_individual"
  Y el estado cambio a "en_entrega"
  Cuando el cliente pide un "menu_individual"
  Y el estado cambia a "en_entrega"
  Y consulta el estado
  Entonces el estado es "en_espera"

Escenario: CEP4.2.2 - cambio de estado de en_preparacion a en_espera por menu individual mas pareja
  Dado que el cliente pidio un "menu_individual"
  Y el estado cambio a "en_entrega"
  Y que el cliente pidio un "menu_pareja"
  Y el estado cambio a "en_entrega"
  Cuando el cliente pide un "menu_individual"
  Y consulta el estado
  Entonces el estado es "en_espera"

Escenario: CEP4.2.3 - cambio estado de en_preparacion a en_espera por menu familiar
  Dado que el cliente pidio un "menu_familiar"
  Y el estado cambio a "en_entrega"
  Cuando el cliente pide un "menu_individual"
  Y consulta el estado
  Entonces el estado es "en_espera"
