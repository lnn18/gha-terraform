# gha-terraform

Pipeline de CI/CD para desplegar un S3 bucket en AWS usando Terraform y GitHub Actions.

## 📋 Descripción

Este proyecto automatiza el despliegue de un s3 bucket en AWS mediante Terraform, utilizando GitHub Actions como herramienta de CI/CD. El estado de Terraform se almacena de forma remota en un bucket de S3, que también sirve como backend para mantener la consistencia del estado entre ejecuciones.

## 🏗️ Arquitectura

- **Backend**: S3 bucket para almacenar el estado de Terraform (`terraform.tfstate`)
- **Provider**: AWS (región us-east-1)
- **CI/CD**: GitHub Actions
- **IaC**: Terraform >= 1.1.7

## 🚀 Funcionamiento del Pipeline

El workflow se ejecuta automáticamente en cada `push` al repositorio y realiza los siguientes pasos:

1. **Checkout**: Clona el código del repositorio
2. **Setup Terraform**: Instala Terraform v1.1.7
3. **Terraform Init**: Inicializa el backend y descarga providers
4. **Terraform Format**: Verifica el formato del código
5. **Terraform Validate**: Valida la sintaxis y configuración
6. **Terraform Plan**: Genera el plan de ejecución
7. **Terraform Apply**: Aplica los cambios en la infraestructura

## ⚙️ Configuración

### Requisitos Previos

- Cuenta de AWS con permisos adecuados
- Bucket de S3 creado para el backend de Terraform
- Repositorio en GitHub

### Secretos de GitHub

Configura los siguientes secretos en tu repositorio (Settings → Secrets and variables → Actions):

| Secreto | Descripción |
|---------|-------------|
| `AWS_ACCESS_KEY_ID` | Access Key ID de AWS |
| `AWS_SECRET_ACCESS_KEY` | Secret Access Key de AWS |

### Backend de Terraform

El estado se almacena en S3 con la siguiente configuración:

```hcl
backend "s3" {
  bucket = "244190102671-lina-figueredo"
  key    = "terraform/state.tfstate"
  region = "us-east-1"
}
```

## 📁 Estructura del Proyecto

```
gha-terraform/
├── .github/
│   └── workflows/
│       └── tf.yaml          # Pipeline de GitHub Actions
├── main.tf                  # Configuración principal de Terraform
├── .terraform.lock.hcl      # Lock file de providers
└── README.md                # Este archivo
```

## 🔧 Uso

1. **Clona el repositorio**:
   ```bash
   git clone <url-del-repositorio>
   cd gha-terraform
   ```

2. **Configura tus recursos** en `main.tf`

3. **Realiza un commit y push**:
   ```bash
   git add .
   git commit -m "Actualizar infraestructura"
   git push
   ```

4. **El pipeline se ejecutará automáticamente** y desplegará los cambios

## 📝 Notas

- El pipeline usa versiones específicas de las actions para mayor seguridad y reproducibilidad
- El comando `terraform init -reconfigure` permite reinicializar el backend si es necesario
- El plan se guarda en un archivo (`tfplan`) antes de aplicarse para garantizar consistencia

## 🔒 Seguridad

- Las credenciales de AWS se gestionan mediante GitHub Secrets
- Nunca commitees credenciales en el código
- El estado de Terraform en S3 debe tener cifrado habilitado
- Considera habilitar versionado en el bucket de S3 para el estado

