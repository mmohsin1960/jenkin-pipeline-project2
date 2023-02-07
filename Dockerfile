
FROM  nginx:latest
MAINTAINER muhammad.mohsin@eurustechnologies.com
RUN apt-get update && apt-get install -y nginx \
 zip\
 unzip
ADD https://www.free-css.com/assets/files/free-css-templates/download/page287/cycle.zip /usr/share/nginx/html
WORKDIR /usr/share/nginx/html
RUN unzip cycle.zip
RUN cp -r html/* /usr/share/nginx/html
RUN rm -rf cycle.zip
EXPOSE 80
