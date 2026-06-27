FROM mcr.microsoft.com/dotnet/sdk:8.0

RUN apt-get update \
 && apt-get install -y --no-install-recommends git bash curl ca-certificates gnupg \
 && curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
 && apt-get install -y --no-install-recommends libglib2.0-0 libnss3 libnspr4 libdbus-1-3 libxss1 libappindicator3-1 \
                    libsecret-1-0 fonts-liberation xdg-utils libatk1.0-0 libatk-bridge2.0-0 libgdk-pixbuf2.0-0 \
                    libgtk-3-0 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxinerama1 \
                    libxrandr2 libxrender1 libxshmfence1 libgconf-2-4 libgbm1 libasound2 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENV PATH="${PATH}:/root/.dotnet/tools"

COPY init/ global-metadata.json images/GraphQL_Logo.svg /init/

RUN dotnet tool update -g docfx && \
    cd /init && \
    docfx init.json && \
    rm -rdf /init

WORKDIR /docs
VOLUME [ "/docs" ]

ENTRYPOINT [ "docfx" ]
CMD [ "docfx.json" ]
