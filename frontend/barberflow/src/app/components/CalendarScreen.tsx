export function CalendarScreen() {
  const days = ["D", "S", "T", "Q", "Q", "S", "S"];
  const dates = [
    [null, null, null, 1, 2, 3, 4],
    [5, 6, 7, 8, 9, 10, 11],
    [12, 13, 14, 15, 16, 17, 18],
    [19, 20, 21, 22, 23, 24, 25],
    [26, 27, 28, null, null, null, null],
  ];
  const todaySelected = 14;

  const times = ["09:00", "10:00", "11:00", "14:00", "15:00", "16:00"];
  const selectedTime = "14:00";
  const unavailable = ["10:00", "15:00"];

  const barbers = [
    { name: "Rafael S.", emoji: "💈" },
    { name: "Carlos M.", emoji: "✂" },
    { name: "Diego L.", emoji: "🪒" },
  ];
  const selectedBarber = 0;

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
          padding: "16px 20px 12px",
          borderBottom: "1px solid #1a1a1a",
          display: "flex",
          alignItems: "center",
          justifyContent: "space-between",
        }}
      >
        <div>
          <p style={{ color: "#888", fontSize: 10, margin: "0 0 2px", fontWeight: 600, letterSpacing: 0.5 }}>
            AGENDAR HORÁRIO
          </p>
          <h3 style={{ color: "#fff", fontSize: 16, fontWeight: 700, margin: 0 }}>Março 2026</h3>
        </div>
        <div style={{ display: "flex", gap: 8 }}>
          {["←", "→"].map((arrow, i) => (
            <div
              key={i}
              style={{
                width: 32,
                height: 32,
                borderRadius: 10,
                background: "#1a1a1a",
                border: "1px solid #2a2a2a",
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                color: "#aaa",
                fontSize: 13,
                fontWeight: 700,
              }}
            >
              {arrow}
            </div>
          ))}
        </div>
      </div>

      <div style={{ padding: "14px 16px", flex: 1 }}>
        {/* Days header */}
        <div style={{ display: "grid", gridTemplateColumns: "repeat(7, 1fr)", marginBottom: 6 }}>
          {days.map((d, i) => (
            <div
              key={i}
              style={{ textAlign: "center", color: "#555", fontSize: 10, fontWeight: 700, padding: "4px 0" }}
            >
              {d}
            </div>
          ))}
        </div>

        {/* Calendar dates */}
        <div style={{ display: "flex", flexDirection: "column", gap: 2 }}>
          {dates.map((week, wi) => (
            <div key={wi} style={{ display: "grid", gridTemplateColumns: "repeat(7, 1fr)", gap: 2 }}>
              {week.map((date, di) => (
                <div
                  key={di}
                  style={{
                    aspectRatio: "1",
                    borderRadius: 9,
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                    fontSize: 11,
                    fontWeight: date === todaySelected ? 700 : 500,
                    background:
                      date === todaySelected
                        ? "linear-gradient(135deg, #C9A84C, #e8c96e)"
                        : date && date > 4 && date < 13
                        ? "#1a1a1a"
                        : "transparent",
                    color:
                      date === todaySelected
                        ? "#0a0a0a"
                        : !date
                        ? "transparent"
                        : date && date > 4 && date < 13
                        ? "#555"
                        : "#ccc",
                    cursor: date ? "pointer" : "default",
                    position: "relative",
                  }}
                >
                  {date}
                  {date === 17 && (
                    <div
                      style={{
                        position: "absolute",
                        bottom: 3,
                        width: 4,
                        height: 4,
                        borderRadius: "50%",
                        background: "#C9A84C",
                      }}
                    />
                  )}
                </div>
              ))}
            </div>
          ))}
        </div>

        {/* Divider */}
        <div style={{ height: 1, background: "#1a1a1a", margin: "14px 0 12px" }} />

        {/* Barber Selection */}
        <p style={{ color: "#888", fontSize: 10, fontWeight: 600, letterSpacing: 0.5, margin: "0 0 8px" }}>
          ESCOLHA O BARBEIRO
        </p>
        <div style={{ display: "flex", gap: 8, marginBottom: 14 }}>
          {barbers.map((b, i) => (
            <div
              key={i}
              style={{
                flex: 1,
                background: i === selectedBarber ? "linear-gradient(135deg, #C9A84C22, #e8c96e11)" : "#1a1a1a",
                border: `1px solid ${i === selectedBarber ? "#C9A84C" : "#222"}`,
                borderRadius: 12,
                padding: "8px 6px",
                textAlign: "center",
              }}
            >
              <div style={{ fontSize: 18, marginBottom: 3 }}>{b.emoji}</div>
              <div
                style={{
                  color: i === selectedBarber ? "#C9A84C" : "#777",
                  fontSize: 9,
                  fontWeight: 600,
                }}
              >
                {b.name}
              </div>
            </div>
          ))}
        </div>

        {/* Time Slots */}
        <p style={{ color: "#888", fontSize: 10, fontWeight: 600, letterSpacing: 0.5, margin: "0 0 8px" }}>
          HORÁRIOS DISPONÍVEIS
        </p>
        <div style={{ display: "grid", gridTemplateColumns: "repeat(3, 1fr)", gap: 7 }}>
          {times.map((time, i) => {
            const isUnavailable = unavailable.includes(time);
            const isSelected = time === selectedTime;
            return (
              <div
                key={i}
                style={{
                  borderRadius: 10,
                  padding: "9px 6px",
                  textAlign: "center",
                  fontSize: 12,
                  fontWeight: 600,
                  background: isSelected
                    ? "linear-gradient(135deg, #C9A84C, #e8c96e)"
                    : isUnavailable
                    ? "#111"
                    : "#1a1a1a",
                  color: isSelected ? "#0a0a0a" : isUnavailable ? "#333" : "#ccc",
                  border: isSelected ? "none" : "1px solid #222",
                  textDecoration: isUnavailable ? "line-through" : "none",
                }}
              >
                {time}
              </div>
            );
          })}
        </div>

        {/* Book Button */}
        <div
          style={{
            background: "linear-gradient(135deg, #C9A84C, #e8c96e)",
            borderRadius: 14,
            padding: "13px",
            textAlign: "center",
            color: "#0a0a0a",
            fontWeight: 700,
            fontSize: 13,
            marginTop: 14,
            boxShadow: "0 6px 20px rgba(201,168,76,0.4)",
          }}
        >
          ✓ Confirmar Agendamento
        </div>
      </div>
    </div>
  );
}
