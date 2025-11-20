# Portfolio DevOps Pipeline

A complete DevOps pipeline for a React portfolio application with infrastructure as code, policy enforcement, and automated deployment.

## Architecture Overview

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   GitHub Repo   │───▶│  GitHub Actions  │───▶│   Azure Cloud   │
│                 │    │                  │    │                 │
│ • React App     │    │ • Build & Test   │    │ • ACR Registry  │
│ • Terraform     │    │ • Docker Build   │    │ • AKS Cluster   │
│ • K8s Manifests │    │ • OPA Policies   │    │ • Key Vault     │
│ • Ansible       │    │ • Deploy to AKS  │    │ • Virtual Network│
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

## Project Structure

```
├── app/                    # React portfolio application
├── infrastructure/         # Terraform infrastructure code
├── kubernetes/            # Kubernetes manifests
├── ansible/              # Ansible configuration
├── policies/             # OPA policies
├── .github/workflows/    # CI/CD pipelines
└── docker/              # Docker configurations
```

## Quick Start

1. **Prerequisites**
   - Azure CLI installed and configured
   - Terraform Cloud account
   - GitHub repository with secrets configured

2. **Deploy Infrastructure**
   ```bash
   cd infrastructure
   terraform init
   terraform plan
   terraform apply
   ```

3. **Build and Deploy Application**
   - Push to main branch triggers CI/CD pipeline
   - Application builds, tests, and deploys automatically

## End-to-End Flow

### 🔄 Complete Pipeline Flow

1. **Developer commits code** → GitHub repository
2. **GitHub Actions triggers** → Three parallel workflows:
   - **Infrastructure Pipeline**: Validates Terraform → Runs OPA policies → Deploys Azure resources
   - **Application Pipeline**: Tests React app → Builds Docker image → Pushes to ACR → Deploys to AKS
   - **Ansible Pipeline**: Configures bastion host with monitoring tools

3. **Infrastructure Deployment**:
   ```
   Code Push → Terraform Validate → OPA Policy Check → Azure Resources Created
   (Resource Group, AKS, ACR, Key Vault, VNet)
   ```

4. **Application Deployment**:
   ```
   Code Push → npm test → Docker Build → ACR Push → AKS Deploy → Health Check
   ```

5. **End Result**: React portfolio running on AKS cluster, accessible via LoadBalancer/Ingress

### 🎯 What Happens When You Push Code

**Infrastructure Changes** (`infrastructure/` folder):
- Terraform validates configuration
- OPA policies check security compliance (no public AKS, required tags)
- Resources deployed to Azure via Terraform Cloud
- Outputs stored for application deployment

**Application Changes** (`app/`, `docker/`, `kubernetes/` folders):
- React app tested with Jest
- Multi-stage Docker image built (Node.js build → Nginx serve)
- Image pushed to Azure Container Registry
- Kubernetes manifests applied to AKS cluster
- Application accessible at configured endpoint

**Configuration Changes** (`ansible/` folder):
- Bastion host configured with Docker, kubectl, Azure CLI
- Node Exporter installed for monitoring
- SSH access configured for management

## Components

- **Infrastructure**: Azure Resource Group, ACR, AKS, Key Vault, VNet
- **Application**: React portfolio with Tailwind CSS
- **CI/CD**: GitHub Actions with multi-stage pipeline
- **Security**: OPA policy enforcement, Key Vault integration
- **Monitoring**: Basic logging and health checks
