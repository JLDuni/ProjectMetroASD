import { useEffect, useState } from "react";

export default function App() {
  const [message, setMessage] = useState("Loading...");
  const [health, setHealth] = useState("unknown");
  const [clicks, setClicks] = useState(0);

  useEffect(() => {
    fetch("/api/hello")
      .then((r) => r.json())
      .then((d) => setMessage(d.message))
      .catch(() => setMessage("Backend unreachable"));

    fetch("/health")
      .then((r) => r.json())
      .then((d) => setHealth(d.status))
      .catch(() => setHealth("unreachable"));
  }, []);

  return (
    <div style={{ fontFamily: "sans-serif", padding: "2rem", maxWidth: 640 }}>
      <h1>MetroIsJustABus</h1>

      <div style={{ padding: "1rem", background: "#f0f0f0", borderRadius: 8 }}>
        <p><strong>Backend says:</strong> {message}</p>
        <p>
          <strong>Health:</strong>{" "}
          <span style={{ color: health === "ok" ? "green" : "red" }}>
            {health}
          </span>
        </p>
      </div>

      <hr style={{ margin: "1.5rem 0" }} />

      <h2>Prove React is alive</h2>
      <button
        onClick={() => setClicks((c) => c + 1)}
        style={{
          fontSize: "1rem",
          padding: "0.5rem 1rem",
          cursor: "pointer",
          borderRadius: 6,
          border: "1px solid #333",
          background: "#fff",
        }}
      >
        Click me
      </button>
      <p>
        Button clicked <strong>{clicks}</strong> time{clicks === 1 ? "" : "s"}
      </p>

      <p style={{ marginTop: "2rem", fontSize: "0.85rem", color: "#666" }}>
        Built at: {new Date(__BUILD_TIME__).toLocaleString()}
      </p>
    </div>
  );
}