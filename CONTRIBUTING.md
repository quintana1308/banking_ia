# Guía de Contribución - Banking ADN V3

## 🚀 Inicio Rápido

### 1. Configuración Inicial
```bash
# Clonar el repositorio
git clone https://github.com/quintana1308/banking_ia.git
cd banking_ia

# Configurar Git
git config user.name "Tu Nombre"
git config user.email "tu.email@ejemplo.com"

# Configurar template de commits
git config commit.template .gitmessage
git config core.hooksPath .githooks
```

### 2. Flujo de Desarrollo

#### Para Nueva Funcionalidad
```bash
# Usar script helper
.\scripts\gitflow-helpers.ps1 feature mi-nueva-funcionalidad

# O manualmente:
git checkout develop
git pull origin develop
git checkout -b feature/mi-nueva-funcionalidad
```

#### Para Hotfix Urgente
```bash
# Usar script helper
.\scripts\gitflow-helpers.ps1 hotfix correccion-critica

# O manualmente:
git checkout main
git pull origin main
git checkout -b hotfix/correccion-critica
```

## 📝 Estándares de Código

### Mensajes de Commit
Seguimos **Conventional Commits**:

```
<tipo>(ámbito): descripción

feat(auth): add two-factor authentication
fix(transaction): resolve decimal precision error
docs(api): update endpoint documentation
```

### Nombres de Ramas
- `feature/nombre-descriptivo`
- `release/1.0.0`
- `hotfix/descripcion-breve`

### Ámbitos Comunes
- `auth` - Autenticación y autorización
- `transaction` - Gestión de transacciones
- `bank` - Cuentas bancarias
- `user` - Gestión de usuarios
- `dashboard` - Panel principal
- `api` - Endpoints y servicios
- `db` - Base de datos
- `config` - Configuración

## 🔄 Proceso de Pull Request

### 1. Antes de Crear PR
- [ ] Código funciona correctamente
- [ ] Commits siguen Conventional Commits
- [ ] Rama actualizada con base target
- [ ] Sin conflictos

### 2. Crear Pull Request
1. Ir a GitHub
2. Seleccionar rama origen → rama destino
3. Completar template de PR
4. Asignar revisores
5. Agregar labels apropiados

### 3. Template de PR
```markdown
## 📋 Descripción
Breve descripción de los cambios

## 🎯 Tipo de Cambio
- [ ] 🐛 Bug fix
- [ ] ✨ Nueva funcionalidad
- [ ] 💥 Breaking change
- [ ] 📝 Documentación

## 🧪 Testing
- [ ] Tests existentes pasan
- [ ] Nuevos tests agregados
- [ ] Testing manual completado

## 📸 Screenshots (si aplica)
Agregar capturas de pantalla

## 📝 Checklist
- [ ] Código revisado
- [ ] Commits con formato correcto
- [ ] Documentación actualizada
```

## 🛠️ Scripts Útiles

### GitFlow Helpers
```bash
# Crear feature
.\scripts\gitflow-helpers.ps1 feature nombre-feature

# Crear release
.\scripts\gitflow-helpers.ps1 release 1.0.0

# Crear hotfix
.\scripts\gitflow-helpers.ps1 hotfix descripcion

# Sincronizar ramas
.\scripts\gitflow-helpers.ps1 sync

# Limpiar ramas obsoletas
.\scripts\gitflow-helpers.ps1 clean
```

## 🏷️ Versionado

Seguimos **Semantic Versioning** (SemVer):

- `MAJOR.MINOR.PATCH`
- `1.0.0` → `1.0.1` (patch - bug fix)
- `1.0.1` → `1.1.0` (minor - nueva funcionalidad)
- `1.1.0` → `2.0.0` (major - breaking change)

## 🚨 Emergencias

### Hotfix Crítico
1. Crear hotfix desde `main`
2. Aplicar corrección mínima
3. Crear PR a `main` (urgente)
4. Crear PR a `develop` (sincronizar)
5. Deploy inmediato

### Rollback
```bash
# Revertir último commit en main
git checkout main
git revert HEAD
git push origin main
```

## 📞 Soporte

### Contactos
- **Tech Lead**: [Nombre] - [email]
- **DevOps**: [Nombre] - [email]
- **QA**: [Nombre] - [email]

### Recursos
- 📖 [GITFLOW.md](./GITFLOW.md) - Documentación completa
- 🐛 [Issues](https://github.com/quintana1308/banking_ia/issues) - Reportar bugs
- 💬 [Discussions](https://github.com/quintana1308/banking_ia/discussions) - Preguntas

## ⚡ Comandos de Emergencia

```bash
# Estado actual
git status
git log --oneline -5

# Deshacer cambios locales
git reset --hard HEAD

# Actualizar todo
git fetch --all
git pull origin develop

# Resolver conflictos
git rebase develop
# (resolver conflictos manualmente)
git rebase --continue
```

---

**¿Dudas?** Consulta la documentación completa en [GITFLOW.md](./GITFLOW.md) o contacta al equipo.
