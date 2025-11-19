#!/usr/bin/env pwsh
# Script de utilidades para Piscinapp
# Uso: .\scripts\dev.ps1 <comando>

param(
    [Parameter(Position=0)]
    [string]$Command = "help"
)

function Show-Help {
    Write-Host "🏊 Piscinapp - Script de Desarrollo" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Comandos disponibles:" -ForegroundColor Yellow
    Write-Host "  setup       - Configuración inicial del proyecto"
    Write-Host "  run         - Ejecutar la app en modo debug"
    Write-Host "  build       - Construir APK de release"
    Write-Host "  analyze     - Analizar código"
    Write-Host "  format      - Formatear código"
    Write-Host "  generate    - Generar código (Hive adapters)"
    Write-Host "  clean       - Limpiar build artifacts"
    Write-Host "  test        - Ejecutar tests (cuando estén disponibles)"
    Write-Host "  deps        - Actualizar dependencias"
    Write-Host "  check       - Verificar todo antes de commit"
    Write-Host "  help        - Mostrar esta ayuda"
    Write-Host ""
    Write-Host "Ejemplo: .\scripts\dev.ps1 setup" -ForegroundColor Green
}

function Setup-Project {
    Write-Host "📦 Configurando proyecto..." -ForegroundColor Cyan
    flutter pub get
    flutter pub run build_runner build --delete-conflicting-outputs
    Write-Host "✅ Proyecto configurado correctamente" -ForegroundColor Green
}

function Run-App {
    Write-Host "🚀 Ejecutando app..." -ForegroundColor Cyan
    flutter run
}

function Build-Release {
    Write-Host "🔨 Construyendo APK de release..." -ForegroundColor Cyan
    flutter build apk --release
    Write-Host "✅ APK generado en: build\app\outputs\flutter-apk\app-release.apk" -ForegroundColor Green
}

function Analyze-Code {
    Write-Host "🔍 Analizando código..." -ForegroundColor Cyan
    flutter analyze
}

function Format-Code {
    Write-Host "✨ Formateando código..." -ForegroundColor Cyan
    flutter format .
    Write-Host "✅ Código formateado" -ForegroundColor Green
}

function Generate-Code {
    Write-Host "⚙️ Generando código..." -ForegroundColor Cyan
    flutter pub run build_runner build --delete-conflicting-outputs
    Write-Host "✅ Código generado" -ForegroundColor Green
}

function Clean-Project {
    Write-Host "🧹 Limpiando proyecto..." -ForegroundColor Cyan
    flutter clean
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "build"
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue ".dart_tool"
    Write-Host "✅ Proyecto limpio" -ForegroundColor Green
}

function Run-Tests {
    Write-Host "🧪 Ejecutando tests..." -ForegroundColor Cyan
    flutter test
}

function Update-Dependencies {
    Write-Host "📦 Actualizando dependencias..." -ForegroundColor Cyan
    flutter pub upgrade
    flutter pub outdated
    Write-Host "✅ Dependencias actualizadas" -ForegroundColor Green
}

function Check-All {
    Write-Host "🔍 Verificación completa..." -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "1️⃣ Formateando código..." -ForegroundColor Yellow
    flutter format .
    
    Write-Host "2️⃣ Analizando código..." -ForegroundColor Yellow
    flutter analyze
    
    Write-Host "3️⃣ Ejecutando tests..." -ForegroundColor Yellow
    flutter test
    
    Write-Host "4️⃣ Construyendo APK..." -ForegroundColor Yellow
    flutter build apk --release
    
    Write-Host ""
    Write-Host "✅ Verificación completa. Listo para commit!" -ForegroundColor Green
}

# Ejecutar comando
switch ($Command) {
    "setup"     { Setup-Project }
    "run"       { Run-App }
    "build"     { Build-Release }
    "analyze"   { Analyze-Code }
    "format"    { Format-Code }
    "generate"  { Generate-Code }
    "clean"     { Clean-Project }
    "test"      { Run-Tests }
    "deps"      { Update-Dependencies }
    "check"     { Check-All }
    "help"      { Show-Help }
    default     { 
        Write-Host "❌ Comando desconocido: $Command" -ForegroundColor Red
        Write-Host ""
        Show-Help
    }
}
