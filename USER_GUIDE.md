# USER GUIDE

## 1- Présentation du script:
Nous avons préparé un script bash et Powershell permettant d’exécuter à distance différentes manipulations systèmes, permettant un workflow plus efficace des administrateurs.
Ce document fait office de notice utilisateurs.

### Présentation visuelle du script:

![ADMINISTRATEUR](https://github.com/WildCodeSchool/tssr-2405-p2-g3-Scripting/assets/169658100/6312884f-c828-4e6e-aef7-99d5ee9f3483)



## 2- Pré-requis et problèmes éventuels:

### a- Machines et autorisations 

Nous aurons besoin pour le script Powershell, pour l’administrateur d’un Windows Server 2022 (avec GUI), et d’une machine cliente Windows 10.
Pour le script Bash, nous devons avoir pour serveur une machine sous Linux distribution Debian, qui exécutera le script sur une machine Linux distribution Debian.
	
### b- Powershell

Le script sera au format .PS1, lancé depuis le serveur windows vers la machine cliente windows 10.
Pour le bon déroulement des différentes instructions du script, nous devons avoir les droits administrateur.
Pour la connexion SSH, Celle-ci ne peut pas marcher sous Powershell ISE. Il faut obligatoirement utiliser Powershell.

### c- Bash
Le script sera au format .sh, lancé depuis le serveur Debian, vers une machine cliente Debian.
Comme pour le script Powershell, avoir les droits root, permettant d’exécuter les fonctionnalités du script nécessitants des droits élevés.

## 3- Déroulé du script:

Nous y trouvons des actions sur les systèmes et sur les utilisateurs.
Nos super scripteurs ont rédigé chaque étape avec explications et légendes, permettant une navigation claire et fluide entre les différents menus/sous-menus et ses exécutions.

### a- Powershell
Pour les script Powershell avant de le lancer il faudra renseigner les adresse ip , identifiant de chaque session pour chacun des post .
Attention le script n'utilise pas l’active directory .
Toutefois, si un problème venait à être rencontré, référez-vous à la F.A.Q, ou au guide install.md.
![](https://github.com/WildCodeSchool/tssr-2405-p2-g3-Scripting/blob/main/enregistr%C3%A9%20ip.png)
![](https://github.com/WildCodeSchool/tssr-2405-p2-g3-Scripting/blob/main/id%20ssesion%20.png)
### b- Bash
Sur chaque poste vous devez créer un dossier travail et un dossier communication afin de pouvoir les synchroniser et de ne pas copier les dossiers personnels.

Pour le script bash il faut éditer le script en renseignant les adresses IP des postes à administrer ainsi que le nom des utilisateurs par poste.

![variable utilisateur](https://github.com/WildCodeSchool/tssr-2405-p2-g3-Scripting/assets/169659054/3b13412e-d5ed-4f48-b80b-a8db92b3f8ba)

Une fois le script lancé, vous devez choisir d’abord le poste, puis l’utilisateur et afin la section avec les actions possibles.
![choix poste](https://github.com/WildCodeSchool/tssr-2405-p2-g3-Scripting/assets/169659054/bb3c4355-bd81-456b-af6d-acb69884b764)

![choix utilisateur](https://github.com/WildCodeSchool/tssr-2405-p2-g3-Scripting/assets/169659054/7ff6f890-0385-454c-9649-747d14433618)

![choix action](https://github.com/WildCodeSchool/tssr-2405-p2-g3-Scripting/assets/169659054/7c4f5699-9662-4126-b821-1b50ed89899e)

Dans le menu Gestion des utilisateur vous allez pouvoir créer et supprimer un utilisateur ainsi que créer un groupe.

Dans le menu sauvegarde vous allez pouvoir sauvegarder les dossier travail et communication 

Dans le menu Obtenir les logs vous allez pouvoir enregistrer les logs du poste distant 

Dans le menu Action sur le poste distant vous allez pouvoir éteindre redémarrer et mettre à jour le poste distant.
Dans le menu Info poste vous allez pouvoir voir des infos sur le poste distant.

## 4- F.A.Q

### a- Connexion SSH

Powershell: Si la connexion ne marche pas, vérifiez que vous établissez depuis Powershell et non Powershell ISE.
Bash:

### b- Installation et suppression d’un logiciel sous powershell

Il faut le chemin complet jusqu’au fichier d’installation/logiciel à désinstaller.

En cas d'erreur avec les sortie de log ou historique du scrip pensé a changer le chemin de sauvegarde.
