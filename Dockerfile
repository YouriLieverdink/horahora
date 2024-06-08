FROM dart:stable as base

WORKDIR /usr/app

# Resolve dependencies
RUN dart pub global activate dart_frog_cli

COPY pubspec.* ./
RUN dart pub get

# Copy source
COPY . .

FROM base as between

# Create a production build
RUN dart_frog build

# Compile
RUN dart pub get --offline
RUN dart compile exe build/bin/server.dart -o build/bin/server

FROM scratch as prod

COPY --from=build /runtime/ /
COPY --from=build /app/build/bin/server /app/bin/

# Start
CMD ["/app/bin/server"]