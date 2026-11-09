<#
.SYNOPSIS
    Garante a existência do link/junction .agents na raiz apontando para spec-hub\.agents.
#>

$root = Resolve-Path "$PSScriptRoot\.."
$rootAgents = Join-Path $root ".agents"
$specHubAgents = Join-Path $root "spec-hub\.agents"

if (-not (Test-Path $specHubAgents)) {
    Write-Error "Pasta de origem não encontrada: $specHubAgents"
    exit 1
}

if (-not (Test-Path $rootAgents)) {
    Write-Host "Criando Junction do Windows: $rootAgents -> $specHubAgents" -ForegroundColor Yellow
    cmd /c mklink /J "$rootAgents" "$specHubAgents"
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Junction criada com sucesso." -ForegroundColor Green
    } else {
        Write-Error "Falha ao criar Junction."
    }
} else {
    Write-Host "Junction .agents já está presente na raiz." -ForegroundColor Cyan
}
