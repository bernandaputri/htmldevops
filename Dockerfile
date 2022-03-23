FROM nginx
COPY ./html/. /usr/share/nginx/html/.
EXPOSE 8080
EXPOSE 80
