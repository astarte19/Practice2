# Используем официальный образ .NET Core SDK для сборки приложения
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# Копируем файлы проекта и восстанавливаем зависимости
COPY *.csproj .
RUN dotnet restore

# Копируем исходный код и собираем приложение
COPY . .
RUN dotnet publish -c Release -o out

# Отдельный образ для запуска приложения
FROM mcr.microsoft.com/dotnet/runtime:7.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "Sample.dll"]
