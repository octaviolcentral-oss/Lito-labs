import { Link } from "@tanstack/react-router";
import { useState, type ReactNode } from "react";
import { nav } from "@/lib/content";
import { StudioLogo } from "@/components/mark";
import { MailLink } from "@/components/mail";

const linkClass =
  "inline-flex min-h-12 items-center rounded-full px-3 text-base font-medium";

export function SiteHeader({ tone = "cream" }: { tone?: "cream" | "ink" }) {
  const [open, setOpen] = useState(false);
  const onDark = tone === "ink";

  return (
    <header className={onDark ? "on-ink bg-ink text-cream" : "border-b border-line bg-cream"}>
      <div className="mx-auto flex max-w-5xl items-center justify-between gap-4 px-5 py-4 md:px-8">
        <Link to="/" aria-label="Lito Labs, inicio" className="rounded-full">
          <StudioLogo tone={onDark ? "cream" : "ink"} priority />
        </Link>
        <nav className="hidden items-center gap-1 md:flex" aria-label="Secciones">
          {nav.map((item) => (
            <Link
              key={item.to}
              to={item.to}
              activeOptions={{ exact: item.to === "/" }}
              className={linkClass + (onDark ? " text-cream" : " text-ink")}
              activeProps={{ className: "underline decoration-pink decoration-2 underline-offset-8" }}
            >
              {item.label}
            </Link>
          ))}
        </nav>
        <button
          type="button"
          className={
            "inline-flex size-12 items-center justify-center md:hidden " +
            (onDark ? "text-cream" : "text-ink")
          }
          aria-expanded={open}
          aria-controls="menu-movil"
          aria-label={open ? "Cerrar menú" : "Abrir menú"}
          onClick={() => setOpen((value) => !value)}
        >
          {open ? <CloseIcon /> : <MenuIcon />}
        </button>
      </div>
      {open ? (
        <nav id="menu-movil" className="border-t border-line px-5 py-3 md:hidden" aria-label="Secciones">
          {nav.map((item) => (
            <Link
              key={item.to}
              to={item.to}
              activeOptions={{ exact: item.to === "/" }}
              className={"flex min-h-12 items-center text-base font-medium " + (onDark ? "text-cream" : "text-ink")}
              activeProps={{ className: "underline decoration-pink decoration-2 underline-offset-4" }}
              onClick={() => setOpen(false)}
            >
              {item.label}
            </Link>
          ))}
        </nav>
      ) : null}
    </header>
  );
}

export function ColorBar() {
  const keys = ["brisia", "brujula", "chispa", "tuerca", "prisma", "oficio"] as const;
  return (
    <div className="flex h-1.5" aria-hidden="true">
      {keys.map((key) => (
        <span key={key} data-division={key} className="accent-fill h-full flex-1" />
      ))}
    </div>
  );
}

export function SiteFooter() {
  return (
    <footer className="on-ink mt-16 bg-ink text-cream">
      <div className="mx-auto flex max-w-5xl flex-col gap-8 px-5 py-12 md:flex-row md:items-center md:justify-between md:px-8">
        <StudioLogo tone="cream" />
        <div className="flex flex-col gap-3 md:items-end">
          <MailLink className="font-medium underline decoration-pink underline-offset-4" />
          <nav className="flex gap-5" aria-label="Pie de página">
            <Link to="/privacidad" className="inline-flex min-h-12 items-center font-medium">
              Privacidad
            </Link>
            <Link to="/contacto" hash="contacto" className="inline-flex min-h-12 items-center font-medium">
              Contacto
            </Link>
          </nav>
        </div>
      </div>
      <p className="px-5 pb-8 text-center text-sm text-dim md:px-8">
        © 2026 Lito Labs. Hecho con calma en Tepatitlán, Jalisco.
      </p>
      <ColorBar />
    </footer>
  );
}

function MenuIcon() {
  return (
    <svg viewBox="0 0 24 24" className="size-6" fill="none" aria-hidden="true">
      <path d="M4 7h16M4 12h16M4 17h16" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" />
    </svg>
  );
}

function CloseIcon() {
  return (
    <svg viewBox="0 0 24 24" className="size-6" fill="none" aria-hidden="true">
      <path d="M6 6l12 12M18 6 6 18" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" />
    </svg>
  );
}

export function PageIntro({
  eyebrow,
  title,
  lede,
}: {
  eyebrow: string;
  title: string;
  lede: string;
}) {
  return (
    <header className="border-b border-line">
      <div className="mx-auto max-w-5xl px-5 py-12 md:px-8 md:py-16">
        <p className="text-sm font-medium tracking-widest text-muted uppercase">{eyebrow}</p>
        <h1 className="mt-3 max-w-3xl text-4xl font-semibold leading-tight text-ink md:text-5xl">{title}</h1>
        <hr className="pink-rule mt-6" />
        <p className="mt-6 max-w-2xl text-lg text-muted">{lede}</p>
      </div>
    </header>
  );
}

export function CrisisNote() {
  return (
    <aside className="rounded-2xl border border-line bg-paper p-5 md:p-6">
      <h2 className="text-lg font-semibold">Si estás en crisis</h2>
      <p className="mt-2 text-muted">
        Estas apps no sustituyen la atención profesional. En México, la Línea de la Vida atiende las 24 horas en el{" "}
        <a className="font-medium text-ink underline decoration-pink underline-offset-4" href="tel:8009112000">
          800 911 2000
        </a>
        . En una emergencia, llama al{" "}
        <a className="font-medium text-ink underline decoration-pink underline-offset-4" href="tel:911">
          911
        </a>
        .
      </p>
    </aside>
  );
}

export function Shell({
  tone = "cream",
  children,
}: {
  tone?: "cream" | "ink";
  children: ReactNode;
}) {
  return (
    <div className="min-h-screen bg-cream text-ink">
      <a
        href="#main"
        className="sr-only focus:not-sr-only focus:absolute focus:top-4 focus:left-4 focus:z-50 focus:rounded-full focus:bg-ink focus:px-4 focus:py-3 focus:text-cream"
      >
        Saltar al contenido
      </a>
      <SiteHeader tone={tone} />
      <main id="main">{children}</main>
      <SiteFooter />
    </div>
  );
}
