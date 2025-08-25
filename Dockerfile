FROM nginx:1.27-alpine

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy app files
COPY index.html /usr/share/nginx/html/index.html
COPY sw.js /usr/share/nginx/html/sw.js
COPY manifest.webmanifest /usr/share/nginx/html/manifest.webmanifest

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]


