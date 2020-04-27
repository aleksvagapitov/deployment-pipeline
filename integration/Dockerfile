# Build stage
FROM mcr.microsoft.com/dotnet/core/sdk:3.1
WORKDIR /integration

# restore
COPY integration.csproj .
RUN dotnet restore

# copy src
COPY . .

# test
ENTRYPOINT ["dotnet", "test", "--verbosity=normal"]
