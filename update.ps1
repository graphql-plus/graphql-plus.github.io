Write-Host "GitHub Actions ..."
npx actions-up --yes

Write-Host "NPM ..."
npx npm-check-updates -u
npm install

Write-Host "Dotnet Tools ..."
dotnet tool update --all

npx prettier -w .
