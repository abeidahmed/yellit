import { hexToHsv, hsvToHex, hsvToRgb } from './converter';

export function makePalette(str) {
  const regex = /^#?(([\dA-Fa-f]{3,4})|([\dA-Fa-f]{6})|([\dA-Fa-f]{8}))$/i;

  if (!regex.test(str)) return null;

  const match = regex.exec(str);

  let [, hex] = match;
  if (hex.length === 4 || hex.length === 3) {
    hex = hex
      .split('')
      .map((v) => v + v)
      .join('');
  }

  const raw = hex.substring(0, 6);
  const hsv = hexToHsv(raw);
  const rgb = hsvToRgb(...hsv);

  return {
    primary: `#${hsvToHex(...hsv).join('')}`,
    accent: calcContrast(...rgb),
  };
}

function calcContrast(r, g, b) {
  const yiq = (r * 299 + g * 587 + b * 114) / 1000;

  return yiq >= 128 ? '#000000' : '#ffffff';
}
