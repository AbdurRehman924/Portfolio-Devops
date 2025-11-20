#!/bin/bash

set -e

echo "🚀 Setting up Portfolio DevOps Pipeline"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if required tools are installed
check_tool() {
    if ! command -v $1 &> /dev/null; then
        echo -e "${RED}❌ $1 is not installed${NC}"
        return 1
    else
        echo -e "${GREEN}✅ $1 is installed${NC}"
        return 0
    fi
}

echo "📋 Checking prerequisites..."
check_tool "az" || { echo "Please install Azure CLI"; exit 1; }
check_tool "terraform" || { echo "Please install Terraform"; exit 1; }
check_tool "kubectl" || { echo "Please install kubectl"; exit 1; }
check_tool "docker" || { echo "Please install Docker"; exit 1; }
check_tool "opa" || { echo "Please install OPA"; exit 1; }

echo -e "\n🔐 Setting up Azure authentication..."
if ! az account show &> /dev/null; then
    echo "Please login to Azure:"
    az login
fi

SUBSCRIPTION_ID=$(az account show --query id -o tsv)
echo "Using subscription: $SUBSCRIPTION_ID"

echo -e "\n🏗️  Creating service principal for Terraform..."
SP_NAME="portfolio-devops-sp"
SP_JSON=$(az ad sp create-for-rbac --name $SP_NAME --role Contributor --scopes /subscriptions/$SUBSCRIPTION_ID --sdk-auth)

echo -e "\n📝 GitHub Secrets to configure:"
echo -e "${YELLOW}Add these secrets to your GitHub repository:${NC}"
echo "ARM_CLIENT_ID: $(echo $SP_JSON | jq -r .clientId)"
echo "ARM_CLIENT_SECRET: $(echo $SP_JSON | jq -r .clientSecret)"
echo "ARM_SUBSCRIPTION_ID: $(echo $SP_JSON | jq -r .subscriptionId)"
echo "ARM_TENANT_ID: $(echo $SP_JSON | jq -r .tenantId)"
echo "AZURE_CREDENTIALS: $SP_JSON"

echo -e "\n🔧 Initializing Terraform..."
cd infrastructure
terraform init

echo -e "\n✅ Setup complete!"
echo -e "${GREEN}Next steps:${NC}"
echo "1. Add the GitHub secrets shown above"
echo "2. Update terraform cloud organization in infrastructure/main.tf"
echo "3. Push to main branch to trigger infrastructure deployment"
echo "4. Configure your domain/DNS for the application"
