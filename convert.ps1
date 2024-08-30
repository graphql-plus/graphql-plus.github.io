$graphQlPlusDir = "samples\Schema\Intro"
New-Item $graphQlPlusDir -ItemType Directory -ErrorAction Ignore | Out-Null

Get-ChildItem ./graphql-plus -Filter *.md | ForEach-Object {
  $all = @{}
  $sections = @{ "Complete" = @() }
  $current = @()
  $type = ""
  $doc = @()
  $end = $false
  $name = $_.Name.Substring(0,5)

  $_ | Get-Content | ForEach-Object {
    if ($end) { return }
    $doc += @($_)

    if ($_ -match "^### ([-a-zA-Z]+)") {
      $section = $Matches[1]
    }
    
    if ($type) {
      if ($_ -eq "``````") {
        $all[$type] += $current + @("")

        if ($type -eq "gqlp" -and $section) {
          $sections[$section] += $current + @()
          $sections["Complete"] += $current + @()
        }

        $type = ""
      } else {
        $current += @($_)
      }
    } else {
      if ($_ -match "^## Complete") {
        if ($all.Keys -contains "PEG") {
          $doc += @("", "``````PEG") + $all["PEG"] + @("``````")
          
          $all["PEG"] -replace ' \| ', ' / ' | Set-Content ".peg/$name.pegjs"
          Get-Content ".peg/$name.def" | Add-Content ".peg/$name.pegjs"
          if ($name -ne "Defin") {
            Get-Content ".peg/Defin.pegjs" | Add-Content ".peg/$name.pegjs"
          }

          $end = $true
        } elseif ($all.Keys -contains "gqlp") {
          $doc += @("", "``````gqlp") + $all["gqlp"] + @("``````")
          $end = $true
        }        
      }

      if ($_ -match "``````(\w+)") {
        $type = $Matches[1]
        $current = @()
      }
    }
  }
  $doc | Set-Content $_.FullName

  if ($name -eq "Intro") {
    foreach ($section in $sections.Keys) {
      $sections[$section] | Set-Content "$graphQlPlusDir\$section.graphql+"
    }
  }
}

prettier -w .

Get-ChildItem ./.peg -Filter *.pegjs | ForEach-Object {
  Write-Host "PEG linting $_"
  npx peggy $_.FullName
}
