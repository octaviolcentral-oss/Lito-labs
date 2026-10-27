import { createFileRoute } from "@tanstack/react-router";
import type { ReactNode } from "react";
import { PageIntro, Shell } from "@/components/site";
import { MailLink } from "@/components/mail";

export const Route = createFileRoute("/privacidad")({
  head: () => ({
    meta: [
      { title: "Privacidad · Lito Labs" },
      {
        name: "description",
        content:
          "Política de privacidad de Lito Labs en lenguaje sencillo: los datos se quedan en el teléfono y este sitio no te rastrea.",
      },
    ],
  }),
  component: Privacidad,
});

function Block({ title, children }: { title: string; children: ReactNode }) {
  return (
    <section>
      <h2 className="text-2xl font-semibold">{title}</h2>
      <hr className="pink-rule mt-4" />
      <div className="mt-4 max-w-3xl space-y-3 text-lg">{children}</div>
    </section>
  );
}

function Privacidad() {
  return (
    <Shell>
      <PageIntro
        eyebrow="Lenguaje sencillo"
        title="Privacidad"
        lede="Tus datos se quedan en tu teléfono. No los vendemos y no te seguimos por la web."
      />
      <div className="mx-auto max-w-5xl space-y-10 px-5 py-12 md:px-8">
        <Block title="Se quedan en tu dispositivo">
          <p>
            Las apps de Lito Labs guardan lo tuyo en el teléfono. Fotos, tareas, rondas o lo que uses para estar en
            calma no viaja a un servidor nuestro para que lo leamos.
          </p>
          <p>La función principal está pensada para servir sin conexión, siempre que se pueda.</p>
          <p>Puedes exportar o borrar tus datos con un toque. Si niegas un permiso, la app sigue con lo que pueda hacer sin él.</p>
        </Block>
        <Block title="No vendemos datos, ni te rastreamos">
          <p>No vendemos datos a terceros. No hay anuncios. No hay analíticas que miren lo que haces dentro de la app.</p>
          <p>Este sitio no usa cookies de publicidad ni de rastreo. No te pedimos que te registres para leerlo.</p>
          <p>
            Si algún día contamos visitas, será con una herramienta sin cookies, que no te identifica. Hoy no hay
            ninguna.
          </p>
        </Block>
        <Block title="Cuando una app pide cuenta">
          <p>
            Casi ninguna app de Lito Labs pide cuenta. ilux sí puede pedirla, porque es una herramienta de trabajo
            para un equipo de guardias.
          </p>
          <p>
            En ese caso los datos van cifrados y protegidos. Solo ve lo necesario quien opera el servicio, y te
            decimos antes qué se guarda y para qué. No se usa para publicidad ni se vende.
          </p>
        </Block>
        <Block title="Niños, calma y trabajo">
          <p>
            Las apps para niños se usan con un adulto y con permiso de quien cuida. No recogen datos de menores, no
            tienen chat y no tienen compras escondidas.
          </p>
          <p>Las apps de bienestar no diagnostican y no guardan expedientes. Los ejemplos son ficticios.</p>
        </Block>
        <Block title="Si nos escribes">
          <p>
            El correo o el formulario de contacto sirven para responderte. Usamos tu nombre, tu correo y lo que nos
            cuentes solo para eso. No los pasamos a una lista de anuncios.
          </p>
          <p>
            Lito Labs, en Tepatitlán de Morelos, Jalisco, México. Dudas de privacidad: <MailLink className="font-medium text-ink underline decoration-pink underline-offset-4" />.
          </p>
          <p className="text-base text-muted">Texto vigente: octubre de 2026. Si cambia, lo diremos en esta misma página.</p>
        </Block>
      </div>
    </Shell>
  );
}
