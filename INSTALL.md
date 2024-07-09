# TSSR-2405-P2-G3-TheScriptingProject

## Résumé

Ce document d'écrit les étapes pour installer et configurer l'environnement nécessaire au projet TheScriptingProject sur Windows Server 2022 et Ubuntu 22.04 LTS.

## Prérequis techniques

![ADMINISTRATEUR.jpg](https://github.com/WildCodeSchool/tssr-2405-p2-g3-Scripting/blob/main/ADMINISTRATEUR.jpg)

### Serveurs

| Système d'exploitation | Nom d'hôte  | Adresse IP       | Identifiant   | Mot de passe |                 
|------------------------|-------------|------------------|---------------|--------------|
| Windows Server 2022    | SRVWIN01    | 172.16.10.5/24   | administrator | Azerty1*     | 
| Debian 12.5            | SRVLX01     | 172.16.10.10/    |adil           |adil                       

### Clients

| Système d'exploitation | Nom d'hôte  | Adresse IP       | Identifiant   | Mot de passe |
|------------------------|-------------|------------------|---------------|--------------|
| Windows 10		 | CLIWINN01   | 172.16.10.20/24  | wilder        | Azerty1*     |
| debian 12       | compta    | 192.168.0.91/24  | brice        | brice
debian 12        |  compta    |  192.168.0.91/24  |joris        | joris
debian 12       | direction   |  192.168.0.108    |vanessa      | vanessa
debian 12         |direction    | 192.168.0.108     |mina         |mina
debian 12       | accueil       |192.168.0.39/24 | dams         | dammien
	
## Mise en place et configuration sur Windows Server 2022

Dans le dessein d'optimiser le fonctionnement du script et de répondre aux impératifs du projet, voici les étapes indispensables à la configuration de Windows Server 2022 :

### Configuration requise :

1. **Installation de PowerShell Core 7.4 LTS :**
   - Il est impératif d'installer PowerShell Core 7.4 LTS :
     ```powershell
     # Veuillez veiller à exécuter PowerShell en qualité d'administrateur
     Set-ExecutionPolicy AllSigned -Scope Process -Force; iwr https://aka.ms/install-powershell.ps1 -UseBasicParsing | iex
     ```
     Effectuez une vérification de la version installée :
     ```powershell
     $PSVersionTable.PSVersion
     ```

2. **Désactivation du pare-feu :**
   - Procédez à la désactivation du pare-feu pour des besoins spécifiques (à évaluer pour la production) :
     ```powershell
     Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
     ```

3. Démarrage du service WinRM

Vérifiez si le service WinRM est en cours d'exécution en exécutant la commande suivante :

PowerShell
Get-Service WinRM
Utilisez ce code avec précaution.
content_copy
Si le service n'est pas démarré, lancez-le avec la commande suivante :

PowerShell
Start-Service WinRM
Utilisez ce code avec précaution.
content_copy

4. Configuration des TrustedHosts WinRM

Pour autoriser l'accès distant à WinRM, vous devez ajouter l'hôte ou les hôtes de confiance à la liste TrustedHosts. Exécutez les commandes suivantes en tant qu'administrateur PowerShell :

PowerShell
$trustedHosts = Get-Item CimInstance -ClassName WinRMService -Property Name,TrustedHosts
$newTrustedHosts = $trustedHosts.TrustedHosts + "HÔTE_DE_CONFIANCE"
Set-Item CimInstance -ClassName WinRMService -ResourceIdentifier $trustedHosts.Name -Property TrustedHosts $newTrustedHosts
Utilisez ce code avec précaution.
content_copy
Remplacez HÔTE_DE_CONFIANCE par l'adresse IP ou le nom d'hôte de l'ordinateur à partir duquel vous souhaitez vous connecter à WinRM. Vous pouvez répéter cette étape pour ajouter plusieurs hôtes de confiance.

Exemple:

PowerShell
$trustedHosts = Get-Item CimInstance -ClassName WinRMService -Property Name,TrustedHosts
$newTrustedHosts = $trustedHosts.TrustedHosts + "192.168.1.10"
Set-Item CimInstance -ClassName WinRMService -ResourceIdentifier $trustedHosts.Name -Property TrustedHosts $newTrustedHosts
Utilisez ce code avec précaution.
content_copy
Remarque: Assurez-vous de remplacer 192.168.1.10 par l'adresse IP ou le nom d'hôte réel de votre ordinateur de confiance.

5. Test de l'accès WinRM

Une fois la configuration terminée, vous pouvez tester l'accès WinRM à partir d'un autre ordinateur en exécutant la commande suivante dans une invite PowerShell :

PowerShell
winrm ping -computerName SRVWIN01 -username administrator -password Azerty1*
Utilisez ce code avec précaution.
content_copy
Si la commande réussit, vous devriez recevoir un message indiquant que la connexion a été établie.

Remarque:

Remplacez SRVWIN01 par le nom d'hôte de votre serveur Windows Server 2022.
Assurez-vous de modifier le mot de passe Azerty1* par le mot de passe réel de votre compte administrateur.
En suivant ces étapes, vous devriez pouvoir installer et configurer WinRM sur votre serveur Windows Server 2022, permettant ainsi l'accès distant à l'aide d'outils tels que PowerShell.


## Mise en place et configuration sur Debian Poste client 

Afin d'optimiser le fonctionnement du script et répondre aux exigences du projet, veuillez suivre les étapes ci-dessous pour configurer le poste client Ubuntu :

### Configuration requise :

1. **Installation des packages nécessaires :**
   - Nous vous prions de vous assurer que le système est à jour en exécutant la commande suivante :
     ```bash
     sudo apt update && sudo apt upgrade -y
     ```

2. **Installation de rsync:**
   - Veuillez procéder à l'installation de rsync ainsi que des dépendances nécessaires en 
     ```bash
         sudo apt-get install rsync
     ```

3. **Configuration du pare-feu :**
   - Il est impératif de configurer le pare-feu afin d'autoriser les connexions requises.

4. **Configuration de SSH :**
   - Si nécessaire, veuillez configurer le client SSH pour accéder à d'autres systèmes.

**Installer SSH :**

 ```sudo apt-get install openssh-server```
Une fois le SSH installé, il faut l'activer :
```sudo systemctl enable ssh```

###Iinfo système  
 VM Debian Server 12.2  
Nom de Machine : sv-debian  
Utilisateur : adil  
Mot de passe : adil  
IP adresse : 192.168.0.73  

