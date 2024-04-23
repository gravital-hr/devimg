FROM webdevops/php-nginx:7.4-alpine

ENV WEB_DOCUMENT_ROOT=/app \
  # make sure dev mode is not enabled by default
  DEV_MODE=false

WORKDIR /tmp
SHELL ["/bin/ash", "-o", "pipefail", "-c"]

RUN curl -Ls "https://www.sourceguardian.com/loaders/download/loaders.linux-x86_64.tar.gz" | tar zx \
  && cp ./*.lin "$(php-config --extension-dir)" \
  && ver=$(echo "${PHP_VERSION}" | cut -d. -f1-2) \
  && cp "ixed.${ver}.lin" "$(php-config --extension-dir)/sourceguardian.so" \
  && echo "extension=sourceguardian.so" > "$(php-config --ini-dir)/15-sourceguardian.ini" \
  && rm -f ./*.pdf ./*.lin README version \
  && chmod a+rw /usr/local/bin

COPY fs/ /

WORKDIR /app
