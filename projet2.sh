#!/bin/bash
clear
#verification et création du dossier 
if [ ! -d log_script ];
then
	mkdir log_script
fi
log_file="log_script/log_evt$(date +%Y%m%d-%H%m%S)-$user.log"
echo "$(date +%T)-$USER-***************StartScript***************" >> $log_file

   echo -e "\e[1;33m=============================================================="
   echo -e "       Bienvenue dans le script de gestion a distance     "
   echo -e "vous allez pouvoir effectuer des actions sur les postes choisi"
   echo -e "=============================================================="

   echo -e "\e[1;32m$USER utilise le script\e[0m"

sleep 2
#-------------------------------------------------------------------------------
# déclaration des variables
#déclaration poste de travail
direction=192.168.0.108
comptabilite=192.168.0.91
acceuil=192.168.0.39
# déclaration des utilisateur
dir1id="mina"
dir2id="vanessa"
compt1id="joris"
compt2id="brice"
accid="dams"
root="adil"
#--------------------------------------------------------------------------------
# Titre des menus
titre_menu_poste="                   Choix du poste          "
titre_menu_utilisateur="                Choix de l'utilisateur   "
titre_menu="  Menu d'exécution de commandes à distance"
titre_sous_menu="                   Menu info poste distant              "
titre_sous_menu_action_poste="            Menu d'action sur le poste distant"
titre_sous_menu_utilisateur="              Menu des utilisateurs"
titre_sous_menu_sauvegarde="               Menu de sauvegarde  "
# Options du menu
postes=(
     " Direction"
     " Comptabilité"
     " Acceuil"
     " Quitter la sélection"
     )
utilisateur_direction=(
      "Mina"
      "Vanessa"
      "Quitter le sélection"
      )
utilisateur_comptabilite=(
      "Joris"
      "Brice"
      "Quitter le sélection"
      )
utilisateur_acceuil=(
      "Damien"
      "Quitter la sélection"

      )

options=(
    "Gestion des utilisateurs"
    "Sauvegarde"
    "Obtenir les logs"
    "Action sur le poste distant"
    "Info poste"
    "Quitter"
    )
options2=(
	"Info sur le stockage "
	"Info processus en cour "
	"Info systeme exploitation"
	"Quitter le menu"
	)
options3=(
	"eteindre"
	"redemarrer"
	"Mise à jour"
	"Quitter le menu"
	)

options4=(
	"Crée un utilisateur"
	"Crée un groupe"
	"supprimer un utilisateur"
	"Quitter le menu"
	)
options5=(
    "Sauvegarde dossier travail"
    "Sauvegarde dossier communication"
    "Quitter le menu"
    )
