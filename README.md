# WP College

### Create a network for the services

```bash
docker network create wp-network
```

### Start the MySQL container

```bash
docker run -d \
  --name db \
  --network wp-network \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=wordpress \
  -e MYSQL_USER=wordpress \
  -e MYSQL_PASSWORD=wordpress \
  -v db_data:/var/lib/mysql \
  --restart always \
  mariadb:11.7.2
```

### Start the WordPress container

```bash
docker run -d \
  --name wordpress \
  --network wp-network \
  -p 8000:80 \
  -e WORDPRESS_DB_HOST=db \
  -e WORDPRESS_DB_USER=wordpress \
  -e WORDPRESS_DB_PASSWORD=wordpress \
  -e WORDPRESS_DEBUG=1 \
  -v ./src:/var/www/html \
  --restart always \
  wordpress:php8.2
```

## 🛠️ Important Notes
- Core WordPress files like /wp-admin/, /wp-includes/, etc., should not be committed. WordPress itself should be installed or updated separately (e.g., via wp-cli or manually).

- Custom development (your plugin or theme) should be version-controlled — that's why we ! (negate ignore) the path for your own directories.

- Uploads should not go into Git, because media files can quickly bloat the repo.

If you are using ACF Pro or commercial plugins, consider documenting how to install them manually, rather than committing them (due to license issues).

