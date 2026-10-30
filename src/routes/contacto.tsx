import { createFileRoute, Link } from "@tanstack/react-router";
import { PageIntro, Shell } from "@/components/site";
import { MailLink } from "@/components/mail";

import { featuredApps } from "@/lib/content";
import { pageMeta } from "@/lib/seo";

const fieldClass =
  "mt-2 w-full rounded-xl border border-muted bg-paper px-4 py-3 text-base text-ink placeholder:text-muted";

export const Route = createFileRoute("/contacto")({
  head: () =>
    pageMeta(
      "/contacto",
      "Contacto · Lito Labs",
      "Escribe a Lito Labs o pide ser probador. hola@litolabs.app. Tepatitlán de Morelos, Jalisco.",
    ),
  component: Contacto,
});

function Contacto() {
  return (
    <Shell>
      <div id="contacto">
        <PageIntro
          eyebrow="Tepatitlán de Morelos, Jalisco"
          title="Contacto"
          lede="Si quieres probar una app o contarnos una necesidad, déjanos tus datos. Te respondemos por correo."
        />
        <div className="mx-auto max-w-5xl px-5 py-12 md:px-8">
          <p className="max-w-xl">
            También puedes escribir directo a{" "}
            <MailLink className="font-medium underline decoration-pink underline-offset-4" />
            .
          </p>

          {/*
            GOOGLE FORMS — cómo conectar este formulario a tu hoja de cálculo

            1. Crea un Google Form con estos campos, en este orden:
               Nombre, Correo, Dispositivo Android, App, Mensaje.
            2. En el formulario, clic en los tres puntos → Obtener enlace prellenado no sirve.
               Abre el formulario para responder, clic derecho → Ver código fuente de la página,
               y busca form action="https://docs.google.com/forms/d/e/XXXX/formResponse".
            3. Pega esa URL en el atributo action del <form> de abajo
               (hoy dice REEMPLAZA_ESTE_ID).
            4. En ese mismo código fuente, cada input tiene name="entry.123456789".
               Sustituye entry.NOMBRE, entry.CORREO, entry.DISPOSITIVO, entry.APP y entry.MENSAJE
               por los entry que correspondan a cada pregunta.
            5. El campo "company" es el honeypot. No lo agregues al Google Form
               y no le pongas un name="entry...". Si viene lleno, el navegador no envía el formulario.
            6. El checkbox de privacidad se llama entry.PRIVACIDAD. Si quieres guardarlo
               en la hoja, crea una pregunta de casilla y sustituye ese name por su entry.
               El atributo required ya impide enviar el formulario si no está marcado.
          */}
          <form
            className="relative mt-8 max-w-xl space-y-5"
            method="POST"
            action="https://docs.google.com/forms/d/e/REEMPLAZA_ESTE_ID/formResponse"
            target="_blank"
            rel="noopener noreferrer"
            onSubmit={(event) => {
              const data = new FormData(event.currentTarget);
              if (String(data.get("company") || "").trim() !== "") {
                event.preventDefault();
              }
            }}
          >
            <div className="honeypot" aria-hidden="true">
              <label htmlFor="company">Empresa</label>
              <input id="company" name="company" type="text" tabIndex={-1} autoComplete="off" />
            </div>

            <div>
              <label className="font-medium" htmlFor="nombre">
                Nombre
              </label>
              <input id="nombre" className={fieldClass} name="entry.NOMBRE" type="text" required autoComplete="name" />
            </div>
            <div>
              <label className="font-medium" htmlFor="correo">
                Correo
              </label>
              <input
                id="correo"
                className={fieldClass}
                name="entry.CORREO"
                type="email"
                required
                autoComplete="email"
              />
            </div>
            <div>
              <label className="font-medium" htmlFor="dispositivo">
                Dispositivo Android que usas
              </label>
              <input
                id="dispositivo"
                className={fieldClass}
                name="entry.DISPOSITIVO"
                type="text"
                required
                placeholder="Por ejemplo, Pixel 8"
                autoComplete="off"
              />
            </div>
            <div>
              <label className="font-medium" htmlFor="app">
                ¿Qué app te interesa probar?
              </label>
              <select id="app" className={fieldClass} name="entry.APP" required defaultValue="">
                <option value="" disabled>
                  Elige una
                </option>
                {featuredApps.map((app) => (
                  <option key={app.name} value={app.name}>
                    {app.name}
                  </option>
                ))}
              </select>
            </div>
            <div>
              <label className="font-medium" htmlFor="mensaje">
                Mensaje
              </label>
              <textarea id="mensaje" className={fieldClass} name="entry.MENSAJE" rows={5} required />
            </div>
            <div className="flex items-start gap-3">
              <input
                id="acepto"
                name="entry.PRIVACIDAD"
                type="checkbox"
                value="Sí"
                required
                className="mt-1 size-5 shrink-0 accent-ink"
              />
              <label htmlFor="acepto">
                He leído y acepto la{" "}
                <Link to="/privacidad" className="font-medium underline decoration-pink underline-offset-4">
                  Política de Privacidad
                </Link>
              </label>
            </div>
            <p className="text-sm text-muted">
              Al enviar tus datos, entrarás a nuestra lista de espera. Te contactaremos en cuanto se libere un nuevo
              cupo para la prueba cerrada de la app que elegiste.
            </p>
            <button
              type="submit"
              className="inline-flex min-h-12 items-center rounded-full bg-ink px-5 font-medium text-cream"
            >
              Enviar
            </button>
          </form>
        </div>
      </div>
    </Shell>
  );
}