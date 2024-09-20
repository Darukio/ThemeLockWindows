param(
    [switch]$preventChange
)

# Verificar si el script se esta ejecutando como administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # Reiniciar el script con privilegios de administrador
    if ($preventChange) {
        $newProcess = Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" -preventChange" -Verb RunAs
    } else {
        $newProcess = Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    }
    # Salir del script actual
    exit
}

# Ruta de la politica en el registro
$registryPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop"

# Nombre del valor de la politica
$policyName = "NoChangingWallpaper"

# Crear la clave si no existe
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force
}

# Establecer el valor de la politica
if ($preventChange) {
    Set-ItemProperty -Path $registryPath -Name $policyName -Value 1
    Write-Output "La politica 'Prevent changing desktop background' ha sido configurada correctamente."
} else {
    Set-ItemProperty -Path $registryPath -Name $policyName -Value 0
    Write-Output "La politica 'Prevent changing desktop background' ha sido desactivada."
}

# Ruta de la politica en el registro para evitar cambiar el tema
$themeRegistryPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$themePolicyName = "NoThemesTab"

# Crear la clave si no existe
if (-not (Test-Path $themeRegistryPath)) {
    New-Item -Path $themeRegistryPath -Force
}

# Establecer el valor de la politica para cambiar el tema
if ($preventChange) {
    Set-ItemProperty -Path $themeRegistryPath -Name $themePolicyName -Value 1
    Write-Output "La politica 'Prevent changing theme' ha sido configurada correctamente."
} else {
    Set-ItemProperty -Path $themeRegistryPath -Name $themePolicyName -Value 0
    Write-Output "La politica 'Prevent changing theme' ha sido desactivada."
}