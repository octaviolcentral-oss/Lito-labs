import { createFileRoute } from "@tanstack/react-router";
import { CrisisNote, PageIntro, Shell } from "@/components/site";
import { MailLink } from "@/components/mail";

export const Route = createFileRoute("/aliados")({
  head: () => ({
    meta: [
      { title: "Para aliados · Lito Labs" },
      {
        name: "description",
        content:
          "Cómo colaborar con Lito Labs: proponer una necesidad, ser probador o recomendar las apps a pacientes y familias.",
      },
    ],
  }),
  component: Aliados,
});

const ways = [
  {
    title: "Propón una necesidad desatendida",
    body: "Cada aplicación nace de una necesidad real: del día a día, del consultorio o de la familia. Si ves un problema que nadie está resolviendo, cuéntanos. Antes de construir, lo pasamos por un filtro: ¿resuelve algo real?, ¿respeta la privacidad?, ¿evita enganchar?",
  },
  {
    title: "Participa como probador",
    body: "Antes de publicar, cada app pasa por una prueba cerrada de al menos 12 personas durante 14 días, como pide Google Play. Tu opinión nos ayuda a corregir antes de lanzar.",
  },
  {
    title: "Recomiéndalas a pacientes o familias",
    body: "Cuando estén publicadas, puedes sugerirlas sabiendo que son privadas, sin anuncios engañosos y en español de México.",
  },
];

function Aliados() {
  return (
    <Shell>
      <PageIntro
        eyebrow="Clínicas, escuelas y colegas"
        title="Para aliados"
        lede="Si eres clínica, escuela, colega o trabajas con familias, nos encantaría construir contigo."
      />
      <div className="mx-auto max-w-5xl space-y-8 px-5 py-12 md:px-8">
        <ol className="space-y-4">
          {ways.map((way, index) => (
            <li key={way.title} className="rounded-2xl border border-line bg-paper p-5 md:p-6">
              <h2 className="text-xl font-semibold">
                <span className="text-muted">{index + 1}. </span>
                {way.title}
              </h2>
              <p className="mt-2 text-muted">{way.body}</p>
            </li>
          ))}
        </ol>

        <section className="rounded-2xl border border-line bg-paper p-5 md:p-6">
          <h2 className="text-2xl font-semibold">Lo que debes saber antes de recomendarlas</h2>
          <ul className="mt-4 space-y-3">
            <li className="border-l-4 border-pink pl-3">
              Las apps de bienestar (Brisia y Brújula) no diagnostican ni sustituyen la terapia. Son un apoyo, no un
              tratamiento.
            </li>
            <li className="border-l-4 border-pink pl-3">
              Tienen botón de ayuda en crisis que conecta con la Línea de la Vida (800 911 2000) y con el 911.
            </li>
            <li className="border-l-4 border-pink pl-3">
              Las apps para niños (Chispa) están pensadas para usarse con un adulto presente y con consentimiento de
              los padres.
            </li>
          </ul>
        </section>

        <CrisisNote />

        <p>
          <MailLink className="inline-flex min-h-12 items-center font-medium underline decoration-pink underline-offset-4" />
        </p>
      </div>
    </Shell>
  );
}
