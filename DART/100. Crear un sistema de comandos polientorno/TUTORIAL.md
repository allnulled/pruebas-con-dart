¿Qué significa sistema de comandos polientorno?

Significa un sistema de comandos compatible con:

- entorno de línea de comandos
- entorno de petición de servidor http
- entorno de aplicación gráfica

## Requisitos

Se juntan 3 secciones anteriores:

- [Crear un árbol funcional](#)
   - nos permite dinamizar el acceso a las funciones de cada comando
   - nos permite acceder vía cliente gráfico
- [Crear una línea de comandos simple](#)
   - nos permite acceder vía línea de comandos
- [Crear un servidor simple](#)
   - nos permite acceder vía servidor HTTP

## Objetivos

- Tener 1 API común para todos los entornos que sea:
   - accesible
      - ...
   - dinámica
      - basada en maps y lists
   - permita personalización

```dart
List command = {"parametros": {"de": "comando"}};
Map args = ["ruta", "a", "comando"];
CommandsManager.cli.dispatch(command, args);
CommandsManager.gui.dispatch(command, args);
CommandsManager.server.dispatch(command, args);
CommandsManager.common.dispatch(command, args);
```