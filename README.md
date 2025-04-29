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


## Troubleshooting

### EACCES: permission denied

The error EACCES: permission denied indicates that you do not have the necessary permissions to move file to the src directory. To fix this, you can follow these steps:

Check Permissions of the src Directory

```bash
ls -ld /workspaces/wp-college/src/
```

#### Option 1: Change Ownership

If you have sudo access, run:

```bash
sudo chown -R $(whoami):$(whoami) /workspaces/wp-college/src/
```

#### Option 2: Modify Permissions

```bash
chmod u+w /workspaces/wp-college/src/
```

### Docker did not install Wordpress core files

When you git pull your repo on another laptop, you do not have WordPress core files (because they are ignored by .gitignore and never committed).
But your Docker container is trying to serve WordPress from the volume ./:/var/www/html, and the mapped folder (./) is empty except for your custom files (e.g., theme/plugin).

Result:

- /var/www/html inside the container is basically missing WordPress.
- No /wp-admin/, /wp-includes/, etc. → WordPress can't run.

#### ✅ Solution 2: Use a Local Script to Download WordPress

run:

```bash
./setup.sh
```
