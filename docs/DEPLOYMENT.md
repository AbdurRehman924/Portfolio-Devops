# Deployment Guide

This guide walks you through deploying the Portfolio DevOps pipeline from scratch.

## Prerequisites

- Azure CLI installed and configured
- Terraform CLI (>= 1.0)
- Docker installed
- kubectl installed
- OPA (Open Policy Agent) installed
- GitHub repository with Actions enabled
- Terraform Cloud account

## Step 1: Initial Setup

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd Portfolio-Devops
   ```

2. **Run the setup script**
   ```bash
   ./scripts/setup.sh
   ```

3. **Configure Terraform Cloud**
   - Create a workspace in Terraform Cloud
   - Update `infrastructure/main.tf` with your organization name
   - Set up environment variables in Terraform Cloud workspace

## Step 2: Configure GitHub Secrets

Add these secrets to your GitHub repository (Settings → Secrets and variables → Actions):

### Azure Authentication
- `ARM_CLIENT_ID`: Service principal client ID
- `ARM_CLIENT_SECRET`: Service principal client secret  
- `ARM_SUBSCRIPTION_ID`: Azure subscription ID
- `ARM_TENANT_ID`: Azure tenant ID
- `AZURE_CREDENTIALS`: Full service principal JSON

### Terraform Cloud
- `TF_API_TOKEN`: Terraform Cloud API token

### Container Registry (will be populated after infrastructure deployment)
- `ACR_LOGIN_SERVER`: Container registry login server
- `ACR_USERNAME`: Container registry username
- `ACR_PASSWORD`: Container registry password

### AKS Configuration (will be populated after infrastructure deployment)
- `RESOURCE_GROUP_NAME`: Azure resource group name
- `AKS_CLUSTER_NAME`: AKS cluster name

### SSH Configuration (for Ansible)
- `SSH_PRIVATE_KEY`: Private key for bastion host access
- `BASTION_IP`: Bastion host IP address

## Step 3: Deploy Infrastructure

1. **Push infrastructure changes**
   ```bash
   git add infrastructure/
   git commit -m "Add infrastructure configuration"
   git push origin main
   ```

2. **Monitor the deployment**
   - Go to GitHub Actions tab
   - Watch the "Infrastructure Deployment" workflow
   - Verify policy checks pass
   - Confirm infrastructure is created

3. **Update GitHub secrets with infrastructure outputs**
   After successful deployment, update these secrets with values from Terraform outputs:
   - `ACR_LOGIN_SERVER`
   - `ACR_USERNAME` 
   - `ACR_PASSWORD`
   - `RESOURCE_GROUP_NAME`
   - `AKS_CLUSTER_NAME`

## Step 4: Deploy Application

1. **Push application changes**
   ```bash
   git add app/ docker/ kubernetes/
   git commit -m "Add application and deployment configs"
   git push origin main
   ```

2. **Monitor the deployment**
   - Watch the "Application Build and Deploy" workflow
   - Verify Docker image is built and pushed to ACR
   - Confirm application is deployed to AKS

## Step 5: Configure Bastion Host (Optional)

1. **Create a VM for bastion host**
   ```bash
   az vm create \
     --resource-group <resource-group-name> \
     --name bastion-vm \
     --image Ubuntu2204 \
     --admin-username azureuser \
     --generate-ssh-keys \
     --public-ip-sku Standard
   ```

2. **Get the public IP**
   ```bash
   az vm show -d -g <resource-group-name> -n bastion-vm --query publicIps -o tsv
   ```

3. **Update GitHub secrets**
   - `BASTION_IP`: The public IP from step 2
   - `SSH_PRIVATE_KEY`: Your private SSH key

4. **Run Ansible configuration**
   - Go to GitHub Actions
   - Run the "Configure Infrastructure with Ansible" workflow manually
   - Provide the bastion host IP

## Step 6: Verify Deployment

1. **Check AKS cluster**
   ```bash
   az aks get-credentials --resource-group <rg-name> --name <aks-name>
   kubectl get pods
   kubectl get services
   ```

2. **Test application**
   ```bash
   kubectl port-forward service/portfolio-service 8080:80
   # Open http://localhost:8080 in browser
   ```

3. **Check container registry**
   ```bash
   az acr repository list --name <acr-name>
   ```

## Troubleshooting

### Common Issues

1. **Policy violations**
   - Check OPA policy files in `policies/`
   - Ensure resources have required tags
   - Verify AKS API server access restrictions

2. **Docker build failures**
   - Check Dockerfile syntax
   - Verify app builds locally: `cd app && npm run build`

3. **Kubernetes deployment issues**
   - Check image pull secrets: `kubectl get secrets`
   - Verify ACR credentials are correct
   - Check pod logs: `kubectl logs <pod-name>`

4. **Terraform failures**
   - Check Azure permissions
   - Verify Terraform Cloud configuration
   - Check resource naming conventions

### Useful Commands

```bash
# Check infrastructure status
cd infrastructure && terraform plan

# Rebuild and push image manually
docker build -f docker/Dockerfile -t portfolio .
docker tag portfolio <acr-name>.azurecr.io/portfolio:latest
docker push <acr-name>.azurecr.io/portfolio:latest

# Debug Kubernetes
kubectl describe pod <pod-name>
kubectl logs <pod-name>
kubectl get events --sort-by=.metadata.creationTimestamp

# Test OPA policies locally
opa test policies/
```

## Security Considerations

1. **Network Security**
   - AKS API server access is restricted
   - Container registry admin access should be disabled in production
   - Use Azure Key Vault for secrets management

2. **RBAC**
   - Kubernetes RBAC is configured with minimal permissions
   - Service accounts have limited scope

3. **Image Security**
   - Multi-stage Docker builds minimize attack surface
   - Regular base image updates recommended
   - Consider image scanning in CI/CD

## Monitoring and Maintenance

1. **Application Monitoring**
   - Node Exporter is installed on bastion host
   - Consider adding Prometheus and Grafana

2. **Infrastructure Monitoring**
   - Use Azure Monitor for AKS cluster
   - Set up alerts for resource usage

3. **Updates**
   - Regularly update Kubernetes version
   - Keep base images updated
   - Review and update OPA policies
