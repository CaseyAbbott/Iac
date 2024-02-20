# Iac

## Build Command
```bash
az deployment group create --resource-group rg-d-test --template-file appserviceplan.bicep
```
## run the deployment before deploying it
az deployment group create --resource-group rg-d-test --template-file appserviceplan.bicep --confirm-with-what-if # -c
