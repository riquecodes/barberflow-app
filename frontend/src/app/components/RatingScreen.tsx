export function RatingScreen() {
  const aspects = [
    { label: "Atendimento", stars: 5 },
    { label: "Qualidade", stars: 5 },
    { label: "Ambiente", stars: 4 },
    { label: "Pontualidade", stars: 5 },
  ];

  const tags = ["Ótimo atendimento", "Ambiente agradável", "Profissional", "Pontual", "Custo-benefício", "Recomendo!"];
  const selectedTags = [0, 2, 3, 5];

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
      <div style={{ padding: "14px 20px 12px", borderBottom: "1px solid #1a1a1a", display: "flex", alignItems: "center", gap: 10 }}>
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
          <p style={{ color: "#888", fontSize: 10, margin: 0, fontWeight: 600, letterSpacing: 0.5 }}>SUA OPINIÃO</p>
          <h3 style={{ color: "#fff", fontSize: 15, fontWeight: 700, margin: 0 }}>Avalie o Atendimento</h3>
        </div>
      </div>

      <div style={{ padding: "16px 20px", flex: 1 }}>
        {/* Barber Card */}
        <div
          style={{
            background: "linear-gradient(135deg, #141414, #1a1408)",
            border: "1px solid #C9A84C33",
            borderRadius: 16,
            padding: "14px",
            display: "flex",
            alignItems: "center",
            gap: 12,
            marginBottom: 18,
          }}
        >
          <div
            style={{
              width: 50,
              height: 50,
              borderRadius: "50%",
              background: "linear-gradient(135deg, #C9A84C, #e8c96e)",
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              fontSize: 22,
              flexShrink: 0,
            }}
          >
            💈
          </div>
          <div style={{ flex: 1 }}>
            <div style={{ color: "#fff", fontSize: 14, fontWeight: 700 }}>Rafael Silva</div>
            <div style={{ color: "#888", fontSize: 11 }}>Corte + Barba · 14/03/2026</div>
            <div style={{ display: "flex", gap: 2, marginTop: 4 }}>
              {[1, 2, 3, 4, 5].map((s) => (
                <span key={s} style={{ color: "#C9A84C", fontSize: 10 }}>★</span>
              ))}
              <span style={{ color: "#C9A84C", fontSize: 10, marginLeft: 3, fontWeight: 600 }}>4.9</span>
            </div>
          </div>
          <div style={{ textAlign: "right" }}>
            <div style={{ color: "#C9A84C", fontSize: 13, fontWeight: 700 }}>R$ 76,50</div>
            <div style={{ color: "#4CAF50", fontSize: 9, fontWeight: 600 }}>✓ Pago</div>
          </div>
        </div>

        {/* Overall Rating */}
        <div style={{ textAlign: "center", marginBottom: 18 }}>
          <p style={{ color: "#888", fontSize: 10, fontWeight: 600, letterSpacing: 0.5, margin: "0 0 10px" }}>
            AVALIAÇÃO GERAL
          </p>
          <div style={{ display: "flex", justifyContent: "center", gap: 8 }}>
            {[1, 2, 3, 4, 5].map((star) => (
              <div key={star} style={{ fontSize: 30, cursor: "pointer", filter: "drop-shadow(0 0 6px rgba(201,168,76,0.5))" }}>
                ★
              </div>
            ))}
          </div>
          <p style={{ color: "#C9A84C", fontSize: 13, fontWeight: 700, margin: "8px 0 0" }}>Excelente!</p>
        </div>

        {/* Aspect Ratings */}
        <div
          style={{
            background: "#141414",
            border: "1px solid #1e1e1e",
            borderRadius: 14,
            padding: "12px 14px",
            marginBottom: 14,
          }}
        >
          <p style={{ color: "#777", fontSize: 10, fontWeight: 600, letterSpacing: 0.5, margin: "0 0 10px" }}>
            AVALIE CADA ASPECTO
          </p>
          {aspects.map((aspect, i) => (
            <div
              key={i}
              style={{
                display: "flex",
                alignItems: "center",
                justifyContent: "space-between",
                marginBottom: i < aspects.length - 1 ? 8 : 0,
              }}
            >
              <span style={{ color: "#aaa", fontSize: 11, flex: 1 }}>{aspect.label}</span>
              <div style={{ display: "flex", gap: 2 }}>
                {[1, 2, 3, 4, 5].map((s) => (
                  <span
                    key={s}
                    style={{
                      color: s <= aspect.stars ? "#C9A84C" : "#2a2a2a",
                      fontSize: 13,
                    }}
                  >
                    ★
                  </span>
                ))}
              </div>
            </div>
          ))}
        </div>

        {/* Tags */}
        <p style={{ color: "#888", fontSize: 10, fontWeight: 600, letterSpacing: 0.5, margin: "0 0 8px" }}>
          O QUE VOCÊ MAIS GOSTOU?
        </p>
        <div style={{ display: "flex", flexWrap: "wrap", gap: 6, marginBottom: 14 }}>
          {tags.map((tag, i) => (
            <div
              key={i}
              style={{
                padding: "5px 10px",
                borderRadius: 20,
                fontSize: 10,
                fontWeight: 600,
                background: selectedTags.includes(i) ? "linear-gradient(135deg, #C9A84C22, #e8c96e11)" : "#141414",
                border: `1px solid ${selectedTags.includes(i) ? "#C9A84C" : "#222"}`,
                color: selectedTags.includes(i) ? "#C9A84C" : "#555",
              }}
            >
              {selectedTags.includes(i) ? "✓ " : ""}{tag}
            </div>
          ))}
        </div>

        {/* Comment */}
        <p style={{ color: "#888", fontSize: 10, fontWeight: 600, letterSpacing: 0.5, margin: "0 0 8px" }}>
          DEIXE UM COMENTÁRIO
        </p>
        <div
          style={{
            background: "#141414",
            border: "1px solid #C9A84C44",
            borderRadius: 12,
            padding: "10px 12px",
            minHeight: 64,
            marginBottom: 14,
          }}
        >
          <span style={{ color: "#444", fontSize: 11 }}>
            Ótimo profissional! Serviço impecável, atendimento rápido e ambiente muito agradável...
          </span>
        </div>

        {/* Submit Button */}
        <div
          style={{
            background: "linear-gradient(135deg, #C9A84C, #e8c96e)",
            borderRadius: 16,
            padding: "14px",
            textAlign: "center",
            boxShadow: "0 6px 20px rgba(201,168,76,0.4)",
          }}
        >
          <div style={{ color: "#0a0a0a", fontWeight: 700, fontSize: 14 }}>★ Enviar Avaliação</div>
        </div>

        <p style={{ color: "#444", fontSize: 10, textAlign: "center", margin: "10px 0 0" }}>
          Sua avaliação ajuda outros clientes a escolher melhor!
        </p>
      </div>
    </div>
  );
}
