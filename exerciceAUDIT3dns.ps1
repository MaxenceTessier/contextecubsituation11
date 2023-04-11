#=============================================================#
#NAME: exerciceAUDIT3dns.ps1                                  #
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
$fileName = "auditDNS.txt"
# Répertoire de sortie
$outputDirectory = "C:\Git_CUB\contextecubsituation11\Audit"

# Chemin complet du fichier de sortie
$outputPath = Join-Path -Path $outputDirectory -ChildPath $fileName

# Obtient les enregistrements de type A du serveur DNS
$dnsRecords = Get-DnsServerResourceRecord -ZoneName "local.edimbourg.cub.sioplc.fr" -RRType A |
    Select-Object -Property HostName, RecordData |
    ForEach-Object {
        [PSCustomObject]@{
            HostName = $_.HostName
            IPAddress = $_.RecordData.IPv4Address.IPAddressToString
        }
    }

# Écrit les résultats dans le fichier de sortie
Add-Content -Path $outputPath -Value "Rapport d'audit des enregistrements de type A du serveur DNS"
Add-Content -Path $outputPath -Value "Date d'exécution du script : $dateString"
Add-Content -Path $outputPath -Value ""
$dnsRecords | Format-Table -Property HostName, IPAddress | Out-String | Add-Content -Path $outputPath

Write-Host "Le rapport d'audit a été créé dans le fichier : $outputPath"
