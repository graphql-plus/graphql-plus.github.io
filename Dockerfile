FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine

RUN apk update \
 && apk add git bash \
 && apk add libglib glib libnss nspr dbus-libs libxss libappindicator libsecret fontconfig liberation-fonts xdg-utils atk at-spi2-atk gdk-pixbuf gtk+3.0 libxcomposite libxcursor libxdamage libxext libxfixes libxi libxinerama libxrandr libxrender libxshmfence libgconf \
 && apk upgrade \
 && apk cache clean

ENV PATH="${PATH}:/root/.dotnet/tools"

RUN dotnet tool update -g docfx && \
    docfx --version

WORKDIR /docs
VOLUME [ "/docs" ]

ENTRYPOINT [ "docfx" ]
CMD [ "build" ]
