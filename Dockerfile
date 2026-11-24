FROM nginx:stable-alpine

# Use a standalone config so nginx can run without root privileges.
COPY nginx.conf /etc/nginx/nginx.conf
COPY *.html style.css site.js /usr/share/nginx/html/
COPY assets/ /usr/share/nginx/html/assets/

USER nginx
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget -q -O /dev/null http://127.0.0.1:8080/healthz || exit 1

# Skip the base image's configuration-modifying entrypoint scripts.
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
