# Build stage
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env

WORKDIR /generator

# restore
COPY api/api.csproj ./api/
RUN dotnet restore api/api.csproj
COPY tests/tests.csproj ./tests/
RUN dotnet restore tests/tests.csproj

# copy src
COPY . .

# test
ENV TEAMCITY_PROJECT_NAME = ${TEAMCITY_PROJECT_NAME}
RUN dotnet test tests/tests.csproj -l:trx --verbosity=normal

# publish
RUN dotnet publish api/api.csproj -o /publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
COPY --from=build-env /publish /publish
WORKDIR /publish
ENTRYPOINT ["dotnet", "api.dll"]
