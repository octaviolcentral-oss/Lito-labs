import { createFileRoute, Link, notFound } from "@tanstack/react-router";
import { AppMark, DivisionMark } from "@/components/mark";
import { CrisisNote, PageIntro, Shell } from "@/components/site";
import { getDivision, statusLabel } from "@/lib/content";
import { pageMeta } from "@/lib/seo";

export const Route = createFileRoute("/divisiones/$slug")({
  loader: ({ params }) => {
    const division = getDivision(params.slug);
    if (!division) throw notFound();
    return { division };
  },
  head: ({ loaderData, params }) => {
    const title = loaderData ? `${loaderData.division.name} · Lito Labs` : "División · Lito Labs";
    const description = loaderData?.division.purpose ?? "Una división de Lito Labs.";
    return pageMeta(`/divisiones/${params.slug}`, title, description);
  },
  component: DivisionPage,
});

function DivisionPage() {
  const { division } = Route.useLoaderData();
  const showCrisis = division.slug === "brisia" || division.slug === "brujula";

  return (
    <Shell>
      <PageIntro eyebrow={division.kicker} title={division.name} lede={division.purpose} />
      <div className="mx-auto max-w-5xl space-y-10 px-5 py-12 md:px-8">
        <div className="flex items-start gap-5">
          <DivisionMark slug={division.slug} />
          <p className="max-w-2xl pt-2 text-lg text-muted">{division.audience}</p>
        </div>

        <section>
          <h2 className="text-2xl font-semibold">Cómo se nota</h2>
          <hr className="pink-rule mt-4" />
          <ul className="mt-5 space-y-3">
            {division.promises.map((item) => (
              <li key={item} data-division={division.slug} className="accent-border border-l-4 pl-3">
                {item}
              </li>
            ))}
          </ul>
        </section>

        {division.caution ? (
          <p className="rounded-2xl border border-line bg-paper p-5 text-base">{division.caution}</p>
        ) : null}

        <section>
          <h2 className="text-2xl font-semibold">Apps</h2>
          <hr className="pink-rule mt-4" />
          <ul className="mt-5 grid gap-4">
            {division.apps.map((app) => (
              <li key={app.name} className="flex gap-4 rounded-2xl border border-line bg-paper p-5">
                <AppMark division={division.slug} name={app.name} />
                <div>
                  <h3 className="text-lg font-semibold">{app.name}</h3>
                  <p className="mt-1 flex flex-wrap gap-2">
                    <span className="rounded-full border border-line px-3 py-1 text-sm font-medium">
                      {statusLabel[app.status]}
                    </span>
                    {app.featured ? (
                      <span className="rounded-full border border-pink px-3 py-1 text-sm font-medium">
                        La más avanzada
                      </span>
                    ) : null}
                  </p>
                  <p className="mt-2 text-muted">{app.summary}</p>
                </div>
              </li>
            ))}
          </ul>
        </section>

        {showCrisis ? <CrisisNote /> : null}

        <Link to="/divisiones" className="inline-flex min-h-12 items-center font-medium underline decoration-pink underline-offset-4">
          Todas las divisiones
        </Link>
      </div>
    </Shell>
  );
}
