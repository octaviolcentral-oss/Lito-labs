import { createFileRoute, notFound } from "@tanstack/react-router";

export const Route = createFileRoute("/$")({
  beforeLoad: () => {
    throw notFound();
  },
  head: () => ({
    meta: [
      { title: "Página no encontrada · Lito Labs" },
      { name: "robots", content: "noindex" },
    ],
  }),
});