#-------------------------------------------------------------------------------
# déclaration des menus
# Fonction pour afficher le menu
menu_postes(){
clear
   echo -e "\e[1;32m=============================================================="
   echo -e "$titre_menu_poste     "
   echo -e "=============================================================="
    for ((i = 0; i < ${#postes[@]}; i++)); do
      echo "$((i+1)):${postes[$i]}"
   done
   echo -e "==============================================================\e[0;m"
}
menu_direction(){
clear
   echo -e "\e[1;33m=============================================================="
   echo -e "      $titre_menu_utilisateur "
   echo -e "=============================================================="
    for ((i = 0; i < ${#utilisateur_direction[@]}; i++)); do
        echo "$((i+1)) : ${utilisateur_direction[$i]}"
    done
   echo -e "==============================================================\e[0;m"
}
menu_comptabilite(){
clear
   echo -e "\e[1;33m=============================================================="
   echo -e "    $titre_menu_utilisateur "
   echo -e "=============================================================="
    for ((i = 0; i < ${#utilisateur_comptabilite[@]}; i++)); do
        echo "$((i+1)) : ${utilisateur_comptabilite[$i]}"
    done
   echo -e "==============================================================\e[0;m"
}
menu_acceuil (){
clear
   echo -e "\e[1;33m=============================================================="
   echo -e "   $titre_menu_utilisateur "
   echo -e "=============================================================="
    for ((i = 0; i < ${#utilisateur_acceuil[@]}; i++)); do
        echo "$((i+1)) : ${utilisateur_acceuil[$i]}"
    done
   echo -e "==============================================================\e[0;m"

}
afficher_menu() {
clear
   echo -e "\e[1;35m=============================================================="
   echo -e "          $titre_menu "
   echo -e "=============================================================="
    for ((i = 0; i < ${#options[@]}; i++)); do
        echo "$((i+1)) : ${options[$i]}"
    done
   echo -e "==============================================================\e[0;m"
}

# Fonction pour afficher le sous-menu_navigation
afficher_sous_menu_info() {
clear
  echo -e "\e[1;31m=============================================================="
  echo -e "       $titre_sous_menu "
  echo -e "=============================================================="
    for ((i = 0; i < ${#options2[@]}; i++)); do
        echo "$((i+1)) : ${options2[$i]}"
    done
   echo -e "==============================================================\e[0;m"
}

# Fonction pour afficher le sous-menu_action_poste
afficher_sous_menu_action_poste() {
clear
   echo -e "\e[1;31m=============================================================="
   echo -e "   $titre_sous_menu_action_poste       "
   echo -e "=============================================================="
    for ((i = 0; i < ${#options3[@]}; i++)); do
        echo "$((i+1)) : ${options3[$i]}"
    done
   echo -e "==============================================================\e[0;m"
}
# Fonction pour afficher le menu utilisateur
afficher_sous_menu_utilisateur() {
clear
   echo -e "\e[1;31m=============================================================="
   echo -e "     $titre_sous_menu_utilisateur           "
   echo -e "=============================================================="
    for ((i = 0; i < ${#options4[@]}; i++)); do
        echo "$((i+1)) : ${options4[$i]}"
    done
   echo -e "==============================================================\e[0;m"
}
#Fonction pour afficher le menu de sauvegarde
afficher_sous_menu_sauvegarde(){
clear
   echo -e "\e[1;33m=============================================================="
   echo -e "          $titre_sous_menu_sauvegarde    "
   echo -e "=============================================================="
    for ((i = 0; i < ${#options5[@]}; i++)); do
      echo "$((i+1)) : ${options5[$i]}"
   done
   echo -e "==============================================================\e[0;m"
}
#----------------------------------------------------------------------------------
# Fonction de commande sur le poste
action_poste() {
	clear
 	while true; do
    afficher_sous_menu_action_poste

    echo "Entrez votre choix :"
    echo "$ID"
    read -p " > " choix

    case $choix in
        1) eteindre ;;
        2) redemarre ;;
       	3) maj ;;
       	4) break ;;
        *) echo "Choix invalide. Veuillez réessayer." ;;
    esac
done
}
eteindre(){
	echo "*********************poweroff poste distant*********************" >> $log_file
	$IDroot -t "sudo shutdown now"
	echo -e "\e[1;31m================================================================="
	echo -e "\e[1;33mLe poste s'eteint vous serez deconecter veuillez changer de poste"
	echo -e "\e[1;31m=================================================================\e[0m"
	echo -e "\e[1;32mAppuyer sur une touche pour continuer...\e[0m"
	read -n1
}
redemarre(){
	echo "********************Reboot poste distant************************" >> $log_file
	 $IDroot -t "sudo reboot"
	echo -e "\e[1;31m================================================================="
	echo -e "\e[1;33mLe poste vas redemarrer veuillez patienter ou changer de poste"
	echo -e "\e[1;31m=================================================================\e[0m"
	echo -e "\e[1;32mAppuyer sur une touche pour continuer...\e[0m"
	read -n1
}
maj(){
	echo "*********************Mise à jour*******************************" >> $log_file
    echo -e "\e[1;3mMise à jour des paquets\e[0m"
    $IDroot -t "sudo apt update"
    $IDroot -t "sudo apt upgrade"
}
#---------------------------------------------------------------------------------
#Function d'action sur les utilisateurs
action_utilisateur() {
	clear
	while true; do
afficher_sous_menu_utilisateur
	echo "Entrez votre choix"
	echo "$ID"
	read -p "> " choix

	case $choix in
	1) crée ;;
	2) group ;;
	3) supprimer ;;
	4) break ;;
	*) echo "Choix invalide. Veuillez réessayer." ;;
	esac

done
}
#création function utilisateur
crée(){
	echo "********************création utilisateur******************" >> $log_file
	read -p "Quel est le nom de l'utilisateur :  " usr
	$IDroot "sudo -S adduser $usr" | tee -a "$log_file"
	exit_status=$?
	echo -e "\e[1;32m============================================================="
	echo -e "Appuyer sur une touche pour continuer...\e[0m"
	read -n1

if [ $exit_status -eq 0 ];
	then
	echo "L'utilisateur $usr a bien été crée"
fi
}
group(){
	echo "*******************Création groupe********************" >> $log_file
	read -p "Quel est le groupe de l'utilisateur  :  " group
	echo  $IDroot
	$IDroot "sudo -S groupadd $group" | tee -a "$log_file"
	exit_status=$?
if [ $exit_status -eq 0 ];
	then
   	 echo "Le groupe $group est bien crée "
    else
    	echo "Erreur dans la commande"
fi
}
supprimer(){
	echo "**********************Suppression utilisateur*******************" >> $log_file
    read -p "Quel utilisateur voulez vous supprimer  :  " util
    	echo  $IDroot
	$IDroot -t "sudo userdel -f $util" | tee -a "$log_file"
	break 0
	echo -e "\e[1;32m============================================================"
        echo -e "L'utilisateur $util est supprimé "
	echo -e "===================================================================="
	echo -e "Appuyer sur une touche pour continuer...\e[0m"
	read -n1
}
#-------------------------------------------------------------------------------
# Fonction pour obtenir l'historique des commandes distantes
logs() {
clear
afficher_logs_system() {
clear
	echo "********************log systeme********************" >> $log_file
times=$(date +"%Y%m%d_%T")
file="boot_$times.log"
 echo "$file"
 echo -e "\e[1;36mLes logs depuis de dernier démarrage sont enregistrée dans $file.\e[0m"
    $ID journalctl -b | tee -a "$log_file"
	echo -e "\e[1;32m==========================================================="
	echo -e "Appuyer sur une touche pour continuer...\e[0m"
	read -n1
clear
}
# Fonction pour afficher les logs de sécurité
afficher_logs_securite() {
	echo "**********************log noyaux********************" >> $log_file
times=$(date +"%Y%m%d_%T")
file="secu_$time"
	echo -e "\e[1;36mLes logs du noyaux sont enregistrées dans $file.\e[0m"
   	$ID journalctl -k | tee -a "$log_file"
	echo -e "\e[1;32m==========================================================="
	echo -e "Appuyer sur une touche pour continuer...\e[0m"
	read -n1
clear
}
# Fonction pour afficher les logs des applications
afficher_logs_application() {
	echo "********************log erreur*********************" >> $log_file
times=$(date +"%Y%m%d_%T")
file="erreur_$times"
    echo -e "\e[1;36mLes logs des erreurs sont enregistrées dans $file.\e[0m"
   $ID journalctl -p err | tee -a "$log_file"
	echo -e "\e[1;32m============================================================"
	echo -e "Appuyer sur une touche pour continuer...\e[0m"
	read -n1
clear
}


# Menu principal
while true; do
 echo -e "\e[1;32m========================================================================"   
 echo -e "Choisissez le type de logs à afficher :"
 echo -e "========================================================================"
 echo -e "1. Logs depuis dernier boot"
 echo -e "2. Logs du noyaux"
 echo -e "3. Logs des erreurs"
 echo -e "4. Quitter"
 echo -e "========================================================================\e[0m"   
 read -p "Entrez votre choix [1-4] : " choix



    case $choix in
       	 1)afficher_logs_system ;;
 	 2)afficher_logs_securite ;;
         3)afficher_logs_application ;;
         4)break ;;
	 *)echo "Choix invalide. Veuillez réessayer." ;;

    esac

done	
}

info_poste() {
clear
afficher_sous_menu_info
	while true; do
	echo "Entrez votre choix"
	echo "$ID"
	read -p ">"  choix
case $choix in
	1)dd ;;
	2)process ;;
	3)os ;;
	4)break ;;
	*) echo "Chois invalide, veuillez réessayer." ;;
esac
done
}
dd(){
clear
	echo "*****************info capacite disque dur****************" >> $log_file
	$ID "df -h" | tee -a $log_file
	echo -e "\e[1;32m====================================================================="
	echo -e "Appuyer sur une touche pour continuer...\e[0m"
	read -n1
	info_poste
}
process(){
clear
	echo "****************info sur les processus en cour**************" >> $log_file
	$ID "ps aux" | tee -a $log_file
	echo -e "\e[1;32m===================================================================="
	echo -e "Appuyer sur une touche pour continuer...\e[0m"
	read -n1
	info_poste
}
os(){
clear
	echo "*******************info os********************" >> $log_file
	$ID "cat /etc/os-release" | tee -a $log_file
	echo -e "\e[1;32m==================================================================="
	echo -e "Appuyer sur une touche pour continuer...\e[0m"
	read -n1
	info_poste
}
#----------------------------------------------------------------------------
# Fonction pour afficher la liste des sauvegardes distants
sauvegarde() {
	clear
	
 	while true; do
    afficher_sous_menu_sauvegarde
    echo "Entrez votre choix :"
    read -p "> " choix

    case $choix in
        1) travail ;;
        2) com ;;
        3) break ;;
        *) echo "Choix invalide. Veuillez réessayer." ;;
    esac
done
}
travail(){
	echo "*****************sauvegarde travail******************" >> $log_file
	rsync -avz -e $IP:~/travail /home/dams/ | tee -a "$log_file"
	exit_status=$?

if [ $exit_status -eq 0 ];
	then
	echo -e "\e[1;32mLe dossier travail est bien sauvegardé\e[0m"
else
	echo -e "\e[1;31mla sauvegarde à échouée\e[0m"
fi
	echo -e "\e[1;32m================================================================="
	echo -e "Appuyer sur une touche pour continuer...\e[0m"
	read -n1
clear
}
com(){
	echo "********************sauvegarde communication*******************" >> $log_file
	rsync -avz -e $IP:~/communication /home/dams/ | tee -a "$log_file"
	exit_status=$?
if [ $exit_status -eq 0 ];
	then
	echo -e "\e[1;32mLe dossier communication est bien sauvegarder\e[0m"
else
	echo -e "\e[1;31mLa sauvergarde a échouée\e[0m"
fi
	echo -e "\e[1;32m================================================================"
	echo -e "Appuyer sur une touche pour continuer...\e[0m"
	read -n1
clear
}
#------------------------------------------------------------------------------
#fonction choix utilisateur
direction() {
while true; do
    menu_direction
	echo "Quel utilisateur désirez-vous: "
	read -p ">" choix

	case $choix in
		1)direction1 ;;
		2)direction2 ;;
		3)break ;;
		*)echo "Choix invalide. Veuillez réessayer." ;;

	esac
