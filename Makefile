RUNTIME ?= podman
CADDY_VERSION ?= 2.4.6

serve:
	mkdir -p sites
	$(RUNTIME) run --rm -it \
	    -v $$PWD/sites:/srv:Z \
	    -v $$PWD/Caddyfile:/etc/caddy/Caddyfile:ro,Z \
	    -e SITE_DIR=/srv \
	    -p 2015:2015 \
	    docker.io/library/caddy:$(CADDY_VERSION) \
	    caddy run --config /etc/caddy/Caddyfile --watch

fmt:
	$(RUNTIME) run --rm -it \
	    -v $$PWD/Caddyfile:/etc/caddy/Caddyfile:Z \
	    docker.io/library/caddy:$(CADDY_VERSION) \
	    caddy fmt --overwrite /etc/caddy/Caddyfile
