#=============================================================#
#NAME: exerciceAUDIT1services.ps1                             #
#AUTHOR: TESSIER Maxence, BTS SIO                             #
#DATE: 11/04/2023                                             #
#                                                             #
#VERSION 1.0                                                  #
#COMMENTS:                                                    #
#                                                             #
#=============================================================#

# Obtient la date et l'heure actuelles
$date = Get-Date
# Convertit la date en format de chaîne de caractères
$dateString = $date.ToString("yyyy-MM-dd HH:mm:ss")
# Nom du fichier de sortie
$fileName = "auditServices.txt"
# Répertoire de sortie
$outputDirectory = "C:\Git_CUB\contextecubsituation11"

# Vérifie l'activité des services DHCP, DNS et AD
$dhcpService = Get-Service -Name dhcp | Select-Object -Property Name, Status
$dnsService = Get-Service -Name dns | Select-Object -Property Name, Status
$adService = Get-Service -Name adws | Select-Object -Property Name, Status

# Chemin complet du fichier de sortie
$outputPath = Join-Path -Path $outputDirectory -ChildPath $fileName

# Écrit les résultats dans le fichier de sortie
Add-Content -Path $outputPath -Value "Rapport d'audit des services"
Add-Content -Path $outputPath -Value "Date d'exécution du script : $dateString"
Add-Content -Path $outputPath -Value "Service DHCP : $($dhcpService.Name), État : $($dhcpService.Status)"
Add-Content -Path $outputPath -Value "Service DNS : $($dnsService.Name), État : $($dnsService.Status)"
Add-Content -Path $outputPath -Value "Service AD : $($adService.Name), État : $($adService.Status)"

Write-Host "Le rapport d'audit a été créé dans le fichier : $outputPath"

