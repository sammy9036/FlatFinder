# FlatFinder

Spring Boot room rental platform with JSP views and MySQL database support.

## Railway deployment

1. Push this repository to GitHub.
2. In Railway, create a new project and deploy from the GitHub repo.
3. Add a MySQL database service in the same Railway project.
4. In your app service, set these variables from Railway's MySQL service:
   - `SPRING_DATASOURCE_URL` or
   - `MYSQLHOST`, `MYSQLPORT`, `MYSQLDATABASE`, `MYSQLUSER`, `MYSQLPASSWORD`
   - `PORT` is provided automatically by Railway
5. Deploy the app.

### Recommended Railway MySQL values

Use the values Railway provides for your database service. Do **not** hardcode credentials in source files.

## Local run

```powershell
cd "C:\Users\samsh\Downloads\FlatFinder"
.\mvnw spring-boot:run -Dspring-boot.run.profiles=local
```

For local testing, make sure MySQL is running on `localhost:3306` and set `LOCAL_DB_PASSWORD` if your local MySQL root user has a password.

## Notes

- `src/main/resources/application.properties` is configured to use Railway variables when available.
- `src/main/resources/application-local.properties` is for local MySQL testing only.
- `server.port` uses Railway's `PORT` variable when deployed.
- Build output in `target/` is ignored by Git.