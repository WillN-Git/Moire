<div align="center">
  <h1 align="center">
        Lost Shapes Dimension
    <img src="MDImages/001-paint.png" />
  </h1>

  <h3 align="center">Un puzzle game avec des effet visuels de moire (illusionnistes).</h3>
</div>

<br/>

![screenshot](captures/capture05.png)


## Objectif du projet
Lost Shapes Dimension est un jeu sous acide dans lequel le·a joueur·euse est invité·e à aider des formes géométriques dans leur quête de se recentrer sur elles-mêmes afin de se remettre en phase avec l'univers. 


### Fontionnalités existantes

1. Sélection d'une forme
2. Transformation d'une forme :
    - Translation
    - Rotation
    - Homothétie

## Intentions

Les intentions suivent ont été respectées : 

|  Int N°  | Nom de l'intention                               |   Resultats    |
|:---------|:-------------------------------------------------|:---------------|
|    1     |  Effet visuel de moiré                           |    ACCOMPLIT   |
|    2     |  Feedback sonores lors des interactions          |    ACCOMPLIT   |
|    3     |  Couleurs variées et aléatoires                  |    ACCOMPLIT   |
|    4     |  Application stable et rapide                    |    ACCOMPLIT   |
|    5     |  Jeu à la manette                                |    ACCOMPLIT   |
|    6     |  Jeu au clavier                                  |    ACCOMPLIT   |
|    7     |  Génération de niveaux aléatoires                |    ACCOMPLIT   |
|    8     |  Mix de formes                                   |    ACCOMPLIT   |
|    9     |  Mode fusion aléatoire                           |    ACCOMPLIT   |

Les intentions suivantes n'ont pas pu être réalisées :


| Issue No. | Nom de l'intention                               | Resultats |  Raisons                                                                               |
|:----------|:-------------------------------------------------|:----------|:---------------------------------------------------------------------------------------|
|     1     |  Mode Multijoueur                                |  ECHEC    | The application uses up to 20% of the processor capacity                               |
|     2     |  Jeu à la souris                                 |  ECHEC    | Some white pixels appear on the drawing on Full HD sceerns and higher                  |
|     3     |  Mode libre                                      |  ECHEC    | The higher the quality of the computer screen, the smaller the size of the application |


## Problèmes rencontrés

Lors de la réalisation du projet nous avons rencontrés divers problèmes notamment:
- La technologie adaptée pour réaliser le projet: Nous avons eu à changer 2 fois de base de code. En python par exemple, on avait pas de librairie de son qui nous permettait de travailler en LFO. Aussi aucune bibliothèque graphique ne nous permettait de lier processing avec une libraire graphique en python

## Fontionnalités pensées après réalisation

| Libellé      | Description |
|:-------------|:------------|
| Enregistrer son résultat   | Etant donné le côté visuel du jeu, l'utilisateur pourrait avoir envie d'enregistrer l'effet visuel qu'il a crée dans le jeu |
| Barre de statut            | Une barre de progression du niveau et du jeu pourrait améliorere l'expérience du joueur au regard de son évolution dans le jeu  |

## Technologies Utilisées

- [Processing](): Pour les graphismes
- [Java](https://fr.wikipedia.org/wiki/Java_(langage)): Pour faciliter l'usage de processing
- [Python]()
- [Processing sound](): Pour la gestion du son
- [VsCode](https://slick.ninjacave.com/javadoc/) : Notre éditeur de code
- [Github](): Pour la gestion des différentes versions du projet
