#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
ADD http://swroot.sherwin.com/swroot.pem /usr/local/share/ca-certificates/swroot.crt
RUN update-ca-certificates
WORKDIR /src
COPY ["HelloWorldAPI.csproj", "."]
RUN dotnet restore "./HelloWorldAPI.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "HelloWorldAPI.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "HelloWorldAPI.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "HelloWorldAPI.dll"]