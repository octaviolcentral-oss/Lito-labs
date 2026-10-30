export type AppStatus = "prueba" | "desarrollo" | "maqueta" | "pausa";

export type AppItem = {
  name: string;
  summary: string;
  status: AppStatus;
  featured?: boolean;
};

export type Division = {
  slug: string;
  name: string;
  kicker: string;
  purpose: string;
  audience: string;
  promises: string[];
  apps: AppItem[];
  caution?: string;
};

export const statusLabel: Record<AppStatus, string> = {
  prueba: "Prueba cerrada",
  desarrollo: "En desarrollo",
  maqueta: "Maqueta",
  pausa: "Próximamente",
};

export const divisions: Division[] = [
  {
    slug: "brisia",
    name: "Brisia",
    kicker: "Bienestar y regulación emocional",
    purpose:
      "Herramientas para bajar la intensidad y regularse en un momento difícil: sencillas, privadas y sin presión.",
    audience:
      "Adultos que buscan calmarse, incluidas personas autistas o neurodivergentes con sobrecarga sensorial.",
    promises: [
      "Una acción grande por pantalla cuando el momento es difícil.",
      "Sin sonidos, destellos ni vibración fuerte por defecto.",
      "Textos amables, sin rachas y sin culpa.",
      "Funcionan sin conexión. Los datos se quedan en el teléfono: se exportan o se borran con un toque.",
      "Nunca llevan anuncios.",
    ],
    caution:
      "No diagnostican ni sustituyen la terapia. Son un apoyo, no un tratamiento. Si hay una crisis, la app muestra la Línea de la Vida (800 911 2000) y el 911.",
    apps: [
      {
        name: "Ancla",
        summary: "Acciones concretas para sostenerte cuando la intensidad sube.",
        status: "prueba",
      },
      {
        name: "MeltdownReset",
        summary: "Respiración guiada, lenta, para volver a tu ritmo.",
        status: "prueba",
      },
      {
        name: "SensoryMap",
        summary: "Un mapa de lugares según cómo se sienten: luz, ruido, gente.",
        status: "prueba",
      },
    ],
  },
  {
    slug: "brujula",
    name: "Brújula",
    kicker: "Práctica clínica y estudio de psicología",
    purpose:
      "Apoyo para la práctica clínica guiada y el estudio de psicología, con contenido riguroso y fuentes a la vista.",
    audience:
      "Psicólogos, estudiantes y adultos que practican con la guía de su terapeuta.",
    promises: [
      "Cada afirmación lleva su fuente. Nada de afirmaciones sueltas.",
      "No diagnostican ni etiquetan a la persona. No reemplazan la terapia.",
      "Sin datos de pacientes reales: ejemplos ficticios o anónimos.",
      "Si hay voz, se procesa en el teléfono.",
      "Nunca llevan anuncios.",
    ],
    caution:
      "Son material formativo o de práctica guiada, no un tratamiento. En temas sensibles, la app ofrece la Línea de la Vida (800 911 2000) y el 911.",
    apps: [
      {
        name: "Trato",
        summary:
          "Práctica de habilidades sociales, con retroalimentación neutral. Pensada para usarse junto con un terapeuta.",
        status: "prueba",
      },
      {
        name: "Raíz",
        summary: "Lecturas de análisis funcional. Cada texto muestra autor y año.",
        status: "prueba",
      },
    ],
  },
  {
    slug: "chispa",
    name: "Chispa",
    kicker: "Cuentos y juegos en familia",
    purpose:
      "Cuentos y juegos para disfrutar en familia, con arte original y raíces de Tepatitlán. Siempre con un adulto presente.",
    audience: "Niñas y niños con un adulto presente. La familia lee y juega junta.",
    promises: [
      "Pensadas para usarse con un adulto.",
      "Sin anuncios, sin compras escondidas y sin recolectar datos de menores.",
      "Arte original. Silencio a un toque.",
      "Botones grandes y letra clara.",
    ],
    apps: [
      {
        name: "Loto y Lito",
        summary:
          "Veinticuatro cuentos para leer juntos, con tiempo de lectura a la vista. Es la app más avanzada del estudio.",
        status: "prueba",
        featured: true,
      },
      {
        name: "Ajolote Fighters",
        summary: "Un juego de pelea con ajolotes. Sigue en desarrollo.",
        status: "desarrollo",
      },
    ],
  },
  {
    slug: "tuerca",
    name: "Tuerca",
    kicker: "Herramientas útiles para el teléfono",
    purpose:
      "Herramientas que hacen una sola cosa, y la hacen bien: un teléfono más limpio, ordenado y tranquilo.",
    audience:
      "Cualquier persona con un teléfono Android, también quien tiene poca experiencia.",
    promises: [
      "Antes de borrar, bloquear o mover, muestran cuánto y qué va a pasar.",
      "Nada se borra ni se bloquea sin una confirmación clara. Hay papelera o deshacer.",
      "Cada permiso delicado se explica en palabras simples. Si lo niegas, la app sigue.",
      "Lo que hacen se queda en el teléfono.",
    ],
    apps: [
      {
        name: "Claro",
        summary: "Libera espacio y te dice cuánto soltaste, con papelera antes de borrar de verdad.",
        status: "prueba",
      },
      {
        name: "Halo",
        summary:
          "Baja el ruido de anuncios en el teléfono. Te explica el permiso que necesita antes de pedirlo.",
        status: "prueba",
      },
      {
        name: "Faro",
        summary: "Una pantalla de inicio sencilla, sin cajones escondidos.",
        status: "prueba",
      },
      {
        name: "Morralla",
        summary:
          "Práctica de microinversión en modo simulación. No mueve dinero de verdad.",
        status: "prueba",
      },
    ],
  },
  {
    slug: "prisma",
    name: "Prisma",
    kicker: "Fotos y video, en orden y en privado",
    purpose:
      "Que las fotos y los videos estén en orden, y que lo privado se quede protegido dentro del teléfono.",
    audience: "Personas con galerías grandes que quieren orden, calma y privacidad.",
    promises: [
      "Todo se procesa en el teléfono. Las fotos privadas no salen de él.",
      "Hay papelera antes de borrar para siempre.",
      "Lo privado no se anuncia en la pantalla de inicio.",
      "Si un proceso es largo, muestra un avance real.",
    ],
    apps: [
      {
        name: "Nítida",
        summary: "Una galería tranquila, con papelera de 30 días.",
        status: "prueba",
      },
      {
        name: "Linde",
        summary:
          "Aparta en una carpeta privada, cifrada, lo que no quieres ver en la galería. Sigue en desarrollo.",
        status: "desarrollo",
      },
      {
        name: "Butaca",
        summary: "Un reproductor de video que usa los archivos que ya están en el teléfono.",
        status: "prueba",
      },
    ],
  },
  {
    slug: "oficio",
    name: "Oficio",
    kicker: "Herramientas de trabajo para negocios en México",
    purpose:
      "Herramientas de trabajo para pequeños negocios y empresas de México, usables desde el primer día. Nuestra app estrella, ilux, ofrece gestión para guardias de seguridad mediante una suscripción mensual honesta: pagas por un servicio que se mantiene, actualiza y da soporte continuo.",
    audience:
      "Guardias, supervisores, cuadrillas de campo y quien atiende un mostrador.",
    promises: [
      "Textos claros y botones que se alcanzan con una mano.",
      "Lo que todavía no existe dice «Próximamente». No vendemos funciones que no están.",
      "Si hay suscripción, se explica antes: qué incluye, qué cuesta y que cubre mantenimiento, actualizaciones y soporte.",
      "Cada producto puede llevar su propia marca, y firma de Lito Labs.",
    ],
    apps: [
      {
        name: "ilux",
        summary:
          "Gestión para guardias de seguridad, con suscripción mensual clara. El pago cubre mantenimiento, actualizaciones y soporte. Hoy sigue en desarrollo y aún no está publicada.",
        status: "desarrollo",
      },
      {
        name: "Tlali",
        summary:
          "Para cuadrillas que cuentan agave. Hoy es una maqueta: todavía no es una app para instalar.",
        status: "maqueta",
      },
      {
        name: "Relevo",
        summary:
          "Organización de tareas y equipos. Funciona sin conexión, con recordatorios locales. Está en prueba cerrada y aún no está publicada.",
        status: "prueba",
      },
    ],
  },
];

