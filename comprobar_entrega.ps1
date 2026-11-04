param([switch]$GenerarApk)
$ErrorActionPreference = 'Stop'
Set-Location -LiteralPath $PSScriptRoot
$flutterEntrega = (Get-Command flutter -ErrorAction Stop).Source
& $flutterEntrega analyze
if ($LASTEXITCODE -ne 0) { throw 'El analizador encontro problemas. Revisa la salida.' }
& $flutterEntrega test
if ($LASTEXITCODE -ne 0) { throw 'Alguna prueba fallo. Revisa la salida.' }
if ($GenerarApk) {
    & $flutterEntrega build apk --release
    if ($LASTEXITCODE -ne 0) { throw 'No se pudo generar el APK. Revisa el error de Android.' }
    New-Item -ItemType Directory -Path 'entrega' -Force | Out-Null
    Copy-Item -LiteralPath 'build\app\outputs\flutter-apk\app-release.apk' -Destination 'entrega\huellitas_match.apk' -Force
    Write-Host 'APK disponible en entrega\huellitas_match.apk'
}
Write-Host 'Comprobaciones terminadas correctamente.'
