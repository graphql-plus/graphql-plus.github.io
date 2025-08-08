$specificationDir = "samples\Schema\Specification"
New-Item $specificationDir -ItemType Directory -ErrorAction Ignore | Out-Null

$specifications = "Intro", "Reque"

Get-ChildItem ./graphql-plus -Filter *.md | ForEach-Object {
  $all = @{}
  $complete = "!" + $_.BaseName
  $sections = @{ $complete = @() }
  $current = @()
  $type = ""
  $doc = @()
  $end = $false
  $name = $_.Name.Substring(0,5)

  $_ | Get-Content | ForEach-Object {
    if ($end) { return }
    $doc += @($_)

    if ($_ -match "^## ([-a-zA-Z]+)") {
      $section =  "+" + $Matches[1]
    }

    if ($_ -match "^### ([-a-zA-Z]+)") {
      $subSection = $Matches[1]
    }
    
    if ($type) {
      if ($_ -eq "``````") {
        $all[$type] += $current + @("")

        if ($type -eq "gqlp" -and $subSection) {
          $sections[$subSection] += $current + @("")
          $sections[$section] += $current + @("")
          $sections[$complete] += $current + @("")
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

  if ($specifications -contains $name) {
    foreach ($section in $sections.Keys) {
      $sections[$section] | Set-Content "$specificationDir\$name`_$section.graphql+"
    }
  }
}

$suffixes = @("", "dual", "input", "output")

function Add-Errors($base, $suffix, $type, $label = "") {
  $extn = $type.ToLower()
  $expected = "samples/$name/$base.$extn-errors"
  $label = ""
  if ($suffix) {
    $expected = "samples/$name/$base+$suffix.$extn-errors"
    $label = $suffix.ToUpperInvariant()[0] + $suffix.Substring(1)
  }
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
      $head = $path[0]
      if (($_ -match 'Invalid') -and ($head -ne 'Invalid')) {
        $head += "-Invalid"
      }
      if ($head -ne $section) {
        $section = $head
        $dir = "gqlp-samples/$name"
        New-Item $dir -ItemType Directory -ErrorAction Ignore | Out-Null
        $file = "$dir/$section.md"
        "# $section $name Samples`n" | Set-Content $file
        $toc[$name] += $section
      }
    }

    "### $($path[-1])`n" | Add-Content $file
    if ($_ -match '.*ql.*') {
      "``````gqlp" | Add-Content $file
    } else {
      "``````" | Add-Content $file
    }
    Get-Content "samples/$name/$_" | Add-Content $file
    "```````n" | Add-Content $file

    $base = ($_ -split '\.g')[0]
    $response = "samples/$name/$base.resp"
  if (Test-Path $response) {
    "##### Expected response $base.resp`n" | Add-Content $file
    "``````" | Add-Content $file
    Get-Content $response | Add-Content $file
    "```````n" | Add-Content $file
  }


    if ($_ -match 'Invalid') {
      foreach ($suffix in $suffixes) {
        Add-Errors $base $suffix "Parse"
        Add-Errors $base $suffix "Verify"
      }
    } else {
      Add-Errors $base "" "Parse"
      Add-Errors $base "" "Verify"
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
