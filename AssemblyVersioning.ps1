Param (
    [Parameter(Mandatory = $true, HelpMessage = "git branch name")][string]$branchName)
Write-Host "Assembly Info Fun"
Write-Host "Branch: $branchName"

$modBranchIndikator = "modules"

if ($branchName.ToLower() -eq "main") {
    Write-Host "Working on Kernel"
    $assInfoFile = "Properties\AssemblyInfo.cs"
    $lastTagInfo = $(git tag -l Kernel*)
    Write-Host "Last Tag on main $lastTagInfo"
    
} 
elseif ($branchName.Contains($modBranchIndikator)) {
    Write-Host "Working on Module"

}
else {
    Write-Host "Not a valid branchname for auto versioning"
}


#1. Bachname [mods/UPS/hotfix or mods/UPS/feature  or mods/UPS/breaking ]  -> project name finden (assinfo darin)
#2. Letzten Tage des Modul suche z.B: UPS_1.2.5.60
#2.1 Tag des Kernel suchen 4.5.6.7
#3. Neue Version ermitteln UPS_1.2.5.61 oder UPS_1.2.6.0 oder UPS_1.3.0.0
#3. assInfo setzen  aus Major von Kernel + Modul minors: UPS 4.2.5.61
#4. als Tag setzen


function FunctionName {


    Write-Host "$(Build.SourceBranch)"

    # Write your PowerShell commands here.

    Write-Host "Hello World $(buildVersion)"

    $buildNumber = "$(buildVersion)"
    $pattern = '\[assembly: AssemblyVersion\("(.*)"\)\]'
    $AssemblyFiles = Get-ChildItem . AssemblyInfo.cs -rec

    foreach ($file in $AssemblyFiles) {
        Write-Host "File:  $file.PSPath"
        (Get-Content $file.PSPath) | ForEach-Object {
            if ($_ -match $pattern) {
                '[assembly: AssemblyVersion("{0}")]' -f $buildNumber
            }
            else {
                # Output line as is
                $_
            }
        } | Set-Content $file.PSPath

    }
    
}