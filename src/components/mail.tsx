import { useEffect, useState } from "react";

const USER = "hola";
const HOST = ["litolabs", "app"].join(".");

/** El correo se arma en el navegador para que no quede escrito de corrido en el HTML inicial. */
export function MailLink({ className }: { className?: string }) {
  const [address, setAddress] = useState("");

  useEffect(() => {
    setAddress(`${USER}@${HOST}`);
  }, []);

  if (!address) {
    return (
      <span className={className}>
        {USER}
        <span aria-hidden="true"> [at] </span>
        <span className="sr-only">@</span>
        {HOST}
      </span>
    );
  }

  return (
    <a className={className} href={`mailto:${address}`}>
      {address}
    </a>
  );
}
