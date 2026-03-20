FROM nginx:alpine

COPY default.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html/selectzyme/index.html
COPY bootstrap.min.css /usr/share/nginx/html/selectzyme/bootstrap.min.css
COPY ipb-logo.png /usr/share/nginx/html/selectzyme/ipb-logo.png

# CMD and ENTRYPOINT are inherited from the base image, so we don't need to specify them here unless we want to override them.