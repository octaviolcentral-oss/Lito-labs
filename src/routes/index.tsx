import { useRef, useState } from "react";
import { createFileRoute, Link } from "@tanstack/react-router";
import { DivisionMark } from "@/components/mark";
import { Shell } from "@/components/site";
import { divisions, noItems, promises, yesItems } from "@/lib/content";

const showcase = [
  {
    slug: "oficio",
    badge: "Próximamente · Suscripción",
    title: "ilux",
    division: "Oficio",
    description:
      "Control operativo para guardias de seguridad. Diseñada para resistir turnos completos, registrar rondas y mantener la comunicación, incluso sin conexión a internet.",
    shots: [
      { src: "/assets/img/mockup-ilux.webp", alt: "Interfaz de ilux: inicio de turno", width: 453, height: 928 },
      { src: "/assets/img/mockup-ilux-2.webp", alt: "Interfaz de ilux: menú principal", width: 452, height: 928 },
      { src: "/assets/img/mockup-ilux-3.webp", alt: "Interfaz de ilux: ronda con código QR", width: 452, height: 928 },
    ],
  },
  {
    slug: "tuerca",
    badge: "En prueba cerrada",
    title: "Faro",
    division: "Tuerca",
    description:
      "Un lanzador de Android que reduce el ruido digital. Con recordatorios de calma y una pantalla de inicio enfocada en lo esencial, te ayuda a recuperar tu atención.",
    shots: [
      { src: "/assets/img/mockup-faro.webp", alt: "Interfaz de Faro: pantalla de hoy", width: 695, height: 1488 },
      { src: "/assets/img/mockup-faro-2.webp", alt: "Interfaz de Faro: pausa consciente", width: 695, height: 1488 },
      { src: "/assets/img/mockup-faro-3.webp", alt: "Interfaz de Faro: modo noche", width: 695, height: 1488 },
    ],
  },
  {
    slug: "chispa",
    badge: "En prueba cerrada",
    title: "Loto y Lito",
    division: "Chispa",
    description:
      "Cuentos para leer en familia, con arte original y un adulto presente. El avance se queda en el teléfono: sin anuncios y sin datos de menores.",
    shots: [
      { src: "/assets/img/mockup-chispa.webp", alt: "Interfaz de Loto y Lito: estantería de cuentos", width: 880, height: 1900 },
      { src: "/assets/img/mockup-chispa-2.webp", alt: "Interfaz de Loto y Lito: lectura de un cuento", width: 880, height: 1900 },
      { src: "/assets/img/mockup-chispa-3.webp", alt: "Interfaz de Loto y Lito: perfil de lectura", width: 880, height: 1900 },
    ],
  },
  {
    slug: "oficio",
    badge: "En prueba cerrada",
    title: "Relevo",
    division: "Oficio",
    description:
      "Organización de tareas y equipos de trabajo. Diseñada para funcionar sin conexión, con recordatorios locales y un enfoque en la claridad diaria. Menos ruido, más enfoque.",
    shots: [
      { src: "/assets/img/mockup-relevo-1.webp", alt: "Interfaz de Relevo: pantalla Hoy", width: 879, height: 1890 },
      { src: "/assets/img/mockup-relevo-2.webp", alt: "Interfaz de Relevo: pantalla Semana", width: 879, height: 1890 },
      { src: "/assets/img/mockup-relevo-3.webp", alt: "Interfaz de Relevo: día sin pendientes", width: 879, height: 1890 },
    ],
  },
] as const;

export const Route = createFileRoute("/")({
  head: () => ({
    meta: [
      { title: "Lito Labs · Software con propósito" },
      {
        name: "description",
        content:
          "Diseñamos aplicaciones Android en español que resuelven problemas reales, respetando tu tiempo y tu privacidad.",
      },
    ],
  }),
  component: Home,
});

