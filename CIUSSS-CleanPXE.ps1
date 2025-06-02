# SCRIPT

# À exécuter localement avec des droits admin
Clear-Host
Write-Host "`nCIUSSS  - Centre intégré universitaire de santé et de services sociaux du Nord-de-l’Île-de-Montréal" -ForegroundColor Yellow
Write-Host "`t  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯"
Write-Host "`t- Département Déploiement et services" -ForegroundColor Yellow
Write-Host "`t  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯"
Write-Host "`n`n`t`t`t══════════ Réalisé par AIT OUAKLI LARBI ══════════`n" -ForegroundColor Cyan

Write-Host "`n`t`t`tVous êtes connecté en tant que  : " -NoNewline 
Write-Host $env:USERNAME -ForegroundColor Green

Write-Host "`t`t`tLe nom de votre machine est     : " -NoNewline 
Write-Host $env:COMPUTERNAME -ForegroundColor Green

Write-Host "`n`nÉtapes pour pouvoir booter de nouveau en PXE" -ForegroundColor Cyan

# Demande du nom de la machine distante
$remoteComputer = Read-Host "`nEntrez le nom du poste distant (ex: CNMTLO112233)"

# Définir les chemins distants à supprimer
$chemins = @(
    "\\$remoteComputer\C$\MININT",
    "\\$remoteComputer\C$\_SMSTaskSequence",
    "\\$remoteComputer\C$\unattend.xml"
)

# Confirmation utilisateur
$confirmation = Read-Host "`nVoulez-vous supprimer les dossiers PXE sur [$remoteComputer] ? (o/n)"

if ($confirmation -eq 'o' -or $confirmation -eq 'O') {
    foreach ($path in $chemins) {
        if (Test-Path $path) {
            Remove-Item $path -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "$path supprimé." -ForegroundColor Green
        } else {
            Write-Host "$path introuvable ou déjà supprimé." -ForegroundColor DarkYellow
        }
    }

    Write-Host "`n`tL'ordinateur [$remoteComputer] est prêt pour booter en PXE.`n" -ForegroundColor Green
} else {
    Write-Host "`nOpération annulée par l'utilisateur." -ForegroundColor Red
}
