# language: es

Característica: Registracion de cliente

    Escenario: RC1 - Registracion exitosa
        Dado el cliente "jperez"
        Cuando se registra con domicilio "Cucha Cucha 1234 1 Piso B" y telefono "4123-4123"
        Entonces obtiene un numero unico de cliente