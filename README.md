# KOS Essence

Aplicación educativa en SwiftUI inspirada en la identidad visual de KOS Muse y en el universo artístico de Kenia OS.

## Interacciones

- **Swipe vertical:** desplaza las cuatro secciones a pantalla completa: Inicio, Música, Trayectoria y Galería.
- **Swipe horizontal:** cambia entre las tarjetas de álbumes y los conceptos de la galería.

## Compilar con GitHub Actions

1. Sube el contenido de esta carpeta a la rama `main` de tu repositorio.
2. En GitHub abre **Actions**.
3. Selecciona **Compilar KOS Essence para iOS** y pulsa **Run workflow**. También se ejecuta al hacer push a `main`.
4. Cuando termine, abre la ejecución y descarga el artefacto **KOS-Essence-IPA**.
5. Extrae el ZIP descargado para obtener `KOS-Essence.ipa`.
6. Usa Sideloadly para firmarlo con tu Apple ID e instalarlo en el iPhone.

## Detalles técnicos

- Proyecto Xcode: `PuebloMagico.xcodeproj`
- Scheme y target: `PuebloMagico`
- Bundle identifier: `com.vicb23.KOSEssence`
- Deployment target: iOS 17.2
- Workflow: `.github/workflows/compilar-ios.yml`

El IPA generado por Actions es **sin firmar**; Sideloadly realiza la firma para instalarlo en el dispositivo.

Las portadas y tarjetas de esta versión son diseños originales hechos en SwiftUI, no fotografías oficiales. Puedes sustituirlas después por imágenes que tengas permiso de utilizar.
