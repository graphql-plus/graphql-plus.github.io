dotnet tool restore
nvs use 26
try
{
    dotnet tool run docfx -s -p 8765
} finally
{
    nvs use default
}
