#=============================================================#
#NAME: exerciceAUDIT2services.ps1                             #
#AUTHOR: TESSIER Maxence, BTS SIO                             #
#DATE: 11/04/2023                                             #
#                                                             #
#VERSION 1.0                                                  #
#COMMENTS:                                                    #
#                                                             #
#=============================================================#

# Définition des variables
$currentTime = Get-Date
$outputFile = "C:\auditDHCP.txt"
$date = Get-Date -Format "yyyy-MM-dd"
$fichier = "C:\auditDHCP.txt"

# Récupération des plages DHCP présentes sur le serveur
$plages = Get-DhcpServerv4Scope

# Ecriture dans le fichier et affichage à l'écran
foreach ($plage in $plages) {
    $nom = $plage.Name
    $statut = $plage.State
    if ($statut -eq "Active") {
        Add-Content $fichier "$date - $nom : $statut"
        Write-Host "$date - $nom : $statut"
    } else {
        Add-Content $fichier "$date - $nom : $statut"
        Add-Content $fichier "$(Write-Host $date - $nom : $statut -ForegroundColor Red)"
        Write-Host $date - $nom : $statut -ForegroundColor Red
    }
}
