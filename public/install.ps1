[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
# 1. Detect Architecture
$Arch = "x86_64"
if ([System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture -eq "Arm64") {
    $Arch = "aarch64"
}

# 2. Construct URL
$Version = "latest" # Or "v0.0.2"
$FileName = "sui-runner-windows-$Arch.zip"
$Url = "https://github.com/MikeyA-yo/sui-runner/releases/$Version/download/$FileName"

# 3. Setup Paths
$InstallDir = "$env:USERPROFILE\.sui-runner\bin"
if (!(Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Force -Path $InstallDir
}

$ZipFile = "$env:TEMP\sui-runner.zip"

# 4. Download and Extract
Write-Host "Downloading Sui-runner for Windows ($Arch)..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $Url -OutFile $ZipFile

Write-Host "Extracting..." -ForegroundColor Cyan
Expand-Archive -Path $ZipFile -DestinationPath $InstallDir -Force

# 5. Cleanup
Remove-Item $ZipFile

# 6. PATH Check and Final Instructions
Write-Host "--------------------------------------------------" -ForegroundColor Green
Write-Host "Sui-runner installed to $InstallDir\sui-runner.exe" -ForegroundColor Green

# Standardized Path Update Logic
$UserPath = [Environment]::GetEnvironmentVariable("Path", "User")

if ($UserPath -notlike "*$InstallDir*") {
    Write-Host "Updating environment variables..."
    
    # 1. Update the persistent User Registry
    $NewPath = "$UserPath;$InstallDir"
    [Environment]::SetEnvironmentVariable("Path", $NewPath, "User")
    
    # 2. Update the CURRENT session so the user can use it immediately
    $env:Path = "$env:Path;$InstallDir"
    
    # 3. "Broadcast" the change (This is what most scripts miss)
    # This tells other open programs (like VS Code) that the Path has changed.
    $signature = @'
[DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
public static extern IntPtr SendMessageTimeout(IntPtr hWnd, uint Msg, UIntPtr wParam, string lParam, uint fuFlags, uint uTimeout, out UIntPtr lpdwResult);
'@
    $type = Add-Type -MemberDefinition $signature -Name "Win32" -Namespace "Native" -PassThru
    $result = [UIntPtr]::Zero
    $type::SendMessageTimeout([IntPtr]0xffff, 0x001a, [UIntPtr]::Zero, "Environment", 0x02, 5000, [out]$result) | Out-Null
}