function MockupCarousel({
  shots,
  name,
}: {
  shots: readonly { src: string; alt: string; width: number; height: number }[];
  name: string;
}) {
  const scroller = useRef<HTMLDivElement>(null);
  const [index, setIndex] = useState(0);
  const [broken, setBroken] = useState<ReadonlySet<string>>(new Set());

  function sync() {
    const el = scroller.current;
    if (!el || el.clientWidth === 0) return;
    const next = Math.round(el.scrollLeft / el.clientWidth);
    if (Number.isFinite(next)) setIndex(Math.max(0, Math.min(shots.length - 1, next)));
  }

  function go(next: number) {
    const el = scroller.current;
    if (!el || el.clientWidth === 0) return;
    const clamped = Math.max(0, Math.min(shots.length - 1, next));
    setIndex(clamped);
    el.scrollTo({ left: clamped * el.clientWidth, behavior: "smooth" });
  }

  return (
    <div className="min-w-0">
      <div ref={scroller} className="mockup-row" onScroll={sync} aria-label={`Pantallas de ${name}`}>
        {shots.map((shot) => (
          <div key={shot.src} className="mockup-slide">
            {broken.has(shot.src) ? (
              <p className="mockup-fallback">{shot.alt}</p>
            ) : (
              <img
                src={shot.src}
                alt={shot.alt}
                width={shot.width}
                height={shot.height}
                loading="lazy"
                decoding="async"
                onError={() =>
                  setBroken((current) => {
                    if (current.has(shot.src)) return current;
                    const next = new Set(current);
                    next.add(shot.src);
                    return next;
                  })
                }
              />
            )}
          </div>
        ))}
      </div>
      <div className="mt-1 flex items-center justify-center">
        <button
          type="button"
          className="inline-flex size-11 items-center justify-center text-ink disabled:opacity-30"
          aria-label={`Imagen anterior de ${name}`}
          disabled={index === 0}
          onClick={() => go(index - 1)}
        >
          <Chevron dir="left" />
        </button>
        {shots.map((shot, i) => (
          <button
            key={shot.src}
            type="button"
            className="inline-flex size-11 items-center justify-center"
            aria-label={`Imagen ${i + 1} de ${shots.length} de ${name}`}
            aria-current={i === index ? "true" : undefined}
            onClick={() => go(i)}
          >
            <span className={"block size-2 rounded-full " + (i === index ? "accent-fill" : "bg-dim")} />
          </button>
        ))}
        <button
          type="button"
          className="inline-flex size-11 items-center justify-center text-ink disabled:opacity-30"
          aria-label={`Siguiente imagen de ${name}`}
          disabled={index === shots.length - 1}
          onClick={() => go(index + 1)}
        >
          <Chevron dir="right" />
        </button>
      </div>
    </div>
  );
}

