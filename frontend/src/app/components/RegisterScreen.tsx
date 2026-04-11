export function RegisterScreen() {
  const fields = [
    { label: "NOME COMPLETO", icon: "👤", placeholder: "João da Silva", active: false },
    { label: "E-MAIL", icon: "✉", placeholder: "joao@gmail.com", active: true },
    { label: "TELEFONE", icon: "📱", placeholder: "(11) 99999-9999", active: false },
    { label: "SENHA", icon: "🔒", placeholder: "••••••••", active: false },
    { label: "CONFIRMAR SENHA", icon: "🔒", placeholder: "••••••••", active: false },
  ];

  return (
    <div
      style={{
        height: "100%",
        background: "#0D0D0D",
        display: "flex",
        flexDirection: "column",
        overflowY: "auto",
      }}
    >
      {/* Top bar */}
      <div
        style={{
          padding: "16px 20px 0",
          display: "flex",
          alignItems: "center",
          gap: 12,
        }}
      >
        <div
          style={{
            width: 34,
            height: 34,
            borderRadius: 10,
            background: "#1a1a1a",
            border: "1px solid #2a2a2a",
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
          }}
        >
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#aaa" strokeWidth="2.5">
            <polyline points="15 18 9 12 15 6" />
          </svg>
        </div>
        <span style={{ color: "#aaa", fontSize: 13, fontWeight: 600 }}>Voltar</span>
      </div>

      <div style={{ padding: "20px 24px 0" }}>
        {/* Logo small */}
        <div style={{ display: "flex", alignItems: "center", gap: 8, marginBottom: 18 }}>
          <div
            style={{
              width: 36,
              height: 36,
              borderRadius: 10,
              background: "linear-gradient(135deg, #C9A84C, #e8c96e)",
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              fontSize: 16,
              boxShadow: "0 4px 12px rgba(201,168,76,0.3)",
            }}
          >
            ✂
          </div>
          <div>
            <p style={{ color: "#fff", fontSize: 16, fontWeight: 700, margin: 0 }}>Criar conta</p>
            <p style={{ color: "#666", fontSize: 11, margin: 0 }}>Preencha seus dados abaixo</p>
          </div>
        </div>

        {/* Progress */}
        <div style={{ display: "flex", gap: 4, marginBottom: 22 }}>
          {[1, 2, 3].map((step, i) => (
            <div
              key={i}
              style={{
                flex: 1,
                height: 4,
                borderRadius: 4,
                background: i === 0 ? "linear-gradient(90deg, #C9A84C, #e8c96e)" : "#222",
              }}
            />
          ))}
        </div>

        {/* Form Fields */}
        <div style={{ display: "flex", flexDirection: "column", gap: 10 }}>
          {fields.map((field, i) => (
            <div key={i}>
              <label style={{ color: "#888", fontSize: 10, fontWeight: 600, letterSpacing: 0.8, display: "block", marginBottom: 5 }}>
                {field.label}
              </label>
              <div
                style={{
                  background: "#171717",
                  border: `1px solid ${field.active ? "#C9A84C55" : "#222"}`,
                  borderRadius: 11,
                  padding: "10px 13px",
                  display: "flex",
                  alignItems: "center",
                  gap: 9,
                }}
              >
                <span style={{ fontSize: 13 }}>{field.icon}</span>
                <span style={{ color: field.active ? "#C9A84C88" : "#333", fontSize: 12 }}>
                  {field.placeholder}
                </span>
              </div>
            </div>
          ))}
        </div>

        {/* Terms */}
        <div style={{ display: "flex", alignItems: "flex-start", gap: 9, marginTop: 14 }}>
          <div
            style={{
              width: 16,
              height: 16,
              borderRadius: 5,
              background: "linear-gradient(135deg, #C9A84C, #e8c96e)",
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              flexShrink: 0,
              marginTop: 1,
            }}
          >
            <svg width="10" height="8" viewBox="0 0 10 8" fill="none">
              <polyline points="1,4 4,7 9,1" stroke="#0a0a0a" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" />
            </svg>
          </div>
          <p style={{ color: "#555", fontSize: 10, margin: 0, lineHeight: 1.5 }}>
            Concordo com os{" "}
            <span style={{ color: "#C9A84C" }}>Termos de Uso</span> e{" "}
            <span style={{ color: "#C9A84C" }}>Política de Privacidade</span>
          </p>
        </div>

        {/* Register Button */}
        <div
          style={{
            background: "linear-gradient(135deg, #C9A84C, #e8c96e)",
            borderRadius: 14,
            padding: "14px",
            textAlign: "center",
            color: "#0a0a0a",
            fontWeight: 700,
            fontSize: 14,
            marginTop: 18,
            boxShadow: "0 6px 20px rgba(201,168,76,0.4)",
          }}
        >
          Criar Conta
        </div>

        {/* Login link */}
        <div style={{ textAlign: "center", marginTop: 14, paddingBottom: 20 }}>
          <span style={{ color: "#555", fontSize: 12 }}>Já tem conta? </span>
          <span style={{ color: "#C9A84C", fontSize: 12, fontWeight: 700 }}>Entrar</span>
        </div>
      </div>
    </div>
  );
}
