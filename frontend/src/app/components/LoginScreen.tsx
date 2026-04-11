export function LoginScreen() {
  return (
    <div
      style={{
        height: "100%",
        background: "linear-gradient(180deg, #0D0D0D 0%, #141008 100%)",
        display: "flex",
        flexDirection: "column",
        padding: "0 24px",
        overflowY: "auto",
      }}
    >
      {/* Logo Area */}
      <div style={{ textAlign: "center", paddingTop: 40, paddingBottom: 32 }}>
        <div
          style={{
            width: 72,
            height: 72,
            borderRadius: 22,
            background: "linear-gradient(135deg, #C9A84C, #e8c96e)",
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            margin: "0 auto 16px",
            boxShadow: "0 8px 24px rgba(201,168,76,0.35)",
            fontSize: 32,
          }}
        >
          ✂
        </div>
        <h2 style={{ color: "#fff", fontSize: 22, fontWeight: 700, margin: "0 0 4px" }}>
          Barber Flow
        </h2>
        <p style={{ color: "#888", fontSize: 12, margin: 0 }}>
          Seu estilo, nossa arte
        </p>
      </div>

      {/* Title */}
      <div style={{ marginBottom: 24 }}>
        <h3 style={{ color: "#fff", fontSize: 18, fontWeight: 700, margin: "0 0 4px" }}>
          Bem-vindo de volta 👋
        </h3>
        <p style={{ color: "#666", fontSize: 12, margin: 0 }}>
          Faça login para continuar
        </p>
      </div>

      {/* Form */}
      <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
        <div>
          <label style={{ color: "#aaa", fontSize: 11, fontWeight: 600, letterSpacing: 0.5, display: "block", marginBottom: 6 }}>
            E-MAIL
          </label>
          <div
            style={{
              background: "#1a1a1a",
              border: "1px solid #2a2a2a",
              borderRadius: 12,
              padding: "12px 14px",
              display: "flex",
              alignItems: "center",
              gap: 10,
            }}
          >
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#666" strokeWidth="2">
              <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z" />
              <polyline points="22,6 12,13 2,6" />
            </svg>
            <span style={{ color: "#444", fontSize: 13 }}>seuemail@gmail.com</span>
          </div>
        </div>

        <div>
          <label style={{ color: "#aaa", fontSize: 11, fontWeight: 600, letterSpacing: 0.5, display: "block", marginBottom: 6 }}>
            SENHA
          </label>
          <div
            style={{
              background: "#1a1a1a",
              border: "1px solid #C9A84C55",
              borderRadius: 12,
              padding: "12px 14px",
              display: "flex",
              alignItems: "center",
              gap: 10,
            }}
          >
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#C9A84C" strokeWidth="2">
              <rect x="3" y="11" width="18" height="11" rx="2" ry="2" />
              <path d="M7 11V7a5 5 0 0110 0v4" />
            </svg>
            <span style={{ color: "#444", fontSize: 13 }}>••••••••</span>
            <div style={{ marginLeft: "auto" }}>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#555" strokeWidth="2">
                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z" />
                <circle cx="12" cy="12" r="3" />
              </svg>
            </div>
          </div>
        </div>

        <div style={{ textAlign: "right" }}>
          <span style={{ color: "#C9A84C", fontSize: 12, fontWeight: 600 }}>
            Esqueci minha senha
          </span>
        </div>

        {/* Login Button */}
        <div
          style={{
            background: "linear-gradient(135deg, #C9A84C, #e8c96e)",
            borderRadius: 14,
            padding: "14px",
            textAlign: "center",
            color: "#0a0a0a",
            fontWeight: 700,
            fontSize: 14,
            marginTop: 4,
            boxShadow: "0 6px 20px rgba(201,168,76,0.4)",
          }}
        >
          Entrar
        </div>

        {/* Divider */}
        <div style={{ display: "flex", alignItems: "center", gap: 10, margin: "4px 0" }}>
          <div style={{ flex: 1, height: 1, background: "#222" }} />
          <span style={{ color: "#555", fontSize: 11 }}>ou continue com</span>
          <div style={{ flex: 1, height: 1, background: "#222" }} />
        </div>

        {/* Google Button */}
        <div
          style={{
            background: "#1a1a1a",
            border: "1px solid #2a2a2a",
            borderRadius: 14,
            padding: "12px",
            textAlign: "center",
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            gap: 10,
          }}
        >
          <div style={{ width: 18, height: 18, borderRadius: "50%", background: "linear-gradient(135deg, #ea4335, #fbbc04, #34a853, #4285f4)", flexShrink: 0 }} />
          <span style={{ color: "#ccc", fontSize: 13, fontWeight: 600 }}>Google</span>
        </div>
      </div>

      {/* Footer */}
      <div style={{ textAlign: "center", marginTop: "auto", paddingBottom: 24, paddingTop: 20 }}>
        <span style={{ color: "#666", fontSize: 12 }}>Não tem uma conta? </span>
        <span style={{ color: "#C9A84C", fontSize: 12, fontWeight: 700 }}>Cadastre-se</span>
      </div>
    </div>
  );
}