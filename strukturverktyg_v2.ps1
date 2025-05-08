# FUNKTION 1

# Funktion för att skapa mappstrukturen om den inte redan existerar
function Create_Folder_If_Not_Exists { # Definierar funktionen och skapar ett anropsnamn
    param ( # Deklarerar en parameter till funktionen
        [string]$Path # [string] definierar datatypen för parametern
    )
    try { # Block som PS ska försöka köra
        if (-Not (Test-Path -Path $Path)) { # Testar om sökvägen existerar
            New-Item -ItemType Directory -Path $Path -Force | Out-Null # Ny mapp skapa om den inte redan finns
            Write-Host "The folder '$Path' was successfully created." # Meddelar användaren att mappen skapats
        }
        else {
            Write-Host "The folder '$Path' already exists." # Meddelar att mappen redan existerar
        }
    } catch {
        Write-Error "Failed to create folder '$Path': $_" # Meddelar användare att ett fel uppstått $_ ersätts av felet
    }
}

# FUNKTION 2

# Funktion för att skapa logfil
function Create_Log_File {
    param (
        [string]$FolderPath # [string] definierar datatypen för parametern
    )
    try {
        $timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss" #Skapar variabel för tidsfomat
        $fileName = "log-$timestamp.txt" # Skapar logfilen 
        $fullPath = Join-Path -Path $FolderPath -ChildPath $fileName # Skapar full sökväg till logfilen
        $logText = "Struktur skapad $timestamp" # Skapar strukturen för hur loggen ska se ut
        Add-Content -Path $fullPath -Value $logText # Skapar en log
        Write-Host "Log file '$fileName' was created in '$FolderPath'." # Meddelar att logfilen skapats
    } catch {
        Write-Error "Failed to create log file: $_" # Meddelar att logfilen inte kunde skapas
    }
}

# PROGRAM

# Program för skapa mappstrukturen och skapa log genom att kalla på funktionerna
$name = Read-Host "What's your folder's name?" # Ber användaren att döpa sin mapp
$basePath = Join-Path -Path (Get-Location) -ChildPath $name # Skapar en full sökväg till huvudmappen

Create_Folder_If_Not_Exists -Path $basePath # Anropar funktionen Create-FolderIfNotExists

# Loop för att skapa mapparna om de inte redan finns
$subFolders = @("logs", "scripts", "temp") # Skapar en array med de mappar som ska skapas
foreach ($sub in $subFolders) {
    $fullSubPath = Join-Path -Path $basePath -ChildPath $sub # Skapar full sökväg till mappen som skapas
    Create_Folder_If_Not_Exists -Path $fullSubPath # Skickar sökvägen till funktionen om den inte redan existerar
}

# Skapa loggfil i logs-mappen
$logsPath = Join-Path -Path $basePath -ChildPath "logs" # Skapar sökvägen till logs
Create_Log_File -FolderPath $logsPath # Anropar funktionen Create-logFile
