# GitFlow - Banking ADN V3

## 📌 Resumen de GitFlow

GitFlow es un modelo de ramificación que define un flujo de trabajo estricto diseñado alrededor del lanzamiento del proyecto. Proporciona un marco robusto para gestionar proyectos más grandes.

## 🌳 Estructura de Ramas

### Ramas Principales

#### `main` (Producción)
- **Propósito**: Contiene código en producción
- **Protección**: ✅ Protegida - Solo merge via PR
- **Deploy**: Automático a producción
- **Regla**: Solo código estable y probado

#### `develop` (Integración)
- **Propósito**: Rama de integración para desarrollo
- **Protección**: ✅ Protegida - Solo merge via PR
- **Base**: Para crear features, releases y hotfixes
- **Regla**: Código funcional pero no necesariamente estable

### Ramas de Soporte

#### `feature/` (Nuevas Funcionalidades)
```bash
# Crear feature
git checkout develop
git checkout -b feature/nombre-corto

# Ejemplo
git checkout -b feature/filtros-avanzados
git checkout -b feature/dashboard-metricas
```

#### `release/` (Preparación de Versión)
```bash
# Crear release
git checkout develop
git checkout -b release/1.2.0

# Ejemplo
git checkout -b release/1.0.0
git checkout -b release/2.1.0
```

#### `hotfix/` (Correcciones Urgentes)
```bash
# Crear hotfix
git checkout main
git checkout -b hotfix/descripcion-breve

# Ejemplo
git checkout -b hotfix/correccion-login
git checkout -b hotfix/error-transacciones
```

## 🔄 Flujo de Trabajo

### 1. Desarrollo de Nueva Funcionalidad

```bash
# 1. Crear rama feature desde develop
git checkout develop
git pull origin develop
git checkout -b feature/nueva-funcionalidad

# 2. Desarrollar y hacer commits
git add .
git commit -m "feat(modulo): descripción de la funcionalidad"

# 3. Push de la rama
git push -u origin feature/nueva-funcionalidad

# 4. Crear Pull Request a develop
# - Ir a GitHub/GitLab
# - Crear PR de feature/nueva-funcionalidad → develop
# - Solicitar revisión
# - Esperar aprobación y merge
```

### 2. Preparación de Release

```bash
# 1. Crear rama release desde develop
git checkout develop
git pull origin develop
git checkout -b release/1.0.0

# 2. Preparar release (versioning, changelog, etc.)
git add .
git commit -m "chore(release): prepare version 1.0.0"

# 3. Push de la rama
git push -u origin release/1.0.0

# 4. Crear PR a main Y develop
# - PR release/1.0.0 → main (para producción)
# - PR release/1.0.0 → develop (para sincronizar)
```

### 3. Hotfix de Producción

```bash
# 1. Crear rama hotfix desde main
git checkout main
git pull origin main
git checkout -b hotfix/correccion-critica

# 2. Aplicar corrección
git add .
git commit -m "fix(critico): corrección de error en producción"

# 3. Push de la rama
git push -u origin hotfix/correccion-critica

# 4. Crear PR a main Y develop
# - PR hotfix/correccion-critica → main (urgente)
# - PR hotfix/correccion-critica → develop (sincronizar)
```

## 📝 Convenciones de Commits (Conventional Commits)

### Formato
```
<tipo>(ámbito): descripción

[cuerpo opcional]

[pie opcional]
```

### Tipos de Commit
- **feat**: Nueva funcionalidad
- **fix**: Corrección de bug
- **docs**: Cambios en documentación
- **style**: Cambios de formato (espacios, punto y coma, etc.)
- **refactor**: Refactorización de código
- **test**: Agregar o modificar tests
- **chore**: Tareas de mantenimiento

### Ejemplos
```bash
feat(auth): add Google login integration
fix(transaction): resolve amount calculation error
docs(readme): update installation instructions
style(css): format sidebar styles
refactor(model): optimize database queries
test(unit): add tests for user validation
chore(deps): update package dependencies
```

## 🏷️ Versionado Semántico (SemVer)

### Formato: MAJOR.MINOR.PATCH

- **MAJOR**: Cambios incompatibles en la API
- **MINOR**: Nuevas funcionalidades compatibles
- **PATCH**: Correcciones de bugs compatibles

### Ejemplos
- `1.0.0` → Primera versión estable
- `1.1.0` → Nueva funcionalidad
- `1.1.1` → Corrección de bug
- `2.0.0` → Cambio mayor incompatible

## 🛡️ Protección de Ramas

### Configuración Requerida

#### Rama `main`
- ✅ Require pull request reviews (mínimo 1)
- ✅ Require status checks to pass
- ✅ Require branches to be up to date
- ✅ Include administrators
- ❌ Allow force pushes
- ❌ Allow deletions

#### Rama `develop`
- ✅ Require pull request reviews (mínimo 1)
- ✅ Require status checks to pass
- ✅ Require branches to be up to date
- ❌ Allow force pushes
- ❌ Allow deletions

## 🚀 Comandos Útiles

### Configuración Inicial
```bash
# Clonar repositorio
git clone https://github.com/quintana1308/banking_ia.git
cd banking_ia

# Configurar ramas de tracking
git checkout develop
git pull origin develop
```

### Sincronización
```bash
# Actualizar develop
git checkout develop
git pull origin develop

# Actualizar main
git checkout main
git pull origin main
```

### Limpieza
```bash
# Eliminar ramas locales ya mergeadas
git branch --merged develop | grep -v "develop\|main" | xargs -n 1 git branch -d

# Eliminar referencias remotas obsoletas
git remote prune origin
```

## 📋 Checklist de Pull Request

### Antes de Crear PR
- [ ] Código funciona correctamente
- [ ] Tests pasan (si existen)
- [ ] Código sigue estándares del proyecto
- [ ] Commit messages siguen Conventional Commits
- [ ] Rama está actualizada con base target

### Revisión de PR
- [ ] Código revisado por al menos 1 persona
- [ ] Funcionalidad probada
- [ ] No hay conflictos
- [ ] CI/CD pasa (si existe)

## 🎯 Mejores Prácticas

### DO ✅
- Usar nombres descriptivos para ramas
- Hacer commits pequeños y frecuentes
- Escribir mensajes de commit claros
- Mantener ramas actualizadas
- Eliminar ramas después del merge

### DON'T ❌
- Hacer push directo a main/develop
- Crear ramas con nombres genéricos
- Hacer commits con mensajes vagos
- Mantener ramas obsoletas
- Hacer force push en ramas compartidas

## 🆘 Resolución de Problemas

### Conflictos de Merge
```bash
# 1. Actualizar rama base
git checkout develop
git pull origin develop

# 2. Rebase tu rama
git checkout feature/mi-feature
git rebase develop

# 3. Resolver conflictos manualmente
# 4. Continuar rebase
git rebase --continue

# 5. Force push (solo en tu rama)
git push --force-with-lease origin feature/mi-feature
```

### Deshacer Cambios
```bash
# Deshacer último commit (mantener cambios)
git reset --soft HEAD~1

# Deshacer último commit (eliminar cambios)
git reset --hard HEAD~1

# Revertir commit específico
git revert <commit-hash>
```

---

## 📞 Soporte

Para dudas sobre GitFlow:
1. Revisar esta documentación
2. Consultar con el equipo de desarrollo
3. Crear issue en el repositorio

**Última actualización**: Diciembre 2024
