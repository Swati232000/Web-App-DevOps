FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

COPY ./Web-App-DevOps.csproj ./Web-App-DevOps.csproj
COPY *.sln ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o build --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Install shell interpreter
RUN apt-get update && apt-get install -y bash

COPY --from=build ./build .
ENV ASPNETCORE_URLS=http://*:8080
EXPOSE 8080
ENTRYPOINT [ "dotnet", "Web-App-DevOps.dll" ]
