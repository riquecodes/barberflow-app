export function AdminScreen() {
  const appointments = [
    { time: "09:00", client: "Ana Paula", service: "Corte Feminino", value: "R$ 60", status: "done" },
    { time: "10:30", client: "Marcos T.", service: "Barba + Corte", value: "R$ 85", status: "done" },
    { time: "14:00", client: "Ricardo A.", service: "Corte Masculino", value: "R$ 45", status: "current" },
    { time: "15:30", client: "Felipe N.", service: "Barba", value: "R$ 40", status: "next" },
    { time: "17:00", client: "Bruno C.", service: "Corte + Hidrat.", value: "R$ 95", status: "next" },
  ];

  const stats = [
    { label: "Hoje", value: "12", icon: "📅", color: "#C9A84C" },
    { label: "Faturamento", value: "R$840", icon: "💰", color: "#4CAF50" },
    { label: "Avaliação", value: "4.9★", icon: "⭐", color: "#FF9800" },
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
      {/* Header */}
      <div
        style={{
          padding: "14px 18px 12px",
          background: "linear-gradient(180deg, #111 0%, #0D0D0D 100%)",
          borderBottom: "1px solid #1a1a1a",
        }}
      >
        <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginBottom: 10 }}>
          <div>
            <p style={{ color: "#888", fontSize: 10, margin: "0 0 2px", fontWeight: 600, letterSpacing: 0.5 }}>
              PAINEL DO BARBEIRO
            </p>
            <h3 style={{ color: "#fff", fontSize: 15, fontWeight: 700, margin: 0 }}>
              Olá, Rafael! 👋
            </h3>
          </div>
          <div
            style={{
              width: 38,
              height: 38,
              borderRadius: "50%",
              background: "linear-gradient(135deg, #C9A84C, #e8c96e)",
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              fontSize: 16,
            }}
          >
            💈
          </div>
        </div>

        {/* Stats Row */}
        <div style={{ display: "flex", gap: 7 }}>
          {stats.map((stat, i) => (
            <div
              key={i}
              style={{
                flex: 1,
                background: "#171717",
                border: "1px solid #222",
                borderRadius: 12,
                padding: "8px 8px",
                textAlign: "center",
              }}
            >
              <div style={{ fontSize: 14, marginBottom: 2 }}>{stat.icon}</div>
              <div style={{ color: stat.color, fontSize: 12, fontWeight: 700 }}>{stat.value}</div>
              <div style={{ color: "#555", fontSize: 9, fontWeight: 600 }}>{stat.label}</div>
            </div>
          ))}
        </div>
      </div>

      <div style={{ padding: "12px 18px", flex: 1 }}>
        {/* Quick Actions */}
        <div style={{ display: "flex", gap: 8, marginBottom: 14 }}>
          {[
            { label: "Bloquear Horário", icon: "🔒" },
            { label: "Novo Serviço", icon: "+" },
            { label: "Relatório", icon: "📊" },
          ].map((action, i) => (
            <div
              key={i}
              style={{
                flex: 1,
                background: i === 1 ? "linear-gradient(135deg, #C9A84C, #e8c96e)" : "#1a1a1a",
                border: i === 1 ? "none" : "1px solid #222",
                borderRadius: 11,
                padding: "9px 6px",
                textAlign: "center",
              }}
            >
              <div style={{ fontSize: i === 1 ? 16 : 14, marginBottom: 2 }}>{action.icon}</div>
              <div style={{ color: i === 1 ? "#0a0a0a" : "#666", fontSize: 8, fontWeight: 700 }}>{action.label}</div>
            </div>
          ))}
        </div>

        {/* Appointments */}
        <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginBottom: 10 }}>
          <p style={{ color: "#888", fontSize: 10, fontWeight: 600, letterSpacing: 0.5, margin: 0 }}>
            AGENDA DE HOJE
          </p>
          <span style={{ color: "#C9A84C", fontSize: 10, fontWeight: 600 }}>Ver tudo</span>
        </div>

        <div style={{ display: "flex", flexDirection: "column", gap: 7 }}>
          {appointments.map((apt, i) => (
            <div
              key={i}
              style={{
                background: apt.status === "current" ? "linear-gradient(135deg, #C9A84C15, #e8c96e08)" : "#141414",
                border: `1px solid ${apt.status === "current" ? "#C9A84C44" : apt.status === "done" ? "#1a1a1a" : "#222"}`,
                borderRadius: 12,
                padding: "10px 12px",
                display: "flex",
                alignItems: "center",
                gap: 10,
                opacity: apt.status === "done" ? 0.5 : 1,
              }}
            >
              {/* Time */}
              <div style={{ textAlign: "center", minWidth: 36 }}>
                <div style={{ color: apt.status === "current" ? "#C9A84C" : "#888", fontSize: 10, fontWeight: 700 }}>
                  {apt.time}
                </div>
              </div>

              {/* Divider line */}
              <div style={{ width: 1, height: 32, background: apt.status === "current" ? "#C9A84C44" : "#222" }} />

              {/* Info */}
              <div style={{ flex: 1 }}>
                <div style={{ color: apt.status === "done" ? "#666" : "#ddd", fontSize: 12, fontWeight: 600 }}>
                  {apt.client}
                </div>
                <div style={{ color: "#555", fontSize: 10 }}>{apt.service}</div>
              </div>

              {/* Status & Value */}
              <div style={{ textAlign: "right" }}>
                <div style={{ color: apt.status === "done" ? "#4CAF50" : apt.status === "current" ? "#C9A84C" : "#777", fontSize: 10, fontWeight: 700 }}>
                  {apt.value}
                </div>
                <div
                  style={{
                    fontSize: 8,
                    fontWeight: 600,
                    color: apt.status === "done" ? "#4CAF5088" : apt.status === "current" ? "#C9A84C" : "#444",
                    marginTop: 2,
                  }}
                >
                  {apt.status === "done" ? "✓ Concluído" : apt.status === "current" ? "● Em andamento" : "Aguardando"}
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Bottom Nav */}
      <div
        style={{
          background: "#0D0D0D",
          borderTop: "1px solid #1a1a1a",
          padding: "10px 20px 12px",
          display: "flex",
          justifyContent: "space-around",
        }}
      >
        {[
          { icon: "📅", label: "Agenda", active: true },
          { icon: "👥", label: "Clientes", active: false },
          { icon: "📊", label: "Relatório", active: false },
          { icon: "⚙", label: "Config.", active: false },
        ].map((tab, i) => (
          <div key={i} style={{ textAlign: "center", flex: 1 }}>
            <div style={{ fontSize: 16 }}>{tab.icon}</div>
            <div
              style={{
                fontSize: 8,
                fontWeight: 600,
                color: tab.active ? "#C9A84C" : "#444",
                marginTop: 2,
              }}
            >
              {tab.label}
            </div>
            {tab.active && (
              <div
                style={{
                  width: 16,
                  height: 2,
                  background: "#C9A84C",
                  borderRadius: 2,
                  margin: "3px auto 0",
                }}
              />
            )}
          </div>
        ))}
      </div>
    </div>
  );
}
