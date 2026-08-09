Write-Host "GitHub Actions ..."
npx -y actions-up --style preserve --yes

Write-Host "NPM ..."
npx -y npm-check-updates -u
npm install

Write-Host "Dotnet Tools ..."
dotnet tool update --all

Write-Host "Formatting files ..."
npx -y biome format --write .