done
}
direction1(){
	echo "vous êtes connecté avec l'utilisateur $dir1id"
	export ID="ssh $dir1id@$direction";
	export IDroot="ssh $root@$direction";
	sleep 2
	usr=$dirid
menu_utilisation
}
direction2() {
	echo "vous êtes connecté avec l'utilisateur $dir2id"
	export ID="ssh $dir2id@$direction"
	export IDroot="ssh $root@$direction"
	sleep 2
	menu_utilisation

}
comptabilite() {
menu_comptabilite
read -p "Quelle utilisteur désirez-vous :" choix

	case $choix in
		1)compta1 usr=compta1;;
		2)compta2 usr=compta2;;
		3)break ;;
		*)echo "Choix invalide. Veuillez réessayer." ;;
	esac

}
compta1() {
	echo "vous êtes connecté avec l'utilisateur $compt1id"
	export ID="ssh $compta1@$comptabilite"
	export IDroot="ssh $root@$comptabilite"
	sleep 2
	menu_utilisation


}
compta2() {
	echo "vous êtes connecté avec l'utilisateur $compt2id"
	export ID="$comp2id@$comptabilite"
	export IDroot="ssh $root@$comptabilite"
	sleep 2
	menu_utilisation

}
acceuil(){
menu_acceuil
read -p "Quelle utilisteur désirez-vous :" choix

	case $choix in
		1)acc1 ;;
		2)break ;;
		*)echo "Choix invalide. Veuillez réessayer." ;;

	esac
}
acc1() {
	echo "Vous êtes connecté avec l'utilisateur $accid"
	export ID="ssh $accid@$acceuil"
	export IDroot="ssh $root@$acceuil"
        export usr="$accid"
	menu_utilisation
}
menu_utilisation() {
while true; do
    afficher_menu

    echo "Entrez votre choix :"
    read -p " > " choix

    case $choix in
        1) action_utilisateur ;;
        2) sauvegarde ;;
        3) logs ;;
        4) action_poste ;;
        5) info_poste ;;
        6) break ;;
        *) echo "Choix invalide. Veuillez réessayer." ;;
    esac
done
}
# choix du poste
echo -e "\e[136mBienvenue dans le script de gestion à distance\e[0m"
while true; do
menu_postes
    echo "Entrez votre choix :"
	read -p ">" choix
	case $choix in
		1)direction IP=$direction;;
		2)comptabilite IP=$comptabilite;;
		3)acceuil IP=$acceuil;;
		4)exit 0 ;;
		*)echo "Choix invalide. Veuillez réessayer." ;;
	esac
		echo "$(date +%T)-$USER-***************EndScript****************" >> $log_file
done

# Boucle principale du script
menu_utilisation() {
while true; do
    afficher_menu

    echo "Entrez votre choix :"
    read -p "> " choix

    case $choix in
        1) action_utilisateur ;;
        2) afficher_processus ;;
        3) afficher_historique ;;
        4) info_poste ;;
	5) action_poste ;;
	6) execut_commande ;;
	7) exit 0 ;;
        *) echo "Choix invalide. Veuillez réessayer." ;;

    esac
done
}
