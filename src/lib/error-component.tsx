import type { ErrorComponentProps } from "@tanstack/react-router";

const FALLBACK_MESSAGE = "Ocurrió un error inesperado. Recarga la página.";

function errorMessage(error: unknown): string {
  if (error instanceof Error && error.message) return error.message;
  if (typeof error === "string" && error) return error;
  return FALLBACK_MESSAGE;
}

export function AppErrorComponent({ error }: ErrorComponentProps) {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center gap-3 bg-cream px-6 text-center text-ink">
      <h1 className="text-2xl font-semibold">Algo salió mal</h1>
      <p className="max-w-md text-base break-words text-muted">{errorMessage(error)}</p>
    </main>
  );
}
