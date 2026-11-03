$ErrorActionPreference = 'Stop'
Set-Location -LiteralPath $PSScriptRoot
$flutterEquipo = 'C:\Flutter\flutter_windows_3.47.2-stable\flutter\bin\flutter.bat'
if (-not (Test-Path -LiteralPath $flutterEquipo)) {
    $flutterEquipo = (Get-Command flutter -ErrorAction Stop).Source
}
if (-not (Test-Path -LiteralPath 'pubspec.yaml')) {
    & $flutterEquipo create --no-pub --platforms=android,web --project-name huellitas_match .
    if ($LASTEXITCODE -ne 0) { throw 'Flutter no pudo crear el proyecto.' }
}
& $flutterEquipo pub add 'provider:^6.1.5+1'
if ($LASTEXITCODE -ne 0) { throw 'No se pudieron descargar las dependencias.' }
& $flutterEquipo analyze
if ($LASTEXITCODE -ne 0) { throw 'Revisa los mensajes del analizador antes de continuar.' }
Write-Host 'Base preparada. Ejecuta flutter run -d chrome para abrirla.'
