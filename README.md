# BanditHijo's Odoo Docker Compose

This is my personal Docker compose recipe for my Odoo development environment.


## Rules

1. Odoo data and PostgreSQL data should lay down on the host, not in the Docker volume. This ensures that I don't need to worry about the data.
1. It should be possible to doing Docker compose up and down in a robust and flexible manner.


## Cooking

1. Prepare directories to store the Odoo data and PostgreSQL data
   ```
   mkdir -p ./var/lib/odoo && mkdir -p ./var/lib/postgresql/data/pgdata
   ```

1. Compose it up, to cook the recipe

   ```
   docker compose up -d
   ```

1. Check all `odoo` and `odoo-postgres` container status. It must be `Up`

   ```
   docker ps -n 2
   ```

1. Fix Odoo data `var/lib/odoo` directory permission *

   ```
   docker exec -u root odoo chown odoo:odoo -R /var/lib/odoo
   ```
   \* Above command only run once on the first time. Next compose up, you don't need to run this command again.

1. Open your browser and access Odoo
   ```
   http://localhost:8069
   ```
   Done! You're good to go!


## Re-cooking

If you have done playing with Odoo, just run

```
docker compose down
```
to taking down all the Odoo container things.

And if you want to get Odoo again, just run 

```
docker compose up -d
```

That's it!


## Documentations

1. Odoo tutorials \
   <https://www.odoo.com/slides/all/tag/odoo-tutorials-9>
1. Define modue data \
   <https://www.odoo.com/documentation/17.0/developer/tutorials/define_module_data.html>
1. Coding guidelines (Module structure, XML files, Python, JavaScript, CSS, and SCSS) \
   <https://www.odoo.com/documentation/17.0/contributing/development/coding_guidelines.html>
