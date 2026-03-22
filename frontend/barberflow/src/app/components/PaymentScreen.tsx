export function PaymentScreen() {
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
      <div style={{ padding: "14px 20px 12px", borderBottom: "1px solid #1a1a1a" }}>
        <div style={{ display: "flex", alignItems: "center", gap: 10, marginBottom: 2 }}>
          <div
            style={{
              width: 30,
              height: 30,
              borderRadius: 9,
              background: "#1a1a1a",
              border: "1px solid #2a2a2a",
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
            }}
          >
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#aaa" strokeWidth="2.5">
              <polyline points="15 18 9 12 15 6" />
            </svg>
          </div>
          <div>
            <p style={{ color: "#888", fontSize: 10, margin: 0, fontWeight: 600, letterSpacing: 0.5 }}>PAGAMENTO</p>
            <h3 style={{ color: "#fff", fontSize: 15, fontWeight: 700, margin: 0 }}>Finalizar Agendamento</h3>
          </div>
        </div>
      </div>

      <div style={{ padding: "14px 18px", flex: 1 }}>
        {/* Order Summary */}
        <div
          style={{
            background: "#141414",
            border: "1px solid #222",
            borderRadius: 14,
            padding: "14px",
            marginBottom: 14,
          }}
        >
          <p style={{ color: "#888", fontSize: 10, fontWeight: 600, letterSpacing: 0.5, margin: "0 0 10px" }}>
            RESUMO DO PEDIDO
          </p>
          <div style={{ display: "flex", gap: 12, marginBottom: 12 }}>
            <div
              style={{
                width: 44,
                height: 44,
                borderRadius: 12,
                background: "linear-gradient(135deg, #C9A84C22, #e8c96e11)",
                border: "1px solid #C9A84C44",
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                fontSize: 20,
                flexShrink: 0,
              }}
            >
              ✂
            </div>
            <div style={{ flex: 1 }}>
              <div style={{ color: "#ddd", fontSize: 13, fontWeight: 600, marginBottom: 2 }}>Corte + Barba</div>
              <div style={{ color: "#666", fontSize: 11 }}>Rafael Silva · 14:00</div>
              <div style={{ color: "#888", fontSize: 10 }}>14 Mar, 2026 · Sáb</div>
            </div>
          </div>

          <div style={{ borderTop: "1px solid #1a1a1a", paddingTop: 10 }}>
            {[
              { label: "Corte Masculino", value: "R$ 45,00" },
              { label: "Barba", value: "R$ 40,00" },
              { label: "Desconto (10%)", value: "- R$ 8,50", highlight: true },
            ].map((item, i) => (
              <div key={i} style={{ display: "flex", justifyContent: "space-between", marginBottom: 6 }}>
                <span style={{ color: "#666", fontSize: 11 }}>{item.label}</span>
                <span style={{ color: item.highlight ? "#4CAF50" : "#aaa", fontSize: 11, fontWeight: item.highlight ? 600 : 400 }}>
                  {item.value}
                </span>
              </div>
            ))}
            <div style={{ borderTop: "1px solid #1a1a1a", paddingTop: 8, marginTop: 2, display: "flex", justifyContent: "space-between" }}>
              <span style={{ color: "#fff", fontSize: 13, fontWeight: 700 }}>Total</span>
              <span style={{ color: "#C9A84C", fontSize: 14, fontWeight: 700 }}>R$ 76,50</span>
            </div>
          </div>
        </div>

        {/* Payment Methods */}
        <p style={{ color: "#888", fontSize: 10, fontWeight: 600, letterSpacing: 0.5, margin: "0 0 10px" }}>
          FORMA DE PAGAMENTO
        </p>

        <div style={{ display: "flex", flexDirection: "column", gap: 8 }}>
          {/* PIX - Selected */}
          <div
            style={{
              background: "linear-gradient(135deg, #C9A84C15, #e8c96e08)",
              border: "1.5px solid #C9A84C",
              borderRadius: 14,
              padding: "12px 14px",
              display: "flex",
              alignItems: "center",
              gap: 12,
            }}
          >
            <div
              style={{
                width: 38,
                height: 38,
                borderRadius: 10,
                background: "#32B78822",
                border: "1px solid #32B78844",
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                fontSize: 18,
                flexShrink: 0,
              }}
            >
              ⚡
            </div>
            <div style={{ flex: 1 }}>
              <div style={{ color: "#fff", fontSize: 13, fontWeight: 600 }}>PIX</div>
              <div style={{ color: "#32B788", fontSize: 10, fontWeight: 600 }}>Aprovação imediata</div>
            </div>
            <div
              style={{
                width: 20,
                height: 20,
                borderRadius: "50%",
                background: "linear-gradient(135deg, #C9A84C, #e8c96e)",
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
              }}
            >
              <div style={{ width: 8, height: 8, borderRadius: "50%", background: "#0a0a0a" }} />
            </div>
          </div>

          {/* Credit Card */}
          <div
            style={{
              background: "#141414",
              border: "1px solid #222",
              borderRadius: 14,
              padding: "12px 14px",
              display: "flex",
              alignItems: "center",
              gap: 12,
            }}
          >
            <div
              style={{
                width: 38,
                height: 38,
                borderRadius: 10,
                background: "#1a1a1a",
                border: "1px solid #222",
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                fontSize: 18,
                flexShrink: 0,
              }}
            >
              💳
            </div>
            <div style={{ flex: 1 }}>
              <div style={{ color: "#aaa", fontSize: 13, fontWeight: 600 }}>Cartão de Crédito</div>
              <div style={{ color: "#555", fontSize: 10 }}>Até 12x sem juros</div>
            </div>
            <div
              style={{
                width: 20,
                height: 20,
                borderRadius: "50%",
                border: "2px solid #333",
              }}
            />
          </div>

          {/* Debit */}
          <div
            style={{
              background: "#141414",
              border: "1px solid #222",
              borderRadius: 14,
              padding: "12px 14px",
              display: "flex",
              alignItems: "center",
              gap: 12,
            }}
          >
            <div
              style={{
                width: 38,
                height: 38,
                borderRadius: 10,
                background: "#1a1a1a",
                border: "1px solid #222",
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                fontSize: 18,
                flexShrink: 0,
              }}
            >
              🏦
            </div>
            <div style={{ flex: 1 }}>
              <div style={{ color: "#aaa", fontSize: 13, fontWeight: 600 }}>Débito</div>
              <div style={{ color: "#555", fontSize: 10 }}>À vista</div>
            </div>
            <div
              style={{
                width: 20,
                height: 20,
                borderRadius: "50%",
                border: "2px solid #333",
              }}
            />
          </div>

          {/* Voucher */}
          <div
            style={{
              background: "#141414",
              border: "1px dashed #2a2a2a",
              borderRadius: 14,
              padding: "11px 14px",
              display: "flex",
              alignItems: "center",
              gap: 10,
            }}
          >
            <span style={{ fontSize: 14 }}>🎟</span>
            <span style={{ color: "#555", fontSize: 12, flex: 1 }}>Adicionar cupom de desconto</span>
            <span style={{ color: "#C9A84C", fontSize: 13, fontWeight: 700 }}>+</span>
          </div>
        </div>

        {/* Pay Button */}
        <div
          style={{
            background: "linear-gradient(135deg, #C9A84C, #e8c96e)",
            borderRadius: 16,
            padding: "15px",
            textAlign: "center",
            marginTop: 14,
            boxShadow: "0 6px 20px rgba(201,168,76,0.4)",
          }}
        >
          <div style={{ color: "#0a0a0a", fontWeight: 700, fontSize: 14 }}>⚡ Pagar com PIX · R$ 76,50</div>
        </div>
      </div>
    </div>
  );
}
