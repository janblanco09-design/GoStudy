# Go Study 2.0 — App de gestión de estudios

Go Study es una aplicación web para estudiantes hecha con **HTML, CSS y JavaScript**, sin frameworks de terceros. Esta edición mejora el diseño, las animaciones, la experiencia en móvil y las herramientas rápidas, conservando las funciones y la compatibilidad con los datos existentes de la versión anterior.

## Inicio rápido (ordenador)

1. Descomprime el ZIP.
2. Abre la carpeta `Go-Study-Final` en Visual Studio Code.
3. Abre la carpeta con la extensión **Live Server** o desde el terminal ejecuta:

   ```bash
   python -m http.server 5500
   ```

4. Abre `http://localhost:5500` en Chrome, Edge, Firefox o Safari.
5. Ya puedes usar la aplicación **como invitado**. Los datos se guardan automáticamente en el navegador cuando permite almacenamiento local.

> Importante: para probar las funciones PWA y el almacenamiento de forma correcta, utiliza `localhost` o una web HTTPS. Abrir `index.html` directamente desde una carpeta puede tener restricciones según el navegador. Si cambias de dominio o navegador y no tienes sincronización activada, deberás importar una copia de seguridad.

## Qué incluye Go Study 2.0

- **Panel de inicio renovado** con bienvenida, estadísticas reales, próximas tareas, clases de hoy y accesos rápidos.
- **Asignaturas** con colores, profesor, aula y notas.
- **Horario** de lunes a viernes relacionado con asignaturas.
- **Tareas** con prioridad, fecha, recordatorios, búsqueda, filtros, estado y edición.
- **Exámenes** con fechas, detalles y exportación de calendarios.
- **Calendario mensual** de tareas, exámenes y eventos. Zona horaria: `Europe/Madrid`.
- **Temporizador Pomodoro** con períodos de concentración y descansos configurables.
- **Actividad semanal y rachas**: los minutos de estudio se registran cuando se completa una sesión de concentración. Las rachas incluyen tareas completadas con fecha registrada y sesiones de concentración completadas. No se inventan estadísticas previas: los datos históricos sin marca de finalización no se atribuyen a una fecha.
- **Búsqueda rápida de acciones y secciones**: pulsa `Ctrl + K` (o `⌘ + K` en Mac). También puedes usar `N` para crear una tarea y `/` para abrir el buscador, siempre que no estés escribiendo en un formulario.
- **Diseño adaptable** al ordenador y al móvil, con navegación inferior en pantallas pequeñas.
- **Tema claro, oscuro o del sistema**, tres colores de acento y textos en **español o catalán**.
- **Animaciones originales** de entrada, respuesta al pasar el ratón, pequeños detalles en tarjetas y celebración al finalizar tareas. Respeta la preferencia de accesibilidad *reducir movimiento*.
- **Exportación e importación de copias de seguridad JSON**, exportación `.ics` y botones para Google Calendar.
- **Instalación como PWA** con iconos, manifest y service worker para recursos esenciales sin conexión después de la primera visita correcta.

## Organización de archivos

```text
Go-Study-Final/
├── index.html              # Estructura de la interfaz
├── styles.css              # Estilos de la aplicación original
├── studio.css              # Nuevo diseño, animaciones y ajustes responsive
├── app.js                  # Funcionalidad original + nuevas herramientas
├── config.js               # Configuración opcional de Supabase
├── supabase.sql            # Tabla y políticas de seguridad en Supabase
├── sw.js                   # Caché de PWA actualizado
├── manifest.webmanifest    # Instalación en móvil y ordenador
├── assets/
│   ├── logo.png
│   ├── icon-192.png
│   └── icon-512.png
└── README.md
```

**Si cambias un archivo CSS, edita preferiblemente `studio.css`**. Se carga después de `styles.css` y contiene todas las mejoras visuales. Es importante conservar ambos.

## Cómo usarla en el móvil

La aplicación se adapta al tamaño de pantalla. En móvil hay una barra inferior con accesos a Inicio, Tareas, Calendario, Temporizador y Menú. El calendario lateral de escritorio no se duplica en pantallas pequeñas porque existe una vista de Calendario completa.

Para instalarla: publica la carpeta en un alojamiento HTTPS (por ejemplo Netlify, Vercel, Cloudflare Pages o GitHub Pages). Después, en iPhone/Safari utiliza **Compartir → Añadir a pantalla de inicio**; en Android/Chrome, **Instalar aplicación** o **Añadir a pantalla de inicio**.

## Guardado de datos y cuentas

Por defecto, Go Study guarda tus datos en **localStorage** de ese navegador. No requiere cuenta ni conexión para el uso habitual. Si borras los datos del navegador, se pueden perder: **haz copias de seguridad JSON desde Configuración**.

La autenticación y la sincronización entre dispositivos son **opcionales** y requieren configurar un proyecto real de Supabase. Sin él, la pantalla de acceso explica la limitación: no simula un registro inexistente.

1. Crea un proyecto en https://supabase.com/.
2. En **SQL Editor**, ejecuta `supabase.sql`.
3. En **Authentication → Providers**, activa el proveedor de correo electrónico.
4. Obtén la **URL del proyecto** y la clave pública *anon/publishable* desde el panel del proyecto.
5. Rellena `config.js`:

   ```js
   window.GO_STUDY_CONFIG = {
     supabaseUrl: 'https://TU-PROYECTO.supabase.co',
     supabaseAnonKey: 'TU_CLAVE_PUBLICA'
   };
   ```

6. Configura las URLs permitidas en Supabase Authentication y publica la web por HTTPS.
7. Abre Go Study, inicia sesión y utiliza el mismo usuario en tus dispositivos.

**Nunca pongas en `config.js` la clave `service_role` ni secretos privados.** La aplicación utiliza políticas RLS por usuario. La sincronización es de último guardado; editar simultáneamente la misma cuenta desde dos dispositivos puede provocar sobrescrituras. Antes de probar una cuenta distinta, exporta una copia de seguridad.

## Notificaciones y calendarios

- Para recibir notificaciones, activa los permisos desde Configuración y usa HTTPS o localhost.
- Los avisos y el temporizador **no están garantizados cuando el navegador está completamente cerrado o el sistema operativo suspende la aplicación**. Para notificaciones fiables en segundo plano se necesita Web Push con backend.
- Los botones de Google Calendar crean enlaces para añadir eventos; la exportación `.ics` permite importarlos en Apple Calendar y otros calendarios. **No es sincronización bidireccional**.

## Compatibilidad con la versión anterior

- Mantiene la clave de almacenamiento `go-study-data-v1` para cargar los datos locales de una versión existente que se ejecute **en el mismo origen web**.
- Los campos nuevos (`studyLog`, `completedAt`, preferencia de acento) se incorporan sin exigir reiniciar los datos.
- Las copias de seguridad JSON antiguas siguen siendo importables siempre que conserven la estructura habitual de la aplicación.
- Si publicas la nueva carpeta en otra dirección, **exporta una copia de seguridad de la antigua e impórtala en la nueva**.

## Diseño y rendimiento

Los movimientos y las transiciones siguen los principios de la skill **Taste Skill** entregada: animación de entrada enfocada en el contenido, respuesta visual a botones y controles, iluminación suave y respeto por `prefers-reduced-motion`. Se ha adaptado a un dashboard real en lugar de copiar componentes promocionales que no encajan en una aplicación de gestión de estudios. Los gráficos y decoraciones están hechos con CSS y JavaScript propios: no se necesitan librerías ni cuentas de pago.
