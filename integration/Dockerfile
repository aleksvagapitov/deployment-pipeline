# Build stage
FROM mcr.microsoft.com/dotnet/core/sdk:3.1
WORKDIR /integration

# restore
COPY integration.csproj .
RUN dotnet restore

# copy src
COPY . .

# test
ENV TEAMCITY_PROJECT_NAME = ${TEAMCITY_PROJECT_NAME}
ENTRYPOINT ["dotnet", "test", "--verbosity=normal"]