export function getDivision(slug: string) {
  return divisions.find((division) => division.slug === slug);
}

export const promises = [
  {
    title: "Privacidad",
    body: "Privacidad por defecto. Tus datos se quedan en tu dispositivo. Sin rastreo invasivo ni cuentas obligatorias.",
  },
  {
    title: "Calma",
    body: "Diseño para la calma. Interfaces libres de adicción, scroll infinito o notificaciones manipuladoras.",
  },
  {
    title: "Honestidad",
    body: "Transparencia radical. Explicamos qué hace cada app, qué datos usa y cómo se financia, sin letras chiquitas.",
  },
  {
    title: "Accesibilidad",
    body: "Accesibilidad real. Diseñadas para funcionar sin internet y adaptadas para personas neurodivergentes o con baja alfabetización digital.",
  },
  {
    title: "Precios claros",
    body: "Modelos de negocio justos. Pago único para herramientas personales, y suscripciones transparentes para software empresarial (como ilux), sin cobros ocultos.",
  },
] as const;

export const yesItems = [
  "Aplicaciones Android en español que resuelven un problema real.",
  "Herramientas personales de pago único, sin cobros escondidos.",
  "Software de trabajo con suscripción clara, como ilux.",
  "Cuentos y juegos para la familia, con un adulto presente.",
  "Bienestar y formación, sin sustituir la atención profesional.",
];

export const noItems = [
  "Productos que compiten por tu atención o buscan engancharte.",
  "Rastreo invasivo, venta de datos o cuentas obligatorias.",
  "Copias de apps masivas en categorías ya saturadas.",
  "Promesas, precios o funciones que no están explicados.",
  "Lanzar más de lo que podemos cuidar.",
];

export const nav = [
  { to: "/", label: "Inicio" },
  { to: "/divisiones", label: "Divisiones" },
  { to: "/estado", label: "Estado" },
  { to: "/aliados", label: "Aliados" },
  { to: "/contacto", label: "Contacto" },
] as const;

/** Apps que se muestran en la portada y en el formulario de probadores. */
export const featuredApps = [
  { name: "ilux", division: "Oficio", slug: "oficio" },
  { name: "Faro", division: "Tuerca", slug: "tuerca" },
  { name: "Loto y Lito", division: "Chispa", slug: "chispa" },
  { name: "Relevo", division: "Oficio", slug: "oficio" },
] as const;