function Chevron({ dir }: { dir: "left" | "right" }) {
  return (
    <svg viewBox="0 0 16 16" className="size-4" fill="none" aria-hidden="true">
      <path
        d={dir === "left" ? "M10 3.5 5.5 8 10 12.5" : "M6 3.5 10.5 8 6 12.5"}
        stroke="currentColor"
        strokeWidth="1.6"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
}

function Home() {
  return (
    <Shell tone="ink">
      {/* Inicio */}
      <section className="on-ink bg-ink text-cream">
        <div className="mx-auto max-w-5xl px-5 pt-8 pb-16 md:px-8 md:pt-16 md:pb-24">
          <p className="text-sm font-medium tracking-widest text-dim uppercase">Lito Labs · Tepatitlán, Jalisco</p>
          <h1 className="mt-4 max-w-3xl text-4xl font-semibold leading-tight md:text-6xl">Software con propósito.</h1>
          <hr className="pink-rule mt-6" />
          <p className="mt-6 max-w-2xl text-lg text-dim">
            Diseñamos aplicaciones Android en español que resuelven problemas reales, respetando tu tiempo y tu
            privacidad.
          </p>
          <div className="mt-8 flex flex-col gap-3 sm:flex-row">
            <Link
              to="/divisiones"
              className="inline-flex min-h-12 items-center justify-center rounded-full bg-cream px-5 font-medium text-ink"
            >
              Ver las divisiones
            </Link>
            <Link
              to="/estado"
              className="inline-flex min-h-12 items-center justify-center rounded-full border border-dim px-5 font-medium text-cream"
            >
              Cómo van las apps
            </Link>
          </div>
        </div>
      </section>

      {/* Quiénes somos */}
      <section className="mx-auto max-w-5xl px-5 py-14 md:px-8 md:py-20">
        <h2 className="text-3xl font-semibold">Quiénes somos</h2>
        <hr className="pink-rule mt-4" />
        <div className="mt-6 max-w-3xl space-y-4 text-lg">
          <p>
            Lito Labs es un estudio independiente de software con base en Tepatitlán de Morelos, Jalisco. Nacimos con
            una convicción clara: la tecnología debe adaptarse a las personas, no al revés.
          </p>
          <p>
            Nuestra forma de diseñar está profundamente influenciada por la psicología y el estudio del comportamiento
            humano. Por eso, creamos aplicaciones en español que resuelven problemas reales sin cobrar con la atención
            ni con los datos de quien las usa.
          </p>
          <p>
            Una aplicación de Lito Labs se mide por si le hizo la vida más fácil a alguien, no por cuánto tiempo lo
            retuvo en la pantalla. Eso vale igual para ordenar el teléfono, gestionar el trabajo de un negocio, leer
            un cuento en familia o regularse en un momento difícil.
          </p>
        </div>
      </section>

      {/* Promesas */}
      <section className="border-t border-line">
        <div className="mx-auto max-w-5xl px-5 py-14 md:px-8 md:py-20">
          <h2 className="text-3xl font-semibold">Lo que te prometemos</h2>
          <hr className="pink-rule mt-4" />
          <ul className="mt-8 grid gap-4 md:grid-cols-2">
            {promises.map((item) => (
              <li key={item.title} className="rounded-2xl border border-line bg-paper p-5">
                <h3 className="text-lg font-semibold">{item.title}</h3>
                <p className="mt-2 text-muted">{item.body}</p>
              </li>
            ))}
          </ul>
        </div>
      </section>

      {/* Divisiones */}
      <section className="border-t border-line">
        <div className="mx-auto max-w-5xl px-5 py-14 md:px-8 md:py-20">
          <h2 className="text-3xl font-semibold">Seis divisiones, un mismo oficio</h2>
          <hr className="pink-rule mt-4" />
          <p className="mt-6 max-w-2xl text-lg text-muted">
            Seis líneas de trabajo, un mismo cuidado. Todas firman «de Lito Labs».
          </p>
          <ul className="mt-8 grid gap-4 md:grid-cols-2">
            {divisions.map((division) => (
              <li key={division.slug}>
                <Link
                  to="/divisiones/$slug"
                  params={{ slug: division.slug }}
                  data-division={division.slug}
                  className="division-card flex items-center gap-5 rounded-2xl bg-paper p-5"
                >
                  <DivisionMark slug={division.slug} />
                  <span className="min-w-0">
                    <span className="block text-xl font-semibold">{division.name}</span>
                    <span className="mt-1 block text-muted">{division.kicker}</span>
                  </span>
                </Link>
              </li>
            ))}
          </ul>
        </div>
      </section>

      {/* Trabajo en marcha */}
      <section className="border-t border-line">
        <div className="mx-auto max-w-5xl px-5 py-14 md:px-8 md:py-20">
          <h2 className="text-3xl font-semibold">Nuestro trabajo en marcha</h2>
          <hr className="pink-rule mt-4" />
          <p className="mt-6 max-w-2xl text-lg text-muted">
            Vistazo a nuestras apps. Creemos en mostrar el avance real. Estas son algunas de las herramientas que
            estamos puliendo, diseñadas bajo nuestros estándares de privacidad y calma.
          </p>
          <ul className="mt-8 grid grid-cols-1 gap-4 md:grid-cols-2">
            {showcase.map((app) => (
              <li key={app.title} data-division={app.slug} className="work-card flex min-w-0 flex-col p-5">
                <p className="accent-fill w-fit rounded-full px-3 py-1 text-sm font-medium text-ink">{app.badge}</p>
                <div className="my-4">
                  <MockupCarousel shots={app.shots} name={app.title} />
                </div>
                <h3 className="text-xl font-semibold text-ink">{app.title}</h3>
                <p className="accent-text mt-1 text-sm font-medium">{app.division}</p>
                <p className="mt-2 text-ink">{app.description}</p>
                <Link
                  to="/contacto"
                  hash="contacto"
                  className="accent-outline mt-5 inline-flex min-h-12 items-center self-start rounded-full border px-5 font-medium"
                >
                  Quiero ser probador
                </Link>
              </li>
            ))}
          </ul>
        </div>
      </section>

      {/* Sí y no */}
      <section className="border-t border-line">
        <div className="mx-auto grid max-w-5xl gap-4 px-5 py-14 md:grid-cols-2 md:px-8 md:py-20">
          <div className="rounded-2xl border border-line bg-paper p-6">
            <h2 className="text-2xl font-semibold">Sí hacemos</h2>
            <ul className="mt-4 space-y-3">
              {yesItems.map((item) => (
                <li key={item} className="border-l-4 border-pink pl-3">
                  {item}
                </li>
              ))}
            </ul>
          </div>
          <div className="rounded-2xl border border-line bg-paper p-6">
            <h2 className="text-2xl font-semibold">No hacemos</h2>
            <ul className="mt-4 space-y-3">
              {noItems.map((item) => (
                <li key={item} className="border-l-4 border-line pl-3 text-muted">
                  {item}
                </li>
              ))}
            </ul>
          </div>
        </div>
      </section>

      {/* Estado */}
      <section className="border-t border-line">
        <div className="mx-auto max-w-5xl px-5 py-14 md:px-8">
          <div className="rounded-2xl border border-line bg-paper p-6 md:p-8">
            <h2 className="text-2xl font-semibold">Desarrollo en marcha</h2>
            <p className="mt-3 max-w-3xl text-lg">
              Actualmente, ninguna de nuestras aplicaciones está publicada en Google Play. Casi todas ya funcionan y
              se encuentran en fase de prueba cerrada. Preferimos lanzar pocas apps, pero excepcionalmente bien
              pulidas y cuidadas.
            </p>
            <Link to="/estado" className="mt-6 inline-flex min-h-12 items-center font-medium underline decoration-pink underline-offset-4">
              Ver el estado de cada app
            </Link>
          </div>
        </div>
      </section>
    </Shell>
  );
}
