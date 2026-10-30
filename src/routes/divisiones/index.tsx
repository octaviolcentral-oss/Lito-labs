import { createFileRoute, Link } from "@tanstack/react-router";
import { DivisionMark } from "@/components/mark";
import { PageIntro, Shell } from "@/components/site";
import { divisions, statusLabel } from "@/lib/content";
import { pageMeta } from "@/lib/seo";

export const Route = createFileRoute("/divisiones/")({
  head: () =>
    pageMeta(
      "/divisiones",
      "Divisiones · Lito Labs",
      "Seis divisiones de Lito Labs: Brisia, Brújula, Chispa, Tuerca, Prisma y Oficio. Cada una con su color y sus apps.",
    ),
  component: Divisiones,
});

function Divisiones() {
  return (
    <Shell>
      <PageIntro
        eyebrow="El estudio"
        title="Divisiones"
        lede="Seis líneas de trabajo para necesidades distintas. El mismo estándar en todas: propósito, privacidad y cuidado."
      />
      <div className="mx-auto max-w-5xl space-y-5 px-5 py-12 md:px-8">
        {divisions.map((division) => (
          <article key={division.slug} data-division={division.slug} className="division-card rounded-2xl bg-paper p-5 md:p-6">
            <div className="flex flex-col gap-5 sm:flex-row sm:items-center">
              <DivisionMark slug={division.slug} />
              <div className="min-w-0 flex-1">
                <h2 className="text-2xl font-semibold">{division.name}</h2>
                <p className="mt-1 text-muted">{division.kicker}</p>
                <p className="mt-3">{division.purpose}</p>
                <ul className="mt-4 flex flex-wrap gap-2">
                  {division.apps.map((app) => (
                    <li key={app.name} className="rounded-full border border-line px-3 py-1 text-sm font-medium">
                      {app.name}
                      <span className="text-muted"> · {statusLabel[app.status]}</span>
                    </li>
                  ))}
                </ul>
                <Link
                  to="/divisiones/$slug"
                  params={{ slug: division.slug }}
                  className="mt-4 inline-flex min-h-12 items-center font-medium underline decoration-pink underline-offset-4"
                >
                  Entrar a {division.name}
                </Link>
              </div>
            </div>
          </article>
        ))}
      </div>
    </Shell>
  );
}
