FROM nginx:latest
LABEL description="Create a faux http01 challenge pod to behave like a cert-manager pod would"
RUN mkdir -p /usr/share/nginx/html/.well-known/acme-challenge && \
echo "We have data" > /usr/share/nginx/html/.well-known/acme-challenge/asdf1234 && \
chgrp -R root /var/cache/nginx /var/run  && \
chmod -R 770 /var/cache/nginx /var/run
COPY default.conf /etc/nginx/conf.d/
COPY nginx.conf /etc/nginx/
CMD ["nginx", "-g", "daemon off;"]
