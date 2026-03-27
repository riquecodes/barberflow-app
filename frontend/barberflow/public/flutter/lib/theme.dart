import 'package:flutter/material.dart';

// ── Cores ──────────────────────────────────────────────
const kBg      = Color(0xFF0D0D0D);
const kBg2     = Color(0xFF111111);
const kBgGrad1 = Color(0xFF0A0A0A);
const kBgGrad2 = Color(0xFF1A1208);
const kCard    = Color(0xFF141414);
const kCard2   = Color(0xFF1A1A1A);
const kCard3   = Color(0xFF171717);
const kGold    = Color(0xFFC9A84C);
const kGoldLt  = Color(0xFFE8C96E);
const kBorder  = Color(0xFF222222);
const kBorder2 = Color(0xFF2A2A2A);
const kDim     = Color(0xFF888888);
const kMuted   = Color(0xFF666666);
const kDeep    = Color(0xFF444444);
const kText    = Color(0xFFDDDDDD);
const kGreen   = Color(0xFF4CAF50);
const kOrange  = Color(0xFFFF9800);

// ── Gradients ──────────────────────────────────────────
const kGoldGrad = LinearGradient(
  colors: [kGold, kGoldLt],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const kBgGrad = LinearGradient(
  colors: [kBgGrad1, kBgGrad2, kBgGrad1],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const kGoldGradTransp = LinearGradient(
  colors: [Colors.transparent, kGold, Colors.transparent],
);

// ── Widgets utilitários ────────────────────────────────
Widget goldButton(String label, {VoidCallback? onTap, double radius = 14}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        gradient: kGoldGrad,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: kGold.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF0A0A0A),
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
    ),
  );
}

Widget sectionTitle(String label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      label,
      style: const TextStyle(
        color: kDim,
        fontSize: 10,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
      ),
    ),
  );
}

Widget divider() => Container(height: 1, color: const Color(0xFF1A1A1A), margin: const EdgeInsets.symmetric(vertical: 14));

Widget backIcon(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.maybePop(context),
    child: Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: kCard2,
        border: Border.all(color: kBorder2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(Icons.chevron_left, color: kDim, size: 20),
    ),
  );
}

// ── Estrelas ──────────────────────────────────────────
Widget stars(int filled, {int total = 5, double size = 13}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(total, (i) => Text(
      '★',
      style: TextStyle(
        color: i < filled ? kGold : const Color(0xFF2A2A2A),
        fontSize: size,
      ),
    )),
  );
}
