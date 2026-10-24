# Organizador de la Despedida: cómo publicarlo

Son 3 partes: **Supabase** (donde se guardan los datos), **config.js** (conectar la página con Supabase) y **GitHub Pages** (publicar la web). Calcula unos 20 minutos.

Archivos de esta carpeta:

| Archivo | Para qué sirve |
|---|---|
| `index.html` | La página |
| `config.js` | La dirección y la clave de tu proyecto de Supabase (las rellenas tú) |
| `supabase-setup.sql` | Crea la tabla y la carpeta de tickets en Supabase |
| `LEEME.md` | Estas instrucciones (no hace falta subirlo) |

---

## 1. Supabase

1. Entra en <https://supabase.com>, crea una cuenta gratuita y pulsa **New project**.
   - Nombre: `despedida` (o el que quieras).
   - Database password: pon una cualquiera y guárdala. La página no la usa.
   - Region: **West EU (Ireland)** o **Central EU (Frankfurt)**.
2. Cuando el proyecto esté listo (1-2 minutos), ve a **SQL Editor → New query**, pega el contenido de `supabase-setup.sql` y pulsa **Run**. Debe salir *Success*.
3. **Desactiva el registro público** para que nadie más pueda crearse una cuenta:
   **Authentication → Sign In / Providers** (en algunas versiones **Authentication → Settings**) → desactiva **Allow new users to sign up** → **Save**.
   Deja activado el proveedor **Email**.
4. **Crea la contraseña de acceso**:
   **Authentication → Users → Add user → Create new user**
   - Email: `organizadora@despedida.app`, exactamente el mismo que aparece en `config.js`. Es solo una cuenta interna: nadie lo escribe y no se envían correos.
   - Password: **la contraseña de acceso que le vas a pasar a tu amiga** (por ejemplo `LaMejorOrganizadoraDeEventos`). Distingue mayúsculas y minúsculas.
   - Marca **Auto Confirm User**.

   La página solo le pedirá esa contraseña. Si se la pasas a alguien más (a ti mismo, por ejemplo), entrará igual.
   Si Supabase no acepta ese email, pon cualquier otro (por ejemplo el tuyo) y cámbialo también en `config.js`.
5. Copia los datos de conexión: **Project Settings → API** (o el botón **Connect** de la parte de arriba):
   - **Project URL**, por ejemplo `https://abcdefghijkl.supabase.co`
   - **Clave pública**: la **anon public** (empieza por `eyJ…`) o la **publishable** (empieza por `sb_publishable_…`).
   - ⚠️ **Nunca** uses la `service_role` ni la `secret`.

## 2. config.js

Abre `config.js` con cualquier editor de texto y sustituye los dos `PEGA_AQUI_…` por la URL y la clave del paso anterior, manteniendo las comillas. El `email` déjalo como está, salvo que lo hayas cambiado en el paso 4.

## 3. GitHub Pages

1. Entra en <https://github.com> (crea una cuenta si no tienes) → **New repository**.
   - Nombre: por ejemplo `despedida`.
   - Tiene que ser **Public**: GitHub Pages gratis solo funciona con repositorios públicos. Los datos no se ven, solo el código de la página; los datos están en Supabase, protegidos por el login.
   - Pulsa **Create repository**.
2. En el repositorio nuevo: **uploading an existing file** (o **Add file → Upload files**), arrastra `index.html` y `config.js` → **Commit changes**.
3. **Settings → Pages** → *Source*: **Deploy from a branch** → Branch: **main** y carpeta **/(root)** → **Save**.
4. Al cabo de 1-2 minutos aparecerá la dirección, del tipo `https://TU-USUARIO.github.io/despedida/`. Esa es la que le pasas a tu amiga.

En el móvil puede añadirla a la pantalla de inicio (Safari: Compartir → *Añadir a pantalla de inicio*; Chrome: menú ⋮ → *Añadir a pantalla de inicio*) para abrirla como si fuera una app.

---

## Cosas que conviene saber

- **Supabase pausa los proyectos gratuitos tras 7 días sin uso.** No se pierde nada: si un día la página no carga los datos, entra en supabase.com y pulsa **Restore project** (tarda unos minutos). Mientras la esté usando no pasa.
- **Cambiar la contraseña de acceso** (si se olvida o si la ha visto alguien más): Authentication → Users → `organizadora@despedida.app` → menú **⋯** → cambia la contraseña.
- **Sin cobertura** (por ejemplo, en el hospital): puede seguir usándola. Los cambios se guardan en el móvil y se suben solos al volver la conexión. Lo que no se puede sin conexión es subir tickets.
- **Copias de seguridad**: en **Ajustes → Descargar copia** se descarga un archivo con todo. Conviene hacer una de vez en cuando.
- **Cambios en la página**: edita `index.html` y vuelve a subirlo al repositorio (**Add file → Upload files**, sustituyendo el anterior). Los datos no se tocan.
