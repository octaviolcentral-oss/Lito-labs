import { createFileRoute, Link } from "@tanstack/react-router";
import { PageIntro, Shell } from "@/components/site";
import { divisions, statusLabel } from "@/lib/content";
import { pageMeta } from "@/lib/seo";

export const Route = createFileRoute("/estado")({
  head: () =>
    pageMeta(
      "/estado",
      "Estado de las apps · Lito Labs",
      "Ninguna aplicación de Lito Labs está publicada en Google Play. Casi todas funcionan en prueba cerrada.",
    ),
  component: Estado,
});

function Estado() {
  return (
    <Shell>
      <PageIntro
        eyebrow="Transparencia"
        title="Estado de las apps"
        lede="Preferimos lanzar pocas apps, pero excepcionalmente bien pulidas y cuidadas."
      />
      <div className="mx-auto max-w-5xl space-y-8 px-5 py-12 md:px-8">
        <div className="max-w-3xl space-y-4 text-lg">
          <p>Desarrollo en marcha. Actualmente, ninguna de nuestras aplicaciones está publicada en Google Play.</p>
          <p>
            Casi todas ya funcionan y se encuentran en fase de prueba cerrada. Linde, Ajolote Fighters e ilux siguen
            en desarrollo. Tlali hoy es una maqueta. Relevo está en prueba cerrada.
          </p>
          <p>La más avanzada es Loto y Lito.</p>
          <p>
            Antes de publicar, cada app pasa por una prueba cerrada de al menos 12 personas durante 14 días. No
            llamamos lista a una aplicación que no se ha cuidado con ese rigor.
          </p>
        </div>

        <div className="space-y-8">
          {divisions.map((division) => (
            <section key={division.slug} aria-labelledby={`estado-${division.slug}`}>
              <h2 id={`estado-${division.slug}`} className="text-xl font-semibold">
                <Link
                  to="/divisiones/$slug"
                  params={{ slug: division.slug }}
                  className="underline decoration-pink underline-offset-4"
                >
                  {division.name}
                </Link>
                <span className="font-light text-muted"> · {division.kicker}</span>
              </h2>
              <ul className="mt-3 divide-y divide-line rounded-2xl border border-line bg-paper">
                {division.apps.map((app) => (
                  <li key={app.name} className="flex flex-col gap-2 px-4 py-4 sm:flex-row sm:items-start sm:justify-between">
                    <div>
                      <p className="font-medium">{app.name}</p>
                      <p className="text-muted">{app.summary}</p>
                    </div>
                    <p className="shrink-0 text-sm font-medium">{statusLabel[app.status]}</p>
                  </li>
                ))}
              </ul>
            </section>
          ))}
        </div>
      </div>
    </Shell>
  );
}
