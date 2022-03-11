## Nginx-image to test that the networking setup; DNS, NAT, Load Balancing for letsencrypt is correct.

You should be able to run the application by setting your kube config context to the namespace where you want to run it and then `kubectl apply -k .` after `git clone https://github.com/arizon-dread/acme-test.git`. The repo is setup to build and push a new image on git push to main branch but Docker purges images after 6 months so if it becomes stale, you can either request a new build or build it yourself after cloning the repo.

* Build with `docker build . -t registry/image:tag`
* Login to the cluster or registry `docker login -u unset -p $(oc whoami -t) cluster.registry.domain.com` (OpenShift specific).
* Push with `docker push registry/image:tag`
* Edit the ingress so that it matches the fqdn you want to verify traffic to.
* Make sure the deployment points to a tag that exists and is the latest pushed one, see the link below to docker hub.
* Deploy application in cluster once logged in with: `kubectl apply -k .`
* Curl the endpoint from both the internal network that the cluster uses to resolve dns (this can be a pod in kubernetes or a normal computer that resolves dns to the same internal dns server as the cluster) and from the internet `curl -v http://your.fqdn.com/.well-known/acme-challenge/asdf1234`
* If you get "We have data" as response from the curl call, the routing is correctly deployed and you're ready to create a cert-manager handled `certificate` resource. You shouldn't be redirected to 443 and you shouldn't get 503 service unavailable as the response.

See docker image: https://hub.docker.com/repository/docker/regionorebrolan/acme-challenge-test
