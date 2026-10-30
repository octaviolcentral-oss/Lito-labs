import { createRootRoute, HeadContent, Outlet, Scripts, Link } from "@tanstack/react-router";
import { AuthProvider } from "@/lib/auth/provider";
import { PreviewHostBridge } from "@/components/preview-host-bridge";
import { StudioLogo } from "@/components/mark";
import appCss from "../styles.css?url";

export const Route = createRootRoute({
  head: () => ({
    meta: [
      { charSet: "utf-8" },
      { name: "viewport", content: "width=device-width, initial-scale=1" },
      { title: "Lito Labs · Software con propósito" },
      {
        name: "description",
        content:
          "Diseñamos aplicaciones Android en español que resuelven problemas reales, respetando tu tiempo y tu privacidad.",
      },
      { property: "og:title", content: "Lito Labs · Software con propósito" },
      {
        property: "og:description",
        content:
          "Diseñamos aplicaciones Android en español que resuelven problemas reales, respetando tu tiempo y tu privacidad.",
      },
      { property: "og:type", content: "website" },
      { property: "og:image", content: "https://www.litolabs.app/og.jpg" },
      { property: "og:url", content: "https://www.litolabs.app/" },
      { name: "theme-color", content: "#33383E" },
    ],
    links: [
      { rel: "canonical", href: "https://www.litolabs.app/" },
      { rel: "icon", type: "image/png", href: "/favicon.png" },
      { rel: "stylesheet", href: appCss },
      { rel: "manifest", href: "/__grok/manifest.webmanifest" },
      { rel: "apple-touch-icon", href: "/__grok/icon-180.png" },
    ],
  }),
  component: Root,
  notFoundComponent: NotFound,
});

function Root() {
  return (
    <html lang="es" className="antialiased" suppressHydrationWarning>
      <head>
        <HeadContent />
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{
            __html: JSON.stringify({
              "@context": "https://schema.org",
              "@type": "Organization",
              name: "Lito Labs",
              url: "https://www.litolabs.app/",
              email: "hola@litolabs.app",
              logo: "https://www.litolabs.app/brand/ajolote.png",
              address: {
                "@type": "PostalAddress",
                addressLocality: "Tepatitlán de Morelos",
                addressRegion: "Jalisco",
                addressCountry: "MX",
              },
            }),
          }}
        />
      </head>
      <body>
        <PreviewHostBridge />
        <AuthProvider>
          <Outlet />
        </AuthProvider>
        <Scripts />
      </body>
    </html>
  );
}

function NotFound() {
  return (
    <main className="mx-auto flex min-h-screen max-w-xl flex-col items-start justify-center bg-cream px-6 py-16 text-ink">
      <StudioLogo />
      <h1 className="mt-8 text-4xl font-semibold">Página no encontrada</h1>
      <hr className="pink-rule mt-5" />
      <p className="mt-5 text-lg text-muted">
        Parece que este enlace no existe o se ha movido. Regresemos a la calma.
      </p>
      <Link
        to="/"
        className="mt-8 inline-flex min-h-12 items-center self-start rounded-full bg-ink px-5 font-medium text-cream"
      >
        Volver al inicio
      </Link>
    </main>
  );
}
