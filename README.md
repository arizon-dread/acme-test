## Nginx-pod för att testa att nätverksuppsättningen för letsencrypt är korrekt

* Bygg med `docker build . -t default-route-openshift-image-registry.apps.prod01.pennybridge.io/namespace/image:tag`
* Logga in med `docker login -u unset -p $(oc whoami -t) default-route-openshift-image-registry.apps.prod01.pennybridge.io`
* Pusha med `docker push default-route-openshift-image-registry.apps.prod01.pennybridge.io/namespace/image:tag`
* Skjut in deploy och service med `oc apply -f deploy.yaml -f service-yaml`
* Editera routen så att den passar den dns du vill testa.
* Curla endpointen från både insidan och utsidan av vårt nätverk `curl -v http://route-domain/.well-known/acme-challenge/asdf1234`
* Om du får tillbaka "We have data" så fungerar trafiken. Du ska inte redirectas till 443 och du ska inte få http 503 tillbaka.
