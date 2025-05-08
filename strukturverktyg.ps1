# Frågar användaren om ett namn
$name = Read-Host "What's your folders name?"

# Skapar sökvägen till mappen
$folder_path = Join-Path -Path (Get-Location) -ChildPath $name

# Skapar en huvudmapp med namnet som användaren angav om den inte redan finns
if (-Not (Test-Path -Path $folder_path)) {
    New-Item -Path $folder_path -ItemType Directory
    Write-Host "The folder $name has been created" # Meddelar att mappen har skapats
}
else {
    Write-Host "The folder $name already exists" # Meddelar att mappen redan finns
}

# Skapar en array för undermapparna
$sub_folders = @(
    "logs",
    "scripts",
    "temp"
)

# Skapar undermapparna om de inte redan finns
foreach ($folder in $sub_folders) {
    $full_path = Join-Path -Path $folder_path -ChildPath $folder    
    if (-Not (Test-Path -Path $full_path)) {
        New-Item -ItemType Directory -Path $full_path # Skapar ny mapp för varje objekt i array "sub_folders"
        Write-Host "The folder $full_path was sucessfully created" # Meddelar för varje objekt som skapas att så har skett
    }   
    else {
        Write-Host "The folder $full_path already exists" # Meddelar att mappen redan finns
    }
}

# Skapar variabler för att skapa logfil
$date = Get-Date -Format "yyyy-MM-dd_HH-mm-ss " # Skapar variabel för dagens datum
$log_file_name = "log-$date.txt" # Skapar variabel för log filens namn
$log_folder_path = Join-Path -Path $folder_path -ChildPath "logs" # Full sökväg till mappen logs
$log_file = Join-Path -Path $log_folder_path -ChildPath $log_file_name # Full sökväg till loggfilen

# Skapar logfilen i mappen logs
Add-content -Path $log_file -Value "Struktur skapad $date"
