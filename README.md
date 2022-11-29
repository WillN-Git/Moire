<div align="center">
  <h1 align="center">
        Lost Shapes Dimension
  </h1>

  <h3 align="center">Un puzzle game avec des effet visuels de moire (illusionnistes).</h3>
</div>

<br/>

<div align="center">
  <img src="captures/capture05.PNG" />
</div>

## Alerte 🚨
**ATTENTION CE JEU CONTIENT DES EFFETS VISUELS INTENSES POUR UN PUBLIC EPILEPTIQUE OU AYANT UN SENSIBILITE AUX COULEURS.**

## Objectif du projet 🎯
Lost Shapes Dimension est un jeu sous acide dans lequel le·a joueur·euse est invité·e à aider des formes géométriques dans leur quête de se recentrer sur elles-mêmes afin de se remettre en phase avec l'univers. 


### Fontionnalités existantes 👍

1. Sélection d'une forme
2. Transformation d'une forme :
    - Translation
    - Rotation
    - Homothétie

## Intentions 📑

Les intentions suivent ont été respectées : 

|  Int N°  | Nom de l'intention                               |   Resultats    |
|:---------|:-------------------------------------------------|:---------------|
|    1     |  Effet visuel de moiré                           |    ACCOMPLI    |
|    2     |  Feedback sonores lors des interactions          |    ACCOMPLI    |
|    3     |  Couleurs variées et aléatoires                  |    ACCOMPLI    |
|    4     |  Application stable et rapide                    |    ACCOMPLI    |
|    5     |  Jeu à la manette                                |    ACCOMPLI    |
|    6     |  Jeu au clavier                                  |     TO DO      |
|    7     |  Génération de niveaux aléatoires                |    ACCOMPLI    |
|    8     |  Mix de formes                                   |    ACCOMPLI    |


Les intentions suivantes n'ont pas pu être réalisées :

| Issue No. | Nom de l'intention                               | Resultats |  Raisons                |
|:----------|:-------------------------------------------------|:----------|:------------------------|
|     1     |  Mode Multijoueur                                |  ECHEC    | Faute de temps          |
|     2     |  Jeu à la souris                                 |  ECHEC    | Faute de temps          |
|     3     |  Mode libre                                      |  ECHEC    | Faute de temps          |


## Problèmes rencontrés 🤕

Problèmes rencontrés lors de la réalisation du projet :

- Trouver la technologie adaptée pour réaliser le projet : nous avons eu à changer 2 fois de base de code. Nous avions initialement choisi de travailler avec ProcessingPy, la version Python de Processing pour des raisons de praticité, étant plus à l'aise avec Python qu'avec Java (langage natif de Processing). Nous nous sommes rapidement rendus compte que la richesse de l'écosystème Python et les nombreuses fonctionnalités s'ouvrant ainsi à nous ne suffisaient pas à compenser les problèmes d'incompatibilité de librairies et la cohabitation approximative des 2 langages. Aussi après de nombreux bugs rencontrés et tests infructueux nous avons décidé de réécrire intégralement notre code en Java pour assurer l'intercompatibilité de tous les éléments à intégrer dans ce projet.

## Fontionnalités à ajouter 💡

|        Libellé             | Description |
|:---------------------------|:------------|
| Enregistrer son résultat   | Etant donné le côté visuel du jeu, l'utilisateur pourrait avoir envie de faire une capture de l'effet visuel qu'il a créé dans le jeu |
| Barre de statut            | Une barre de progression du niveau et du jeu pourrait améliorere l'expérience du joueur au regard de son évolution dans le jeu  |
| Vibration de la manette    | Pour une meilleure immersion dans le jeu et plus de feedback utilisateur |

## Technologies Utilisées 👨‍💻

- [Processing](https://processing.org/): Pour les graphismes
- [Java](https://fr.wikipedia.org/wiki/Java_(langage)): Pour faciliter l'usage de processing
- [Processing Sound](https://processing.org/reference/libraries/sound/index.html) & [Beads](http://www.beadsproject.net/): Pour la gestion du son. Sound pour les sons statiques et Beads pour la synthèse en temps réel
- [Game Control Plus](http://lagers.org.uk/gamecontrol/): Pour l'interfaçage avec les manettes de jeu (Dualsense / Dualshock, Xbox)
- [VsCode]() : Notre éditeur de code
- [Github](): Pour la gestion des différentes versions du projet

