FROM nginx:alpine

COPY default.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html/index.html
COPY bootstrap.min.css /usr/share/nginx/html/bootstrap.min.css
COPY ipb-logo.png /usr/share/nginx/html/ipb-logo.png

# CMD and ENTRYPOINT are inherited from the base image, so we don't need to specify them here unless we want to override them.