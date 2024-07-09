
# Définir le chemin du fichier journal
$logFile = "C:\Users\Administrateur\Documents\script.log"

# Fonction pour écrire dans le fichier journal
function Write-Log {
    param (
        [string]$message,
        [string]$level = "INFO"
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
     $username = $env:USERNAME
    $logMessage = "$timestamp [$level] [$username] $message"
    Add-Content -Path $logFile -Value $logMessage
}
Write-Log " Début de script"
do {
    # Choisir la machine
    Write-Host "Postes disponibles"
    Write-Host "1- Joris"
    Write-Host "2- PC2"

    $post = Read-Host "Choisissez la machine ?"
    # renseigner les adresse ip de vos client 
    switch ($post) {
        "1" {
            $ippost = "adress ip (ipv4 ou ipv6)"
            Write-Log "Machine choisie : Joris ($ippost)"
        }
        "2" {
            $ippost = "Adresse_IP_PC2"
            Write-Log "Machine choisie : PC2 ($ippost)"
        }
        default {
            Write-Log "Choix de machine invalide : $post"
            Write-Host "Choix invalide. Veuillez relancer le script et essayer à nouveau."
            exit
        }
    }

    # Définir les comptes utilisateur et leurs mots de passe de manière sécurisée
    $accounts = @{
        "joris" = @{
            Username = "users"
            Password = ConvertTo-SecureString "password11" -AsPlainText -Force
        }
        "User2" = @{
            Username = "User2"
            Password = ConvertTo-SecureString "Password2" -AsPlainText -Force
        }
        "User3" = @{
            Username = "User3"
            Password = ConvertTo-SecureString "Password3" -AsPlainText -Force
        }
    }

    # Afficher les options de comptes utilisateur
    Write-Host "Sélectionnez un utilisateur pour vous connecter :"
    $accounts.Keys | ForEach-Object { Write-Host "$($_)" }

    # Demander à l'utilisateur de choisir un compte
    $selectedUser = Read-Host "Entrez le nom de l'utilisateur sélectionné"

    # Vérifier si l'utilisateur a fait un choix valide
    if ($accounts.ContainsKey($selectedUser)) {
        # Récupérer les informations d'identification du compte sélectionné
        $username = $accounts[$selectedUser].Username
        $password = $accounts[$selectedUser].Password
        $credential = New-Object System.Management.Automation.PSCredential ($username, $password)

        # Utiliser les informations d'identification pour établir la session
        $session = New-PSSession -ComputerName $ippost -Credential $credential
        Write-Log "Utilisateur connecté : $username"
    } else {
        Write-Log "Nom d'utilisateur invalide : $selectedUser"
        Write-Host "Nom d'utilisateur invalide. Veuillez relancer le script et essayer à nouveau."
        exit
    }

    function Execute-RemoteCommand {
        param (
            [string]$command,
            [string]$description
        )
        Write-Log "Exécution de la commande : $description"
        $result = Invoke-Command -Session $session -ScriptBlock { param ($command) Invoke-Expression $command } -ArgumentList $command
        Write-Log "Commande exécutée : $command"
        Write-Log "Résultat de la commande : $($result -join "`n")"
        return $result
    }

    do {
        Write-Host "1- Créer un utilisateur"
        Write-Host "2- Supprimer un utilisateur"
        Write-Host "3- Lire un fichier"
        Write-Host "4- Supprimer un dossier ou un fichier"
        Write-Host "5- Log"
        Write-Host "6- Copier un dossier/fichier"
        Write-Host "7- Mise à jour Windows"
        Write-Host "8- gestion du pare feu"
        Write-Host "9- Action sur le poste"
        Write-Host "10- Installer ou désinstaller un logiciel"
        Write-Host "11- Retour au menu précédent"
        Write-Host "12- Quitter le script"

        $choix = Read-Host "Que voulez-vous faire ?"

        switch ($choix) {
            "1" {
                # Créer un utilisateur local
                
        $username = Read-Host "donner le nom du nouvelle utilisateur"
        $password = Read-Host -AsSecureString "Entrez le mot de passe pour le nouvel utilisateur"

        $command = "New-LocalUser -Name $username -Password (ConvertTo-SecureString $password -AsPlainText -Force) -FullName '$username' -Description 'Description de l utilisateur' ; Add-LocalGroupMember -Group 'Administrateurs' -Member $username"
                Execute-RemoteCommand -command $command -description "Créer un utilisateur local : $username"
            }
            "2" {
                # Supprimer un utilisateur local
                $username = Read-Host "Quel utilisateur voulez-vous supprimer ?"
                $command = "Remove-LocalUser -Name $username"
                Execute-RemoteCommand -command $command -description "Supprimer un utilisateur local : $username"
            }
            "3" {
                # Lire un fichier
                $filepath = Read-Host "Entrez le chemin complet du fichier que vous souhaitez lire"

                if (Test-Path -Path $filepath) {
                    $command = "Get-Content -Path $filepath"
                    $result = Execute-RemoteCommand -command $command -description "Lire un fichier : $filepath"
                    Write-Output "Contenu du fichier :"
                    Write-Output $result
                } else {
                    Write-Output "Le fichier n'existe pas. Veuillez vérifier le chemin et réessayer."
                    Write-Log "Lecture échouée, fichier non trouvé : $filepath"
                }
            }
            "4" {
                # Supprimer un fichier ou dossier
                $filepath = Read-Host "Entrez le chemin complet du fichier ou dossier que vous souhaitez supprimer"

                if (Test-Path -Path $filepath) {
                    $command = "Remove-Item -Path $filepath -Recurse -Force"
                    Execute-RemoteCommand -command $command -description "Supprimer un fichier ou dossier : $filepath"
                } else {
                    Write-Output "Le fichier ou dossier n'existe pas. Veuillez vérifier le chemin et réessayer."
                    Write-Log "Suppression échouée, fichier ou dossier non trouvé : $filepath"
                }
            }
            "5" {
                Write-Host "1- Log système "
                Write-Host "2- Log sécurité "
                Write-Host "3- Log application "
                $log = Read-Host "quel log voulez vous"
                switch ($log){
                    "1" { 
                    $localFilePath = "C:\Users\Administrateur\Documents\log_systeme.txt
                        # Afficher log système
                        $command = {
                        $periode = Read-Host "sur quel periode en heures?"
                         Get-WinEvent -LogName System | Where-Object { $_.TimeCreated -ge (Get-Date).AddHours(-$periode) } | Select-Object TimeCreated, Id, LevelDisplayName, Message
                        }
                        Execute-RemoteCommand -command $command -description "Afficher log système" | Tee-Object -FilePath $localFilePath
                    }
                    "2" {
                        # Afficher log sécurité 
                        $localFilePath = "C:\Users\Administrateur\Documents\log_securite.txt
                    $command = {
                        $periode = Read-Host "sur quel periode en heures?"
                         Get-WinEvent -LogName Security | Where-Object { $_.TimeCreated -gt (Get-Date).AddHours(-$periode) } | Select-Object TimeCreated, Id, LevelDisplayName, Message
                        }
                        Execute-RemoteCommand -command $command -description "Afficher log sécurité" | Tee-Object -FilePath $localFilePath
                    }
                    "3" {
                        $localFilePath = "C:\Users\Administrateur\Documents\log_application.txt
                        # Afficher log application
                        $command = {
                        $periode = Read-Host "sur quel periode en heures?"
                        Get-WinEvent -LogName Application | Where-Object { $_.TimeCreated -gt (Get-Date).AddHours(-$periode) } | Select-Object TimeCreated, Id, LevelDisplayName, Message
                        }
                        Execute-RemoteCommand -command $command -description "Afficher log application" | Tee-Object -FilePath $localFilePath
                    }
                }
            }
            "6" {
                # Copier un fichier ou dossier
                $source = Read-Host "Entrez le chemin source"
                $destination = Read-Host "Entrez le chemin de destination"
                $command = "Copy-Item -Path $source -Destination $destination -Recurse -Force"
                Execute-RemoteCommand -command $command -description "Copier un fichier ou dossier de $source à $destination"
            }
            # Partie faite par Mina
            "7" {
                # Mise à jour des pilotes
                Write-Output "Recherche des mises à jour des pilotes..."
                $command = @'
                    $updateSession = New-Object -ComObject Microsoft.Update.Session
                    $updateSearcher = $updateSession.CreateUpdateSearcher()
                    $searchResult = $updateSearcher.Search("IsInstalled=0 and Type='Driver'")

                    if ($searchResult.Updates.Count -eq 0) {
                        "Aucune mise à jour de pilote disponible."
                    } else {
                        "$($searchResult.Updates.Count) mise(s) à jour de pilote trouvée(s)."
                        $updatesToInstall = New-Object -ComObject Microsoft.Update.UpdateColl

                        foreach ($update in $searchResult.Updates) {
                            $updatesToInstall.Add($update) | Out-Null
                        }

                        $installer = $updateSession.CreateUpdateInstaller()
                        $installer.Updates = $updatesToInstall
                        $installationResult = $installer.Install()

                        "Résultat de l'installation des mises à jour de pilotes : $($installationResult.ResultCode)"
                    }
'@
                Execute-RemoteCommand -command $command -description "Mise à jour des pilotes"
            }
            "8" {
                Write-Host "1- Activer le pare-feu"
                Write-Host "2- Désactiver le pare-feu"
                Write-Host "3- Créer une règle de pare-feu"
                Write-Host "4- Supprimer une règle de pare-feu"
                $firewall = Read-Host "Que voulez-vous faire avec le pare-feu ?"
                switch ($firewall) {
                    "1" {
                        # Activer le pare-feu
                        $command = "Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True"
                        Execute-RemoteCommand -command $command -description "Activer le pare-feu"
                    }
                    "2" {
                        # Désactiver le pare-feu
                        $command = "Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False"
                        Execute-RemoteCommand -command $command -description "Désactiver le pare-feu"
                    }
                    "3" {
                        # Créer une règle de pare-feu
                        $ruleName = Read-Host "Entrez le nom de la règle"
                        $direction = Read-Host "Entrez la direction (Inbound/Outbound)"
                        $action = Read-Host "Entrez l'action (Allow/Block)"
                        $protocol = Read-Host "Entrez le protocole (TCP/UDP/Any)"
                        $localPort = Read-Host "Entrez le port local (ou 'Any')"
                        $remotePort = Read-Host "Entrez le port distant (ou 'Any')"
                        $localAddress = Read-Host "Entrez l'adresse locale (ou 'Any')"
                        $remoteAddress = Read-Host "Entrez l'adresse distante (ou 'Any')"

                        $command = "New-NetFirewallRule -DisplayName '$ruleName' -Direction $direction -Action $action -Protocol $protocol -LocalPort $localPort -RemotePort $remotePort -LocalAddress $localAddress -RemoteAddress $remoteAddress"
                        Execute-RemoteCommand -command $command -description "Créer une règle de pare-feu : $ruleName"
                    }
                    "4" {
                        # Supprimer une règle de pare-feu
                        $ruleName = Read-Host "Entrez le nom de la règle à supprimer"
                        $command = "Remove-NetFirewallRule -DisplayName '$ruleName'"
                        Execute-RemoteCommand -command $command -description "Supprimer une règle de pare-feu : $ruleName"
                    }
                }
            }
            # Partie de brice
            "9" {
                
                Write-Host "1- Redémarrer"
                Write-Host "2- Arrêter"
                $action = Read-Host "Quelle action voulez-vous effectuer sur le poste ?"
                switch ($action) {
                    
                    "1" {
                        # Redémarrer
                        $command = "shutdown.exe /r /t 0"
                        Execute-RemoteCommand -command $command -description "Redémarrer"
                    }
                    "2" {
                        # Arrêter
                        $command = "shutdown.exe /s /t 0"
                        Execute-RemoteCommand -command $command -description "Arrêter"
                    }
                }
            }
            "10" {
                Write-Host "1- Installer un logiciel"
                Write-Host "2- Désinstaller un logiciel"
                $softwareAction = Read-Host "Que voulez-vous faire avec un logiciel ?"
                switch ($softwareAction) {
                    "1" {
                        # Installer un logiciel
                        $softwarePath = Read-Host "Entrez le chemin du fichier d'installation"
                        $command = "Start-Process -FilePath $softwarePath -ArgumentList '/silent' -Wait"
                        Execute-RemoteCommand -command $command -description "Installer un logiciel : $softwarePath"
                    }
                    "2" {
                        # Désinstaller un logiciel
                        $softwareName = Read-Host "Entrez le nom du logiciel à désinstaller"
                        $command = "Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -eq '$softwareName' } | ForEach-Object { $_.Uninstall() }"
                        Execute-RemoteCommand -command $command -description "Désinstaller un logiciel : $softwareName"
                    }
                }
            }
            "11" {
                Write-Host "Retour au menu précédent."
                break
            }
            "12" {
                Write-Host "Sortie du script."
                Write-Log "fin de script"
                exit
            }
            default {
                Write-Output "Choix invalide. Veuillez réessayer."
            }
        }
    } while ($choix -ne "11")
} while ($choix -ne "12")
