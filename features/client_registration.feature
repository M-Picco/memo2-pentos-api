# language: es

Característica: Registracion de cliente

    Escenario: RC1 - Registracion exitosa
        Dado el cliente "jperez"
        Cuando se registra con domicilio "Cucha Cucha 1234 1 Piso B" y telefono "4123-4123"
        Entonces obtiene un numero unico de cliente

    Escenario: RC2 - registracion con nombre invalido
        Dado el cliente "#!?"
        Cuando se registra con domicilio "Plumas verdes" y telefono "4098-0997"
        Entonces obtiene un mensaje de error: 'invalid_username'

	Escenario: RC3 - registracion con telefono invalida
        Dado el cliente "juanse"
        Cuando se registra con domicilio "Plumas verdes" y telefono "abcd-4123"
        Entonces obtiene un mensaje de error: 'invalid_phone'