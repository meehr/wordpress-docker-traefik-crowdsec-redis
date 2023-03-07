# Wordpress mit Redis Cache und Crowdsec und Traefik

Für alle die schon lange nach einem Wordpress Docker-Compose File suchen, welches neben Traefik und Crowdsec auch noch ein Redis Cache enthält.

## Vorbereitungen für die Nutzung

Wichtig ist ihr braucht hier einen funktionierenden Traefik Container schaut euch dazu einfach mal mein Traefik Repository an. 

Auch einen funktionierenden Crowsec Container solltet Ihr schon haben. 

## Wordpress Compose File anpassen 

Alle Variablen können in einem .env file angelegt werden und werden dann bei beim Rollout des Wordpress automatisch ausgelesen. 

Wer keine .env File von Hand anlegen möchte kann auch das ebenfall im Repo befindliche script create_env.sh nutzen.