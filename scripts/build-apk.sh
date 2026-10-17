#!/usr/bin/env bash
# Dr Nano Deutsch — APK derleme betiği
# Kullanım:
#   bash scripts/build-apk.sh
# İsteğe bağlı ortam değişkenleri:
#   VERSION_CODE=2 VERSION_NAME=1.1     → sürüm numarası
#   KEYSTORE=/yol/drnano.jks            → imza anahtarı (yoksa hata ayıklama anahtarıyla imzalanır)
#   KEYSTORE_PASSWORD=...  KEY_ALIAS=drnano  KEY_PASSWORD=...
# Gereken tek şey: Java 11+ ve internet (ilk çalıştırmada araçlar GitHub'dan indirilir).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BUILD="$ROOT/build"
TOOLS="$BUILD/tools"
DIST="$ROOT/dist"
APKTOOL_VER="2.10.0"
SIGNER_VER="1.3.0"

mkdir -p "$TOOLS" "$DIST"

# 1) Araçları indir (bir kez)
if [ ! -f "$TOOLS/apktool.jar" ]; then
  echo "→ Apktool $APKTOOL_VER indiriliyor…"
  curl -fsSL -o "$TOOLS/apktool.jar" \
    "https://github.com/iBotPeaches/Apktool/releases/download/v$APKTOOL_VER/apktool_$APKTOOL_VER.jar"
fi
if [ ! -f "$TOOLS/uber-apk-signer.jar" ]; then
  echo "→ uber-apk-signer $SIGNER_VER indiriliyor…"
  curl -fsSL -o "$TOOLS/uber-apk-signer.jar" \
    "https://github.com/patrickfav/uber-apk-signer/releases/download/v$SIGNER_VER/uber-apk-signer-$SIGNER_VER.jar"
fi

# 2) Android projesini hazırla: android/ + web uygulaması (docs/) → assets/
echo "→ Proje hazırlanıyor…"
rm -rf "$BUILD/app" "$BUILD/unsigned.apk" "$BUILD/signed"
cp -r "$ROOT/android" "$BUILD/app"
mkdir -p "$BUILD/app/assets"
cp -r "$ROOT/docs/." "$BUILD/app/assets/"
rm -f "$BUILD/app/assets/.nojekyll"

# 3) Sürüm numarası
if [ -n "${VERSION_CODE:-}" ]; then
  sed -i.bak "s/^  versionCode: .*/  versionCode: $VERSION_CODE/" "$BUILD/app/apktool.yml"
fi
if [ -n "${VERSION_NAME:-}" ]; then
  sed -i.bak "s/^  versionName: .*/  versionName: $VERSION_NAME/" "$BUILD/app/apktool.yml"
fi
rm -f "$BUILD/app/apktool.yml.bak"

# 4) Derle
echo "→ APK derleniyor…"
java -jar "$TOOLS/apktool.jar" b "$BUILD/app" -o "$BUILD/unsigned.apk"

# 5) Hizala + imzala (v2/v3)
echo "→ İmzalanıyor…"
if [ -n "${KEYSTORE:-}" ]; then
  java -jar "$TOOLS/uber-apk-signer.jar" -a "$BUILD/unsigned.apk" -o "$BUILD/signed" \
    --ks "$KEYSTORE" --ksAlias "${KEY_ALIAS:-drnano}" \
    --ksPass "${KEYSTORE_PASSWORD:?KEYSTORE_PASSWORD gerekli}" \
    --ksKeyPass "${KEY_PASSWORD:-$KEYSTORE_PASSWORD}"
else
  echo "   (KEYSTORE verilmedi: hata ayıklama anahtarıyla imzalanıyor. Bu APK, sürüm anahtarıyla"
  echo "    imzalanmış eski kurulumun üzerine güncelleme olarak YÜKLENEMEZ.)"
  java -jar "$TOOLS/uber-apk-signer.jar" -a "$BUILD/unsigned.apk" -o "$BUILD/signed"
fi

cp "$BUILD"/signed/*.apk "$DIST/DrNanoDeutsch.apk"
echo "✔ Hazır: dist/DrNanoDeutsch.apk"
