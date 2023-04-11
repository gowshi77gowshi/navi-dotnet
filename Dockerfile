#Get base sdk image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

#copy
COPY *.csproj ./
RUN dotnet restore

#copy the project File and build our release
COPY . ./
RUN dotnet publish -c Release -o out

#Generate runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
EXPOSE 80
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "DockerAPI.dll"]
