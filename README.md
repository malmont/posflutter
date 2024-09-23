
<!-- PROJECT LOGO --> <p align="center"> <h3 align="center">Application POS - Libre et Open Source</h3> <p align="center"> Un système de point de vente moderne développé avec Flutter et Symfony, libre et open source ! <br /> <a href="https://github.com/malmont/posflutter"><strong>Explorer la documentation »</strong></a> <br /> <a href="https://malmont.github.io/posflutterweb/">Voir la Démo</a> · <a href="https://github.com/malmont/posflutter/issues">Signaler un Bug</a> · <a href="https://github.com/malmont/posflutter/issues">Demander une Fonctionnalité</a> </p> </p>


🔗 Testez l'application ici
<br /> <a href="https://malmont.github.io/posflutterweb/">Voir la Démo</a> 
Identifiants de test :

Login : test@pos.com
Mot de passe : Test@1234
## Stack techniques:

* **Clean Architecture**: Code structuré et modulaire avec séparation des responsabilités en couches : Présentation, Domaine, et Données.
* **Injection de dependances (GetIt)**:  Utilisation de Get It pour gérer et injecter les dépendances de manière efficace..
* **BLoC State Management**: Utilisation du pattern BLoC pour une gestion claire et maintenable de l'état de l'application.
* **DIO**: Utilisation de Dio, une bibliothèque HTTP puissante pour gérer les appels API. Dio simplifie la gestion des requêtes HTTP avec des fonctionnalités telles que :
Support des méthodes HTTP classiques (GET, POST, PUT, DELETE).
Gestion centralisée des erreurs et des exceptions.
Intercepteurs pour ajouter des en-têtes, gérer l'authentification, ou transformer les réponses.
* **Connexion sécurisé avec token JWT**:  Sécurité et Authentification :
JWT (JSON Web Token) pour une authentification sécurisée. Le backend Symfony génère un token JWT lors de la connexion des utilisateurs.
Ce token est ensuite utilisé pour authentifier les requêtes suivantes en l’ajoutant aux en-têtes HTTP (via Dio) pour toutes les requêtes sécurisées.
Les jetons JWT permettent de valider l'identité de l'utilisateur tout au long de la session sans stocker d'informations sensibles côté client.
* **Workflow JWT**:
L'utilisateur se connecte avec ses identifiants. Le backend Symfony génère un token JWT. Ce token est stocké localement (généralement dans Secure Storage ou SharedPreferences pour les applications mobiles). Pour chaque requête ultérieure, Dio ajoute automatiquement le token JWT dans les en-têtes pour authentifier l'utilisateur.

Pour les applications web, la gestion du token est différente : le token JWT est géré côté backend et inséré dans le navigateur sous forme de cookies sécurisés (Secure Cookies). Cela permet de protéger le token en le rendant accessible uniquement au serveur pour les requêtes authentifiées via le navigateur. Cette gestion centralisée assure une sécurité accrue et évite les manipulations directes du token dans le frontend des applications web. 

* **Fonctionnalités POS de commerce**: Gestion des produits, catégories, panier, et suivi des stocks.
* **Gestion de la caisse**: Gestion de l'ouverture, fermeture, et des dépôts en caisse avec un historique complet des actions.
<!-- Features -->
---
| Fonctionnalité | UseCases                                                                                                                                                                                                   |
|---------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Produits       | Liste des produits, Recherche par catégorie
| Panier        | Ajouter au panier, Mettre à jour le panier
| Commandes       | Lister les commandes par statut, Voir les détails des commandes
| Gestion de caisse	       | Ouvrir la caisse, Fermer la caisse, Faire un dépôt, Voir les actions de la caisse
| Paiements       | Gestion des paiements
| Statistiques       | Fonctionnalité en cours

                                                                           |

![Description de l'image](https://ucarecdn.com/95ecd1f7-a387-4e51-a2e4-4b184a0dd4c6/screen2.png)

![Description de l'image](https://ucarecdn.com/f6bca80f-7961-40bd-802a-5b3762163997/screen5.png)
![Description de l'image](https://ucarecdn.com/32fb665f-65f2-42b6-b8fd-73346991edee/screen4.png)
![Description de l'image](https://ucarecdn.com/ac58230a-58d3-404f-a237-52024f77ab39/screen6.png)
![Description de l'image](https://ucarecdn.com/b3347019-444c-491a-a8b0-6d96884cdce6/screen7.png)
![Description de l'image](https://ucarecdn.com/c5889688-16d9-46f4-8c2f-b10f867ad9ef/screen3.png)

Commencer
Suivez ces étapes pour configurer votre environnement de développement et exécuter l'application en local.

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/Sameera-Perera/Flutter-TDD-Clean-Architecture-E-Commerce-App.git
   ```
2. Install packages
   ```sh
   flutter pub get
   ```
3. Run app
   ```sh
   flutter run lib/main.dart
   ```
4. Run test
   ```sh
   flutter test
   ```
For help getting started with Flutter, view our online
[documentation](https://flutter.io/).

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.d'informations.

Contact

Michel Almont - Portfolio :https://michel-almont.com/
Lien du projet : https://github.com/malmont/posflutter


