## Nginx-pod för att testa att nätverksuppsättningen för letsencrypt är korrekt

* Build with `docker build . -t registry/image:tag`
* Login to the cluster or registry `docker login -u unset -p $(oc whoami -t) cluster.registry.domain.com`
* Push with `docker push registry/image:tag`
* Deploy application in cluster once logged in with: `kubectl apply -k .`
* Edit the ingress so that it matches the fqdn you want to verify traffic to.
* Curl the endpoint from both the internal network that the cluster uses to resolve dns and from the internet `curl -v http://your.fqdn.com/.well-known/acme-challenge/asdf1234`
* If you get "We have data", the routing is correctly deployed and you're ready to create a cert-manager handled `certificate` resource. You shouldn't be redirected to 443 and you shouldn't get 503 service unavailable as the response.
