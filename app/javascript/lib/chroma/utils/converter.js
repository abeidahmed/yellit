const { floor, round, min, max } = Math;

export function hsvToRgb(h, s, v) {
  h = (h / 360) * 6;
  s /= 100;
  v /= 100;

  const i = floor(h);

  const f = h - i;
  const p = v * (1 - s);
  const q = v * (1 - f * s);
  const t = v * (1 - (1 - f) * s);

  const mod = i % 6;
  const r = [v, q, p, p, t, v][mod];
  const g = [t, v, v, q, p, p][mod];
  const b = [p, p, t, v, v, q][mod];

  return [r * 255, g * 255, b * 255];
}

export function rgbToHsv(r, g, b) {
  r /= 255;
  g /= 255;
  b /= 255;

  const minVal = min(r, g, b);
  const maxVal = max(r, g, b);
  const delta = maxVal - minVal;

  let h, s;
  const v = maxVal;
  if (delta === 0) {
    h = s = 0;
  } else {
    s = delta / maxVal;
    const dr = ((maxVal - r) / 6 + delta / 2) / delta;
    const dg = ((maxVal - g) / 6 + delta / 2) / delta;
    const db = ((maxVal - b) / 6 + delta / 2) / delta;

    if (r === maxVal) {
      h = db - dg;
    } else if (g === maxVal) {
      h = 1 / 3 + dr - db;
    } else if (b === maxVal) {
      h = 2 / 3 + dg - dr;
    }

    if (h < 0) {
      h += 1;
    } else if (h > 1) {
      h -= 1;
    }
  }

  return [h * 360, s * 100, v * 100];
}

export function hsvToHex(h, s, v) {
  return hsvToRgb(h, s, v).map((v) => round(v).toString(16).padStart(2, '0'));
}

export function hexToHsv(hex) {
  return rgbToHsv(...hex.match(/.{2}/g).map((v) => parseInt(v, 16)));
}
