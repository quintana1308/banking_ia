# GitFlow Helper Scripts para Banking ADN V3
# Uso: .\scripts\gitflow-helpers.ps1 <comando> [argumentos]

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("feature", "release", "hotfix", "finish", "sync", "clean")]
    [string]$Command,
    
    [Parameter(Mandatory=$false)]
    [string]$Name,
    
    [Parameter(Mandatory=$false)]
    [string]$Version
)

function Start-Feature {
    param([string]$FeatureName)
    
    if (-not $FeatureName) {
        Write-Host "❌ Error: Nombre de feature requerido" -ForegroundColor Red
        Write-Host "Uso: .\scripts\gitflow-helpers.ps1 feature nombre-feature" -ForegroundColor Yellow
        return
    }
    
    Write-Host "🚀 Creando feature: $FeatureName" -ForegroundColor Green
    
    # Actualizar develop
    git checkout develop
    git pull origin develop
    
    # Crear rama feature
    $branchName = "feature/$FeatureName"
    git checkout -b $branchName
    git push -u origin $branchName
    
    Write-Host "✅ Feature '$FeatureName' creada exitosamente" -ForegroundColor Green
    Write-Host "📝 Rama actual: $branchName" -ForegroundColor Cyan
    Write-Host "💡 Recuerda usar Conventional Commits!" -ForegroundColor Yellow
}

function Start-Release {
    param([string]$ReleaseVersion)
    
    if (-not $ReleaseVersion) {
        Write-Host "❌ Error: Versión de release requerida" -ForegroundColor Red
        Write-Host "Uso: .\scripts\gitflow-helpers.ps1 release 1.0.0" -ForegroundColor Yellow
        return
    }
    
    Write-Host "🎯 Creando release: v$ReleaseVersion" -ForegroundColor Green
    
    # Actualizar develop
    git checkout develop
    git pull origin develop
    
    # Crear rama release
    $branchName = "release/$ReleaseVersion"
    git checkout -b $branchName
    git push -u origin $branchName
    
    Write-Host "✅ Release 'v$ReleaseVersion' creada exitosamente" -ForegroundColor Green
    Write-Host "📝 Rama actual: $branchName" -ForegroundColor Cyan
    Write-Host "💡 Prepara la versión y crea PR a main y develop" -ForegroundColor Yellow
}

function Start-Hotfix {
    param([string]$HotfixName)
    
    if (-not $HotfixName) {
        Write-Host "❌ Error: Nombre de hotfix requerido" -ForegroundColor Red
        Write-Host "Uso: .\scripts\gitflow-helpers.ps1 hotfix descripcion-breve" -ForegroundColor Yellow
        return
    }
    
    Write-Host "🚨 Creando hotfix: $HotfixName" -ForegroundColor Red
    
    # Actualizar main
    git checkout main
    git pull origin main
    
    # Crear rama hotfix
    $branchName = "hotfix/$HotfixName"
    git checkout -b $branchName
    git push -u origin $branchName
    
    Write-Host "✅ Hotfix '$HotfixName' creado exitosamente" -ForegroundColor Green
    Write-Host "📝 Rama actual: $branchName" -ForegroundColor Cyan
    Write-Host "⚠️  Recuerda crear PR a main Y develop" -ForegroundColor Yellow
}

function Sync-Branches {
    Write-Host "🔄 Sincronizando ramas principales..." -ForegroundColor Cyan
    
    # Sincronizar main
    Write-Host "📥 Actualizando main..." -ForegroundColor Blue
    git checkout main
    git pull origin main
    
    # Sincronizar develop
    Write-Host "📥 Actualizando develop..." -ForegroundColor Blue
    git checkout develop
    git pull origin develop
    
    Write-Host "✅ Ramas sincronizadas exitosamente" -ForegroundColor Green
}

function Clean-Branches {
    Write-Host "🧹 Limpiando ramas obsoletas..." -ForegroundColor Cyan
    
    # Eliminar ramas locales mergeadas
    Write-Host "🗑️  Eliminando ramas locales mergeadas..." -ForegroundColor Blue
    git branch --merged develop | Where-Object { $_ -notmatch "develop|main|\*" } | ForEach-Object { 
        $branch = $_.Trim()
        if ($branch) {
            git branch -d $branch
            Write-Host "   ✓ Eliminada: $branch" -ForegroundColor Gray
        }
    }
    
    # Limpiar referencias remotas
    Write-Host "🌐 Limpiando referencias remotas..." -ForegroundColor Blue
    git remote prune origin
    
    Write-Host "✅ Limpieza completada" -ForegroundColor Green
}

function Show-Status {
    Write-Host "📊 Estado del repositorio GitFlow" -ForegroundColor Cyan
    Write-Host "=================================" -ForegroundColor Cyan
    
    # Rama actual
    $currentBranch = git rev-parse --abbrev-ref HEAD
    Write-Host "📍 Rama actual: $currentBranch" -ForegroundColor Yellow
    
    # Estado de trabajo
    $status = git status --porcelain
    if ($status) {
        Write-Host "📝 Cambios pendientes:" -ForegroundColor Red
        git status --short
    } else {
        Write-Host "✅ Directorio de trabajo limpio" -ForegroundColor Green
    }
    
    # Ramas locales
    Write-Host "`n🌿 Ramas locales:" -ForegroundColor Blue
    git branch
    
    # Últimos commits
    Write-Host "`n📜 Últimos commits:" -ForegroundColor Blue
    git log --oneline -5
}

# Ejecutar comando
switch ($Command) {
    "feature" { Start-Feature -FeatureName $Name }
    "release" { Start-Release -ReleaseVersion $Name }
    "hotfix" { Start-Hotfix -HotfixName $Name }
    "sync" { Sync-Branches }
    "clean" { Clean-Branches }
    "status" { Show-Status }
    default { 
        Write-Host "❌ Comando no reconocido: $Command" -ForegroundColor Red
        Write-Host "Comandos disponibles: feature, release, hotfix, sync, clean, status" -ForegroundColor Yellow
    }
}

Write-Host "`n💡 Para más información, consulta GITFLOW.md" -ForegroundColor Cyan
