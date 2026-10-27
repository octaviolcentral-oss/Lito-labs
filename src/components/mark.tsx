import type { ReactNode } from "react";

export function Axolotl({ className }: { className?: string }) {
  return (
    <svg viewBox="0 0 64 64" className={className} aria-hidden="true">
      <path
        fill="currentColor"
        d="M42 34c7 .4 14 6 13 14-.4 2.4-3.2 3-5.4 1.2-2.6-4.6-7-8.2-12.2-9.2 1.6-1.8 3.2-4 4.6-6z"
      />
      <ellipse cx="30" cy="42" rx="15" ry="10" fill="currentColor" />
      <ellipse cx="26" cy="33" rx="14" ry="12" fill="currentColor" />
      <ellipse cx="18" cy="51" rx="4.2" ry="2.1" fill="currentColor" />
      <ellipse cx="34" cy="51" rx="4.2" ry="2.1" fill="currentColor" />
      <path
        fill="var(--color-pink)"
        d="M16 24c-1.2-7 3.4-11 6.2-5.2-2.2.2-4.2 2.2-6.2 5.2z"
      />
      <path
        fill="var(--color-pink)"
        d="M24 18c.2-8 6.4-10.4 7.2-3.2-2.6-.2-5.2 1-7.2 3.2z"
      />
      <path
        fill="var(--color-pink)"
        d="M33 20c2.2-7.2 8.6-7.4 7.4-.6-2.6-.6-5.4 0-7.4.6z"
      />
      <circle cx="20" cy="33" r="2" fill="var(--color-cream)" />
      <circle cx="20.6" cy="33" r="0.9" fill="currentColor" />
      <path
        d="M16.5 39.5c2.2 2 5.6 2 7.6 0"
        fill="none"
        stroke="var(--color-cream)"
        strokeWidth="1.4"
        strokeLinecap="round"
      />
    </svg>
  );
}

export function StudioLogo({ tone = "ink" }: { tone?: "ink" | "cream" }) {
  const onDark = tone === "cream";
  return (
    <span
      className={
        "inline-flex items-center gap-2.5 " +
        (onDark ? "" : "rounded-2xl bg-ink py-1.5 pr-3 pl-1.5")
      }
    >
      <img
        src="/brand/ajolote.png"
        alt="Ajolote de Lito Labs"
        width={201}
        height={163}
        className="h-11 w-auto object-contain"
      />
      <span className="text-lg font-semibold tracking-tight text-cream">Lito Labs</span>
    </span>
  );
}

function Glyph({ children }: { children: ReactNode }) {
  return (
    <svg viewBox="0 0 32 32" className="size-9" fill="none" aria-hidden="true">
      {children}
    </svg>
  );
}

const stroke = {
  stroke: "currentColor",
  strokeWidth: 1.8,
  strokeLinecap: "round" as const,
  strokeLinejoin: "round" as const,
};

export function DivisionGlyph({ slug }: { slug: string }) {
  if (slug === "brisia") {
    return (
      <Glyph>
        <circle cx="16" cy="16" r="6" {...stroke} />
        <circle cx="16" cy="16" r="2" fill="currentColor" />
      </Glyph>
    );
  }
  if (slug === "brujula") {
    return (
      <Glyph>
        <path d="M7 12.5a6 5 0 0 1 12 0c0 3-2 4.2-4 5.2V20" {...stroke} />
        <circle cx="15" cy="23" r="1" fill="currentColor" />
        <path d="M18 11h6.5a4 3.4 0 0 1 0 6.8H20" {...stroke} />
      </Glyph>
    );
  }
  if (slug === "chispa") {
    return (
      <Glyph>
        <path d="M13 8.5v15l11-7.5-11-7.5z" {...stroke} />
      </Glyph>
    );
  }
  if (slug === "tuerca") {
    return (
      <Glyph>
        <path d="M6 12h14" {...stroke} />
        <circle cx="22" cy="12" r="2.2" {...stroke} />
        <path d="M26 20H12" {...stroke} />
        <circle cx="10" cy="20" r="2.2" {...stroke} />
      </Glyph>
    );
  }
  if (slug === "prisma") {
    return (
      <Glyph>
        <rect x="6" y="8" width="20" height="16" rx="2" {...stroke} />
        <path d="M6 20l5.5-5 4 3.5 3-2.5 7.5 6" {...stroke} />
        <circle cx="12" cy="13" r="1.4" fill="currentColor" />
      </Glyph>
    );
  }
  return (
    <Glyph>
      <rect x="6" y="12" width="20" height="12" rx="2" {...stroke} />
      <path d="M12 12V10a4 4 0 0 1 8 0v2" {...stroke} />
    </Glyph>
  );
}

