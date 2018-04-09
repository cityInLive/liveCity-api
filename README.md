# LiveCity / Back-End

## Principe

Récupérer des données provenant de différentes API puis fournir une nouvelle API
adaptée à nos besoins

## Méthodes

- Wheather : ```GET weather/{city}```
- Twitter : ``` GET twitter{lat,long}```
- Wikipedia : ``` GET wikipedia{city,departement}```

## Exemples

- Météo à Paris : ```https://livecity.vltn.pw:8080/weather/Paris```
- Tweets postés à Paris : ```https://livecity.vltn.pw:8080/twitter/48.866667,2.333333```
- Wikipedia de Marseille : ```https://livecity.vltn.pw:8080/wikipedia/Marseille,Bouches-du-Rhône```
