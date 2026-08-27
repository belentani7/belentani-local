# Arquitectura de Belentani v0.3

## Principio operativo

Belentani separa la interfaz, la política y la ejecución. Ninguna capa interpreta una intención mediante IA ni necesita credenciales. Una funcionalidad no se anuncia como disponible hasta que se ejecuta una prueba contra una ruta de trabajo real.

```text
UI web (solo lectura, permiso explícito)
              │
              ▼
      Browser Workspace Adapter
              │
              ▼
CLI local ──► Core determinista ──► Workspace acotado
                  │         │
                  │         └──► Registro .belentani/audit.jsonl
                  ▼
        Política SAFE / CAUTION / DANGEROUS / BLOCKED
```

## Componentes

| Componente | Responsabilidad | Estado |
|---|---|---|
| `core/belentani-core.mjs` | Validación de workspace, inspección, política, ejecución y registro | VERIFIED |
| `bin/belentani.mjs` | Interfaz CLI para doctor, inspect, policy y run | VERIFIED |
| `client/src/lib/browserWorkspace.ts` | Selección de directorio y lectura de archivos por permiso del navegador | VERIFIED en navegadores compatibles |
| `client/src/lib/localPolicy.ts` | Política visual de comandos en frontend | VERIFIED |
| `client/src/pages/Home.tsx` | Visualización de evidencia y navegación solo lectura | VERIFIED |

## Contrato de ejecución

Una orden se normaliza y se clasifica. Las órdenes `SAFE` se ejecutan dentro del workspace. Las `CAUTION` requieren `--approve`. Las `DANGEROUS` y `BLOCKED` no se ejecutan. Las operaciones de paquetes requieren `--network`, de modo que la red nunca se activa por accidente.

Cada ejecución almacena comando, política, salida estándar, error estándar, código de salida, duración, marca temporal y estado en un JSONL local. Los archivos de auditoría se escriben dentro del propio workspace y nunca en un servicio remoto.

## Superficies no incluidas

La arquitectura no contiene bus de modelos, adaptadores Ollama, proveedores externos, navegador automatizado, despliegue, GitHub, edición autónoma ni memoria de usuario. Son **NOT_IMPLEMENTED** por diseño: requieren un alcance y una autorización independiente, y no se representan como funciones operativas.
