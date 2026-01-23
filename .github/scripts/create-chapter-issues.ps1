# GitHub Issues Creation Script - Reusable Template
# Usage: .\create-chapter-issues.ps1 -Chapter "02" -ChapterName "Bootloader_U-Boot"

param(
    [Parameter(Mandatory=$true)]
    [string]$Chapter,
    
    [Parameter(Mandatory=$true)]
    [string]$ChapterName,
    
    [string]$Repo = "VaraprasadE/embedded-linux-mastery"
)

# Ensure gh is in PATH
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " GitHub Issues Creator" -ForegroundColor Cyan
Write-Host " Chapter: $Chapter - $ChapterName" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Create chapter-specific label
$labelName = $ChapterName.ToLower().Replace("_", "-")
Write-Host "Creating label: $labelName" -ForegroundColor Yellow
gh label create $labelName --color "3498DB" --description "Module: ${Chapter}_${ChapterName}" --repo $Repo --force 2>$null

Write-Host ""
Write-Host "Now you can create issues with:" -ForegroundColor Green
Write-Host ""
Write-Host "  gh issue create --repo $Repo \" -ForegroundColor Gray
Write-Host "    --title `"[$Chapter] Your Title`" \" -ForegroundColor Gray
Write-Host "    --body `"Description here`" \" -ForegroundColor Gray
Write-Host "    --label `"study,$labelName,priority:high`"" -ForegroundColor Gray
Write-Host ""

# Interactive mode
$continue = $true
while ($continue) {
    Write-Host "---" -ForegroundColor DarkGray
    $title = Read-Host "Enter issue title (or 'done' to exit)"
    
    if ($title -eq "done" -or $title -eq "") {
        $continue = $false
        break
    }
    
    $type = Read-Host "Type (study/hands-on)"
    $priority = Read-Host "Priority (high/medium/low) or press Enter to skip"
    
    $labels = "$type,$labelName"
    if ($priority -ne "") {
        $labels += ",priority:$priority"
    }
    if ($type -eq "hands-on") {
        $labels += ",coding"
    }
    
    $body = Read-Host "Brief description"
    
    $fullTitle = "[$Chapter] $title"
    $fullBody = "## Description`n$body`n`n📁 **Module:** ${Chapter}_${ChapterName}"
    
    Write-Host "Creating issue: $fullTitle" -ForegroundColor Yellow
    gh issue create --repo $Repo --title $fullTitle --body $fullBody --label $labels
    
    Write-Host "✓ Issue created!" -ForegroundColor Green
}

Write-Host ""
Write-Host "✅ Done! View issues at: https://github.com/$Repo/issues" -ForegroundColor Green
