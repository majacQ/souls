module Souls
  class Docker < Thor
    desc "psql", "Run PostgreSQL13 Docker Container"
    def psql
      system(
        "docker run --rm -d \
          -p 5433:5432 \
          -v postgres-tmp:/var/lib/postgresql/data \
          -e POSTGRES_USER=postgres \
          -e POSTGRES_PASSWORD=postgres \
          -e POSTGRES_DB=souls_test \
          postgres:13-alpine"
      )
      system("docker ps")
    rescue Thor::Error => e
      raise(Thor::Error, e)
    end

    desc "mysql", "Run MySQL Docker Container"
    def mysql
      system(
        "docker run --rm -d \
          -p 3306:3306 \
          -v mysql-tmp:/var/lib/mysql \
          -e MYSQL_USER=mysql \
          -e MYSQL_ROOT_PASSWORD=mysql \
          -e MYSQL_DB=souls_test \
          mysql:latest"
      )
      system("docker ps")
    rescue Thor::Error => e
      raise(Thor::Error, e)
    end
  end
end
