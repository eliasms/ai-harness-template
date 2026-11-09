<#
.SYNOPSIS
    Inicializa um novo projeto a partir do AI Harness Template.
.DESCRIPTION
    Substitui todos os placeholders {{PROJECT_NAME}} e {{PROJECT_SLUG}} nos arquivos de configuração,
    documentação e agentes, além de configurar a junction de agentes na raiz do workspace.
.PARAMETER ProjectName
    Nome humanizado do projeto (ex.: "OrderFlow Studio", "FinTech Core").
.PARAMETER ProjectSlug
    Slug do projeto em minúsculas (ex.: "orderflow-studio", "fintech-core").
.EXAMPLE
    .\scripts\init-project.ps1 -ProjectName "FinTech Core" -ProjectSlug "fintech-core"
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectName,

    [Parameter(Mandatory = $true)]
    [string]$ProjectSlug
)

$ErrorActionPreference = "Stop"
$root = Resolve-Path "$PSScriptRoot\.."
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "Inicializando Novo Projeto a partir do AI Harness Template" -ForegroundColor Green
Write-Host "Raiz do Workspace: $root" -ForegroundColor Gray
Write-Host "Nome do Projeto:   $ProjectName" -ForegroundColor Yellow
Write-Host "Slug do Projeto:   $ProjectSlug" -ForegroundColor Yellow
Write-Host "==========================================================" -ForegroundColor Cyan

# 1. Substituir Placeholders nos arquivos de texto
$extensions = @("*.md", "*.json", "*.yaml", "*.yml", "*.example", "*.ps1", "*.sh")
$files = Get-ChildItem -Path $root -Recurse -File -Include $extensions | Where-Object {
    $_.FullName -notmatch '\\\.git\\|\\node_modules\\|\\data\\input\\|\\data\\output\\'
}

$currentDate = (Get-Date).ToString("yyyy-MM-dd")
$workspacePath = $root.Path.Replace("\", "/")

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    if ($content -match '\{\{PROJECT_NAME\}\}|\{\{PROJECT_SLUG\}\}|\{\{WORKSPACE_PATH\}\}|\{\{DATE\}\}') {
        $updated = $content.Replace('{{PROJECT_NAME}}', $ProjectName)
        $updated = $updated.Replace('{{PROJECT_SLUG}}', $ProjectSlug)
        $updated = $updated.Replace('{{WORKSPACE_PATH}}', $workspacePath)
        $updated = $updated.Replace('{{DATE}}', $currentDate)
        [System.IO.File]::WriteAllText($file.FullName, $updated, (New-Object System.Text.UTF8Encoding($false)))
        Write-Host "  Atualizado: $($file.FullName.Replace($root.Path, ''))" -ForegroundColor DarkGray
    }
}

# 2. Configurar Junction de .agents na raiz
$rootAgents = Join-Path $root ".agents"
$specHubAgents = Join-Path $root "spec-hub\.agents"

if (-not (Test-Path $rootAgents)) {
    Write-Host "Criando Junction: .agents -> spec-hub\.agents" -ForegroundColor Yellow
    cmd /c mklink /J "$rootAgents" "$specHubAgents" | Out-Null
    Write-Host "Junction criada com sucesso!" -ForegroundColor Green
} else {
    Write-Host ".agents já existe na raiz." -ForegroundColor Gray
}

# 3. Criar .env a partir de .env.example se não existir
$envFile = Join-Path $root ".env"
$envExample = Join-Path $root ".env.example"
if (-not (Test-Path $envFile) -and (Test-Path $envExample)) {
    Copy-Item $envExample $envFile
    Write-Host "Arquivo .env criado a partir de .env.example" -ForegroundColor Green
}

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "Projeto '$ProjectName' configurado com sucesso!" -ForegroundColor Green
Write-Host "Consulte README.md para entender o ciclo de vida autônomo." -ForegroundColor Yellow
Write-Host "==========================================================" -ForegroundColor Cyan
