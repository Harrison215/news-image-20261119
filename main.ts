import { readFileSync, mkdirSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';

const input = new URL('./entry.png', import.meta.url);
const image = readFileSync(input);
const pngSignature = Buffer.from([137, 80, 78, 71, 13, 10, 26, 10]);
if (!image.subarray(0, 8).equals(pngSignature)) throw new Error('entry.png is not a PNG');
if (image.length < 33) throw new Error('entry.png is truncated');
const width = image.readUInt32BE(16);
const height = image.readUInt32BE(20);
if (width === 0 || height === 0 || width > 1024 || height > 1024) throw new Error('entry.png has invalid dimensions');
if (image.length > 1024 * 1024) throw new Error('entry.png exceeds 1 MiB');
if (image.subarray(-8, -4).toString('ascii') !== 'IEND' || !image.subarray(-4).equals(Buffer.from([174, 66, 96, 130]))) {
  throw new Error('entry.png is incomplete');
}

const outputDir = process.env.MAKEFUN_OUTPUT_DIR ?? '/output';
mkdirSync(outputDir, { recursive: true });
const output = join(outputDir, 'entry.png');
writeFileSync(output, image);
if (!readFileSync(output).equals(image)) throw new Error('output image differs from entry.png');
