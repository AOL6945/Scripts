# ==================================================================
# Script : transfert_data.ps1
# Auteur : AIT OUAKLI LARBI
# Description : Script de transfert de données entre deux postes.
# Propulsé par : AIT OUAKLI LARBI
# CIUSSS du Nord-de-l'Île-de-Montréal
# ==================================================================

Clear-Host

Function Copy-Dossiers {
    param (
        [ValidateRange(1,4)]
        [int]$valeur
    )

    $pccible         = Read-Host "`n`tEntrez le nom de l'ordinateur Source (Ex. CNMTLO112233 )      "
    $pcdestination   = Read-Host "`n`tEntrez le nom de l'ordinateur Destination (Ex. CNMTLO112233 ) "
    $usercible       = Read-Host "`n`tEntrez le nom d'utilisateur source                            "
    $userdestination = Read-Host "`n`tEntrez le nom d'utilisateur destination                       "


    Write-Host "`nDémarrage du transfert de données pour l'utilisateur $usercible... vers $userdestination" -ForegroundColor Cyan


    function Copier($source, $destination) {
        if (Test-Path $source) {
	    #Robocopy $source $destination /E /COPYALL /R:1 /W:1
            Copy-Item $source -Destination $destination -Recurse -ErrorAction SilentlyContinue
        } else {
            Write-Host "⚠️ Dossier introuvable : $source" -ForegroundColor Yellow
        }
    }

    switch ($valeur) {
        1 { Copier "\\$pccible\C$\Users\$usercible\Desktop\*"     "\\$pcdestination\C$\Users\$userdestination\Desktop\" }
        2 { Copier "\\$pccible\C$\Users\$usercible\Documents\*"   "\\$pcdestination\C$\Users\$userdestination\Documents\" }
        3 { Copier "\\$pccible\C$\Users\$usercible\Downloads\*"   "\\$pcdestination\C$\Users\$userdestination\Downloads\" }
        4 {
            Copier "\\$pccible\C$\Users\$usercible\Desktop\*"     "\\$pcdestination\C$\Users\$userdestination\Desktop\" 
            Copier "\\$pccible\C$\Users\$usercible\Documents\*"   "\\$pcdestination\C$\Users\$userdestination\Documents\" 
            Copier "\\$pccible\C$\Users\$usercible\Downloads\*"   "\\$pcdestination\C$\Users\$userdestination\Downloads\" 
        }
    }

    Write-Host "`n✅ Transfert terminé avec succès !" -ForegroundColor Green
}

Function Affich-Menu {
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


    Write-Host "`n`nTRANSFERT DE DONNÉES" -ForegroundColor Cyan
    Write-Host "`n`t[1]`tBureau"
    Write-Host "`t[2]`tMes Documents"
    Write-Host "`t[3]`tTéléchargements"
    Write-Host "`t[4]`tTout (1,2 et 3)"
    Write-Host "`n`t[5]`tQuitter..." -ForegroundColor DarkRed

    $choix = Read-Host "`nEntrez votre choix"

    switch ($choix) {
        1 { Copy-Dossiers -valeur 1 }
        2 { Copy-Dossiers -valeur 2 }
        3 { Copy-Dossiers -valeur 3 }
        4 { Copy-Dossiers -valeur 4 }
        5 { exit 0 }
        default { Write-Host "`n❌ Choix invalide, veuillez réessayer." -ForegroundColor Red }
    }
    Pause
}

# Boucle principale
do {
    Affich-Menu
} while ($true)
