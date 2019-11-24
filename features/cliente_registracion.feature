# language: es

Característica: Registracion de cliente

    Regla: nombre de usuario puede contener a-z, 0-9 y _
    
    Escenario: RC1 - Registracion exitosa
        Dado el cliente "jperez"
        Cuando se registra con domicilio "Cucha Cucha 1234 1 Piso B" y telefono "4123-4123"
        Entonces obtiene un numero unico de cliente

    Escenario: RC2 - registracion con nombre invalido
        Dado el cliente "#!?"
        Cuando se registra con domicilio "Plumas verdes" y telefono "4098-0997"
        Entonces obtiene un mensaje de error por nombre de usuario inválido

    Escenario: RC3 - registracion con telefono invalida
        Dado el cliente "juanse"
        Cuando se registra con domicilio "Plumas verdes" y telefono "abcd-4123"
        Entonces obtiene un mensaje de error por número de teléfono inválido

    Escenario: RC4 - registracion con domicilio invalida
        Dado el cliente "pedrosi"
        Cuando se registra con domicilio "a1" y telefono "4098-0997"
        Entonces obtiene un mensaje de error por domicilio inválido

    Escenario: RC5 - Hacer pedido sin estar registrado
        Dado el cliente "jperez"
        Cuando el cliente pide un "menu_individual"
        Entonces obtiene error por no estar registrado

    Escenario: RC6 - Registración Repetida
        Dado que el cliente "pedrosi" esta registrado con domicilio "Cucha Cucha 1234 1 Piso B" y telefono "4123-4123"
        Cuando se registra con domicilio "Cucha Cucha 1234 1 Piso B" y telefono "4123-4123"
        Entonces obtiene un mensaje de error por ya estar registrado