export function AppGlyph({ name }: { name: string }) {
  if (name === "Ancla") {
    return (
      <Glyph>
        <circle cx="16" cy="8" r="2" {...stroke} />
        <path d="M16 10v8" {...stroke} />
        <path d="M10 16h12" {...stroke} />
        <path d="M12 16c0 6 2.2 9 4 9s4-3 4-9" {...stroke} />
      </Glyph>
    );
  }
  if (name === "MeltdownReset") {
    return (
      <Glyph>
        <path d="M8 18c2-6 6-8 8-8s6 2 8 8" {...stroke} />
        <path d="M10 22c1.6-4 3.4-5 6-5s4.4 1 6 5" {...stroke} />
      </Glyph>
    );
  }
  if (name === "SensoryMap") {
    return (
      <Glyph>
        <path d="M16 26s-7-6.2-7-11a7 7 0 0 1 14 0c0 4.8-7 11-7 11z" {...stroke} />
        <circle cx="16" cy="15" r="2" {...stroke} />
      </Glyph>
    );
  }
  if (name === "Trato") {
    return (
      <Glyph>
        <circle cx="12" cy="12" r="3" {...stroke} />
        <circle cx="21" cy="13" r="2.4" {...stroke} />
        <path d="M6 23c1-4 3.2-5.5 6-5.5s5 1.5 6 5.5" {...stroke} />
        <path d="M18 23c.6-2.6 2-3.8 4-3.8 1.6 0 2.8.8 3.6 2.4" {...stroke} />
      </Glyph>
    );
  }
  if (name === "Raíz") {
    return (
      <Glyph>
        <path d="M16 6v10" {...stroke} />
        <path d="M16 12c-4 1-6 4-7 8" {...stroke} />
        <path d="M16 14c4 1 7 4 8 8" {...stroke} />
        <path d="M16 18c-2 3-2 6-1 8M16 18c2 3 2.4 6 1.4 8" {...stroke} />
      </Glyph>
    );
  }
  if (name === "Loto y Lito Aventura") {
    return (
      <Glyph>
        <path d="M8 24V10c4 2 6 2 8 0 2 2 4 2 8 0v14c-4 2-6 2-8 0-2 2-4 2-8 0z" {...stroke} />
      </Glyph>
    );
  }
  if (name === "Ajolote Fighters") {
    return (
      <Glyph>
        <circle cx="16" cy="16" r="5" {...stroke} />
        <path d="M12 10c0-3 2-5 4-4M16 9c1-4 4-5 5-2M19 12c3-1 6 0 6 2" {...stroke} />
      </Glyph>
    );
  }
  if (name === "Claro") {
    return (
      <Glyph>
        <path d="M9 20h14" {...stroke} />
        <path d="M11 20l1.5-8h7L21 20" {...stroke} />
        <path d="M13 12V9h6v3" {...stroke} />
      </Glyph>
    );
  }
  if (name === "Halo") {
    return (
      <Glyph>
        <circle cx="16" cy="18" r="5" {...stroke} />
        <path d="M10 10c1.6-2 3.6-3 6-3s4.4 1 6 3" {...stroke} />
      </Glyph>
    );
  }
  if (name === "Faro") {
    return (
      <Glyph>
        <path d="M16 6v3" {...stroke} />
        <path d="M12 12h8l2 4H10l2-4z" {...stroke} />
        <path d="M13 16v8h6v-8" {...stroke} />
        <path d="M10 24h12" {...stroke} />
      </Glyph>
    );
  }
  if (name === "Morralla") {
    return (
      <Glyph>
        <ellipse cx="16" cy="16" rx="8" ry="8" {...stroke} />
        <path d="M16 12v8M13.5 14.2h4.2a2 2 0 0 1 0 4H14" {...stroke} />
      </Glyph>
    );
  }
  if (name === "Nítida") {
    return (
      <Glyph>
        <circle cx="16" cy="16" r="4" {...stroke} />
        <circle cx="16" cy="16" r="8" {...stroke} />
      </Glyph>
    );
  }
  if (name === "Linde") {
    return (
      <Glyph>
        <path d="M11 24V8h8" {...stroke} />
        <circle cx="22" cy="11" r="3" {...stroke} />
        <path d="M22 8v1.2" {...stroke} />
      </Glyph>
    );
  }
  if (name === "Butaca") {
    return (
      <Glyph>
        <path d="M9 14h14v6a4 4 0 0 1-4 4H13a4 4 0 0 1-4-4v-6z" {...stroke} />
        <path d="M9 16V12a3 3 0 0 1 3-3h8" {...stroke} />
      </Glyph>
    );
  }
  if (name === "ilux") {
    return (
      <Glyph>
        <path d="M6 20h20" {...stroke} />
        <path d="M8 20l6-8 4 4 3-3 5 7" {...stroke} />
        <circle cx="22" cy="10" r="2" {...stroke} />
      </Glyph>
    );
  }
  if (name === "Tlali") {
    return (
      <Glyph>
        <path d="M16 24V14" {...stroke} />
        <path d="M16 16c-2-4-6-5-8-3 3 0 5 2 8 3z" {...stroke} />
        <path d="M16 14c2-5 7-6 9-3-3 0-6 2-9 3z" {...stroke} />
        <path d="M16 20c-3-2-6-2-8 0" {...stroke} />
      </Glyph>
    );
  }
  return (
    <Glyph>
      <path d="M8 20h16M10 20V12h12v8" {...stroke} />
      <path d="M13 12V9h6v3" {...stroke} />
    </Glyph>
  );
}

const divisionName: Record<string, string> = {
  brisia: "Brisia",
  brujula: "Brújula",
  chispa: "Chispa",
  tuerca: "Tuerca",
  prisma: "Prisma",
  oficio: "Oficio",
};

export function DivisionMark({ slug }: { slug: string }) {
  const name = divisionName[slug] ?? slug;
  return (
    <img
      src={`/brand/division-${slug}.png`}
      alt={`Marca de la división ${name}`}
      width={306}
      height={slug === "brisia" ? 281 : 288}
      className="h-28 w-auto shrink-0 object-contain"
    />
  );
}

export function AppMark({ division, name }: { division: string; name: string }) {
  if (name === "Faro") {
    return (
      <img
        src="/brand/app-faro.png"
        alt="Marca de la app Faro"
        width={666}
        height={666}
        className="size-16 shrink-0 object-contain"
      />
    );
  }
  return (
    <span
      data-division={division}
      className="slab relative grid size-16 shrink-0 place-items-center bg-ink text-cream"
      aria-hidden="true"
    >
      <AppGlyph name={name} />
      <span className="accent-fill absolute right-1.5 bottom-1.5 size-1.5 rounded-full" />
    </span>
  );
}
