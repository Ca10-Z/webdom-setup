# =============================================
# Instalação automática do WebODM no Windows
# Compatível com PowerShell 5+ (Windows 10/11)
# Execute este script como Administrador
# =============================================

Write-Host "`n=== Iniciando instalação do WebODM ===`n"

# --- Função para recarregar variáveis de ambiente ---
function Refresh-Env {
    Write-Host "Recarregando variáveis de ambiente..."
    $envKeys = "Machine", "User"
    foreach ($scope in $envKeys) {
        $envPath = [System.Environment]::GetEnvironmentVariable("PATH", $scope)
        if ($envPath) {
            $env:PATH += ";$envPath"
        }
    }
}

# --- Função para verificar e instalar com Winget ---
function Install-WithWinget($pkgId, $cmdName) {
    Write-Host "Verificando $cmdName..."
    if (-not (Get-Command $cmdName -ErrorAction SilentlyContinue)) {
        Write-Host "$cmdName não encontrado. Instalando com winget..."
        try {
            winget install --id $pkgId -e --silent --accept-source-agreements --accept-package-agreements
            Write-Host "$cmdName instalado com sucesso.`n"
            Refresh-Env
        } catch {
            Write-Host "❌ Falha ao instalar $cmdName via winget. Instale manualmente."
            exit 1
        }
    } else {
        Write-Host "$cmdName já instalado.`n"
    }
}

# === 1. Verifica se o winget existe ===
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "❌ O winget não está instalado. Instale o App Installer pela Microsoft Store e execute novamente."
    exit 1
}

# === 2. Instalar Git e Docker Desktop ===
Install-WithWinget "Git.Git" "git"
Install-WithWinget "Docker.DockerDesktop" "docker"

# === 3. Inicia o Docker Desktop se necessário ===
$dockerExe = "C:\Program Files\Docker\Docker\Docker Desktop.exe"
if (-not (Get-Process "Docker Desktop" -ErrorAction SilentlyContinue)) {
    if (Test-Path $dockerExe) {
        Write-Host "Iniciando Docker Desktop..."
        Start-Process $dockerExe
    } else {
        Write-Host "❌ Docker Desktop não encontrado no caminho padrão."
        exit 1
    }
} else {
    Write-Host "Docker Desktop já está em execução."
}

# === 4. Aguarda Docker ficar pronto ===
Write-Host "`nAguardando o Docker iniciar completamente (até 3 minutos)...`n"
$maxAttempts = 36
for ($i = 1; $i -le $maxAttempts; $i++) {
    docker version > $null 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Docker está pronto!`n"
        break
    }
    Write-Host "Esperando Docker... ($i/$maxAttempts)"
    Start-Sleep -Seconds 5
    if ($i -eq $maxAttempts) {
        Write-Host "❌ Docker não respondeu a tempo. Abra o Docker Desktop manualmente e tente novamente."
        exit 1
    }
}

# === 5. Clona ou atualiza o WebODM ===
$currentDir = (Get-Location).Path
$webodmPath = Join-Path $currentDir "WebODM"
$gitBash = "C:\Program Files\Git\bin\bash.exe"

if (-not (Test-Path $gitBash)) {
    Write-Host "❌ Git Bash não encontrado. Reinstale o Git e tente novamente."
    exit 1
}

if (-not (Test-Path $webodmPath)) {
    Write-Host "Clonando WebODM em $webodmPath ..."
    & $gitBash -c "git clone https://github.com/OpenDroneMap/WebODM --config core.autocrlf=input --depth 1 '$webodmPath'"
} else {
    Write-Host "WebODM já existe, atualizando repositório..."
    & $gitBash -c "cd '$webodmPath' && git pull"
}

# === 6. Inicia o WebODM ===
Write-Host "`nIniciando WebODM (isso pode demorar na primeira vez)...`n"
& $gitBash -c "cd '$webodmPath' && ./webodm.sh start"

# === 7. Abre navegador ===
Start-Sleep -Seconds 15
Write-Host "Abrindo navegador em http://localhost:8000 ..."
Start-Process "http://localhost:8000"

Write-Host "`n✅ Instalação concluída! Acesse http://localhost:8000 no navegador.`n"
