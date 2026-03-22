export default function App() {
  const files = [
    { path: "pubspec.yaml",                  desc: "Configuração do projeto Flutter" },
    { path: "lib/main.dart",                 desc: "Entry point + Tela Galeria (todas as telas)" },
    { path: "lib/theme.dart",                desc: "Cores, gradientes e widgets utilitários" },
    { path: "lib/screens/login_screen.dart", desc: "Tela de Login" },
    { path: "lib/screens/register_screen.dart", desc: "Tela de Cadastro" },
    { path: "lib/screens/calendar_screen.dart", desc: "Calendário / Agendamento" },
    { path: "lib/screens/admin_screen.dart",    desc: "Painel do Barbeiro (Admin)" },
    { path: "lib/screens/payment_screen.dart",  desc: "Pagamento (PIX, Cartão, Débito)" },
    { path: "lib/screens/rating_screen.dart",   desc: "Avaliação do Atendimento" },
  ];

  const steps = [
    { num: "01", title: "Criar projeto Flutter", code: "flutter create barber_flow" },
    { num: "02", title: "Substituir arquivos",   code: "Copie os arquivos da pasta /public/flutter/" },
    { num: "03", title: "Instalar dependências", code: "flutter pub get" },
    { num: "04", title: "Executar o app",        code: "flutter run" },
  ];

  return (
    <div
      style={{
        minHeight: "100vh",
        background: "linear-gradient(135deg, #0a0a0a 0%, #1a1208 50%, #0a0a0a 100%)",
        fontFamily: "'Inter', 'Segoe UI', Arial, sans-serif",
        padding: "48px 24px",
        color: "#fff",
      }}
    >
      {/* Header */}
      <div style={{ textAlign: "center", marginBottom: 52 }}>
        <div style={{ display: "flex", alignItems: "center", justifyContent: "center", gap: 12, marginBottom: 12 }}>
          <div
            style={{
              width: 48,
              height: 48,
              borderRadius: 14,
              background: "linear-gradient(135deg, #C9A84C, #e8c96e)",
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              fontSize: 22,
              boxShadow: "0 6px 20px rgba(201,168,76,0.35)",
            }}
          >
            ✂
          </div>
          <h1 style={{ fontSize: 30, fontWeight: 800, color: "#C9A84C", margin: 0, letterSpacing: "-0.5px" }}>
            Barber Flow
          </h1>
        </div>
        <p style={{ color: "#888", fontSize: 14, margin: "0 0 6px" }}>
          Projeto completo em <strong style={{ color: "#54C5F8" }}>Flutter</strong> — pronto para usar
        </p>
        <div
          style={{
            display: "inline-flex",
            alignItems: "center",
            gap: 8,
            background: "#54C5F822",
            border: "1px solid #54C5F844",
            borderRadius: 20,
            padding: "4px 14px",
            fontSize: 12,
            color: "#54C5F8",
            fontWeight: 600,
          }}
        >
          🐦 Flutter · Dart · Material You · Dark Theme
        </div>
        <div style={{ width: 60, height: 2, background: "linear-gradient(90deg, transparent, #C9A84C, transparent)", margin: "16px auto 0" }} />
      </div>

      <div style={{ maxWidth: 860, margin: "0 auto" }}>

        {/* Como usar */}
        <div style={{ marginBottom: 40 }}>
          <h2 style={{ color: "#fff", fontSize: 16, fontWeight: 700, margin: "0 0 18px", display: "flex", alignItems: "center", gap: 8 }}>
            <span style={{ color: "#C9A84C" }}>⚡</span> Como usar
          </h2>
          <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fit, minmax(180px, 1fr))", gap: 12 }}>
            {steps.map((s, i) => (
              <div
                key={i}
                style={{
                  background: "#141414",
                  border: "1px solid #222",
                  borderRadius: 14,
                  padding: "16px",
                }}
              >
                <div
                  style={{
                    display: "inline-block",
                    background: "linear-gradient(135deg, #C9A84C, #e8c96e)",
                    color: "#0a0a0a",
                    fontSize: 10,
                    fontWeight: 700,
                    padding: "2px 10px",
                    borderRadius: 20,
                    marginBottom: 10,
                  }}
                >
                  {s.num}
                </div>
                <p style={{ color: "#ddd", fontSize: 12, fontWeight: 600, margin: "0 0 8px" }}>{s.title}</p>
                <code
                  style={{
                    display: "block",
                    background: "#0a0a0a",
                    border: "1px solid #2a2a2a",
                    borderRadius: 8,
                    padding: "8px 10px",
                    color: "#C9A84C",
                    fontSize: 11,
                    wordBreak: "break-all",
                    lineHeight: 1.5,
                  }}
                >
                  {s.code}
                </code>
              </div>
            ))}
          </div>
        </div>

        {/* Arquivos gerados */}
        <div style={{ marginBottom: 40 }}>
          <h2 style={{ color: "#fff", fontSize: 16, fontWeight: 700, margin: "0 0 18px", display: "flex", alignItems: "center", gap: 8 }}>
            <span style={{ color: "#C9A84C" }}>📁</span> Arquivos gerados
          </h2>
          <div
            style={{
              background: "#0e0e0e",
              border: "1px solid #1e1e1e",
              borderRadius: 16,
              overflow: "hidden",
            }}
          >
            <div style={{ background: "#141414", padding: "10px 16px", borderBottom: "1px solid #1e1e1e", display: "flex", alignItems: "center", gap: 8 }}>
              <div style={{ width: 10, height: 10, borderRadius: "50%", background: "#ff5f57" }} />
              <div style={{ width: 10, height: 10, borderRadius: "50%", background: "#ffbd2e" }} />
              <div style={{ width: 10, height: 10, borderRadius: "50%", background: "#28ca41" }} />
              <span style={{ marginLeft: 8, color: "#555", fontSize: 11 }}>/public/flutter/</span>
            </div>
            {files.map((f, i) => (
              <div
                key={i}
                style={{
                  display: "flex",
                  alignItems: "center",
                  gap: 12,
                  padding: "10px 16px",
                  borderBottom: i < files.length - 1 ? "1px solid #141414" : "none",
                  transition: "background .15s",
                }}
              >
                <span style={{ fontSize: 14 }}>
                  {f.path.endsWith(".yaml") ? "⚙" : f.path.includes("theme") ? "🎨" : f.path.includes("main") ? "🚀" : "📄"}
                </span>
                <div style={{ flex: 1 }}>
                  <code style={{ color: "#C9A84C", fontSize: 12 }}>{f.path}</code>
                  <p style={{ color: "#555", fontSize: 11, margin: "2px 0 0" }}>{f.desc}</p>
                </div>
                <span
                  style={{
                    background: "#1a1a1a",
                    border: "1px solid #2a2a2a",
                    borderRadius: 6,
                    padding: "2px 8px",
                    color: "#444",
                    fontSize: 10,
                    fontWeight: 600,
                  }}
                >
                  .dart
                </span>
              </div>
            ))}
          </div>
        </div>

        {/* Telas */}
        <div style={{ marginBottom: 40 }}>
          <h2 style={{ color: "#fff", fontSize: 16, fontWeight: 700, margin: "0 0 18px", display: "flex", alignItems: "center", gap: 8 }}>
            <span style={{ color: "#C9A84C" }}>📱</span> Telas implementadas
          </h2>
          <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fit, minmax(240px, 1fr))", gap: 10 }}>
            {[
              { icon: "🔐", label: "Login",        desc: "E-mail, senha, Google OAuth, link de cadastro" },
              { icon: "👤", label: "Cadastro",      desc: "5 campos, barra de progresso, aceite de termos" },
              { icon: "📅", label: "Agendamento",   desc: "Calendário interativo, barbeiro, horários" },
              { icon: "📊", label: "Painel Admin",  desc: "Stats, agenda do dia, ações rápidas, bottom nav" },
              { icon: "💳", label: "Pagamento",     desc: "PIX, crédito, débito, cupom, resumo do pedido" },
              { icon: "⭐", label: "Avaliação",     desc: "Estrelas, aspectos, tags, comentário livre" },
            ].map((screen, i) => (
              <div
                key={i}
                style={{
                  background: "#141414",
                  border: "1px solid #222",
                  borderRadius: 14,
                  padding: "14px",
                  display: "flex",
                  gap: 12,
                  alignItems: "flex-start",
                }}
              >
                <div
                  style={{
                    width: 42,
                    height: 42,
                    borderRadius: 12,
                    background: "rgba(201,168,76,0.08)",
                    border: "1px solid rgba(201,168,76,0.2)",
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                    fontSize: 20,
                    flexShrink: 0,
                  }}
                >
                  {screen.icon}
                </div>
                <div>
                  <p style={{ color: "#fff", fontSize: 13, fontWeight: 600, margin: "0 0 4px" }}>{screen.label}</p>
                  <p style={{ color: "#555", fontSize: 11, margin: 0, lineHeight: 1.5 }}>{screen.desc}</p>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Requisitos */}
        <div
          style={{
            background: "linear-gradient(135deg, #C9A84C10, #e8c96e06)",
            border: "1px solid #C9A84C33",
            borderRadius: 14,
            padding: "16px 20px",
            display: "flex",
            gap: 14,
            alignItems: "flex-start",
          }}
        >
          <span style={{ fontSize: 22, flexShrink: 0 }}>ℹ️</span>
          <div>
            <p style={{ color: "#C9A84C", fontSize: 13, fontWeight: 700, margin: "0 0 6px" }}>Requisitos</p>
            <ul style={{ color: "#888", fontSize: 12, margin: 0, padding: "0 0 0 16px", lineHeight: 2 }}>
              <li>Flutter SDK <strong style={{ color: "#ddd" }}>3.0+</strong></li>
              <li>Dart SDK <strong style={{ color: "#ddd" }}>3.0+</strong></li>
              <li>Android Studio / VS Code com extensão Flutter</li>
              <li>Emulador Android / iOS ou dispositivo físico</li>
            </ul>
          </div>
        </div>

        <div style={{ textAlign: "center", marginTop: 48, color: "#444", fontSize: 12 }}>
          Barber Flow App · Flutter · 2026
        </div>
      </div>
    </div>
  );
}
