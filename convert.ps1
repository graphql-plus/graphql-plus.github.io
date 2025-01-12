$graphQlPlusDir = "samples\Schema"
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
      $sections[$section] | Set-Content "$graphQlPlusDir\Intro_$section.graphql+"
    }
  }
}

$prefixes = @("", "dual-", "input-", "output-")

function Add-Errors($base, $type, $label = "") {
  $suffix = $type.ToLower()
  $expected = "samples/$name/$base.$suffix-errors"
  if (Test-Path $expected) {
    "##### Expected $type errors $label`n" | Add-Content $file
    Get-Content $expected | Foreach-Object { "- ``$_``" } | Add-Content $file
    "" | Add-Content $file
  }
}

$toc = @{}

Remove-Item gqlp-samples/* -Recurse -Force -ErrorAction Ignore

Get-ChildItem ./samples -Directory -Name | ForEach-Object {
  $name = $_
  $file = "gqlp-samples/$name.md"

  "# $name Samples`n" | Set-Content $file
  "## Root`n" | Add-Content $file

  $toc[$name] = @()

  $section = ""

  Get-ChildItem "samples/$name" -Recurse -File -Name | ForEach-Object {
    if ($_ -notmatch ".*\.g.*") {
      return
    }

    $path = $_ -split '\\'
    if ($path.Count -gt 1) {
      if ($path[0] -ne $section) {
        $section = $path[0]
        $dir = "gqlp-samples/$name"
        New-Item $dir -ItemType Directory -ErrorAction Ignore | Out-Null
        $file = "$dir/$section.md"
        "# $section $name Samples`n" | Set-Content $file
        $toc[$name] += $section
      }
      $sample = $path[1]
    } else {
      $sample = $_
    }

    "### $sample`n" | Add-Content $file
    "``````gqlp" | Add-Content $file
    Get-Content "samples/$name/$_" | Add-Content $file
    "```````n" | Add-Content $file

    $base = ($_ -split '\.g')[0]
    if ($_ -match 'Invalid') {
      foreach ($prefix in $prefixes) {
        $prefixed = $base -replace '\\',"/$prefix"
        $label = $prefix.ToUpperInvariant()[0] + $prefix -replace '-', ''
        Add-Errors $prefixed "Parse" $label
        Add-Errors $prefixed "Verify" $label
      }
    } else {
      Add-Errors $base "Parse"
      Add-Errors $base "Verify"
    }
  }
}

$file = "gqlp-samples/toc.yml"
foreach ($name in $toc.Keys | Sort-Object) {
  "- name: $name`n  href: $name.md`n  items:" | Add-Content $file
  foreach ($section in $toc[$name]) {
    "    - name: $section`n      href: $name/$section.md" | Add-Content $file
  }
}

prettier -w .

Get-ChildItem ./.peg -Filter *.pegjs | ForEach-Object {
  Write-Host "PEG linting $_"
  npx peggy $_.FullName
}
