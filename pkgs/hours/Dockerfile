FROM dart:stable as base

WORKDIR /usr/app

COPY ./pkgs/hours ./pkgs/hours

WORKDIR /usr/app/pkgs/hours

RUN dart pub get
    
FROM base as between

# Build a minimal serving image
RUN dart compile exe ./bin/hours.dart -o ./bin/hours

FROM scratch as prod

COPY --from=between /runtime/ /
COPY --from=between /usr/app/pkgs/hours/bin/hours /usr/app/bin/

ENV SHELF_HOTRELOAD=false

EXPOSE 8080

CMD [ "/usr/app/bin/hours" ]