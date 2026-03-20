###                              🏫 GradeBook

# 1. 🎯 Contexte

    - GradeBook est une appication web de gestion de notes pour une ecole primaire
    - Permets aux enseigniants de saisire les notes par sequence, calcule automatiquement les moyenne par trimestre, genere les bulletins PDF avec les notes classees par genre de matieres.


# 2. Les acteurs du systeme

  👑 Administrateur    

    _Fonctionnalitees_ :

      i. Classes
        Creer une classe
          -> Nome (CM2 A), niveau (CM2), Annee academique
          -> Attribuer un Enseignant titulaire des la creation
        Modifier une class
        Supprimer un class

      ii. Matieres 
        Voir les matieres existantes
        Ajouter une matiere 
          -> nom, Coefficient, Genre (literrairre, scientifique, Sport& art)
      
      iii. Enseignats
        Ajouter un enseignant
          -> Cree un compte (email + mots de passe temporaire)
        Supprimer un enseignant
        Modifier ses fonctions

      iv. Eleves 
        Ajouter un eleve : -> Nom, Matricule, Date de Naissence, sexe, contact parent
        Modifier un eleve
        Supprimer un eleve

      v. Period de saisie 
        ouvrir une sequance (1 a 6)
        Fermer une sequence 

      vi. Resultats & Bullteins
        Lancer le calcule de la moyenne 
        Consulter tout les bullteins 
        Telecharger un bulltein en pdf


  👨🏾‍🏫 Enseigniant    

    _Action completes_ : 

      i. Comptes et profil 
        Se connecter avec email et mot de passe 
        Changer son mot de passe (force a la 1 connexion)
        Voir et modifier son profil
      
      ii. Sa classe
        Voir sa classe assignee
          -> Nom de la classe (ex: CM2 A)
          -> Liste de tous ses eleves
          -> Matieres a enseigner

      iii. Saisie des notes 
        Voir la sequence en cours(ouverte par l'admin)
        saisire une notes pour chaque eleve et chaque matiere
        modifier une notes (tantque la sequence est ouverte) 

      iv. Bullteins
        Consulter le bulletin de chaque eleve de sa classe
        Telecharger un bulltein en pdf

  
# 3. Les matieres & genres

  Litereraire 

    lecture                            coeff?
    Ecriture                           coeff?
    Anglais                            coeff?
   
  
  Scientifiques
    Maths                              coeff?
    Sciences                           coeff?
    Histoire-Geo                       coeff?

  Sport & art 
    EPS                                coeff?
    Dessin                             coeff?
  
  + L'administrateure peut ajouter une matiere avec sont coefficient et sont genre