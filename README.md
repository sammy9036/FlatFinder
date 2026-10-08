# FlatFinder

Spring Boot room rental platform with JSP views and MySQL database support.

## Railway deployment

1. Push this repository to GitHub.
2. In Railway, create a new project and deploy from the GitHub repo.
3. Add a MySQL database service in the same Railway project.
4. In your app service, set these variables:
   - `SPRING_DATASOURCE_URL` (optional if using Railway's MySQL vars)
   - `MYSQLHOST`
   - `MYSQLPORT`
   - `MYSQLDATABASE`
   - `MYSQLUSER`
   - `MYSQLPASSWORD`
   - `PORT` is provided automatically by Railway
5. Deploy the app.

### Recommended Railway MySQL values

Use the values Railway provides for your database service. Do **not** hardcode credentials in source files.

## Local run

```powershell
cd "C:\Users\samsh\Downloads\FlatFinder"
.\mvnw spring-boot:run
```

Make sure a local MySQL server is running if you want to use the default localhost settings.

## Notes

- `src/main/resources/application.properties` is configured to use Railway variables when available.
- `server.port` uses Railway's `PORT` variable when deployed.
- Build output in `target/` is ignored by Git.