# BanditHijo's Odoo Docker Compose

This is my personal Docker compose recipe for my Odoo development environment.


## Docker images

1. `odoo:17.0`
1. `postgresql:16.1`


## Rules

1. Easy to start, stop, and restart the Odoo service.
1. Odoo data and PostgreSQL data should lay down on the host, not in the Docker volume. This ensures that I don't need to worry about the data.
1. It should be possible to doing Docker compose up and down in a robust and flexible manner.


## Directory structure

```
 extra-addons/                 # Custom modules goes here
└  sample_module/
 etc/
└  odoo/
  └  odoo.conf                 # Odoo configuration file
 var/
└  lib/
  │  odoo/                     # Odoo data directories
  └  postgresql/               # PostgreSQL data directories
```


## Cooking

1. Please provide directories to store the Odoo data and PostgreSQL data

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

   > **NOTE** \
   > Above command only run once on the first time. Next compose up, you don't need to run this command again.

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

**Don't worry about your data.** It safe on `var/lib/odoo/.local/` and `var/lib/postgresql/data/pgdata/`.

And if you want to get into Odoo again, just run

```
docker compose up -d
```

And you will get your data back.


## Restart

If you want to restart Odoo service, just run

```
docker compose restart
```


## Logging

If you want to check log for odoo container, just run

```
docker compose logs -f odoo
```

If you want to check log for odoo-postgres, just run

```
docker compose logs -f odoo-postgres
```


## Make it easy with Makefile

I have provide `Makefile` to control all my needs:

1. Easy to start, stop, and restart Odoo service
1. Easy to check the Odoo and PostgreSQL log for debugging
1. Easy to enter PostgreSQL interactive shell (psql)

```
make
```

```
Available targets:
  start                  Start the compose with daemon
  stop                   Stop the compose
  restart                Restart the compose
  addons <addon_names>   Restart instance and upgrade addons (comma-separated)
  console                Odoo interactive console
  psql                   PostgreSQL interactive shell
  logs odoo              Logs the odoo container
  logs db                Logs the odoo-postgres container
```

So, you don't need to use the long docker compose command anymore.

Just run `make start` to compose up, `make stop` to compose down, `make restart` to compose restart and so on.

If you want to upgrade single custom module `make upgrade module_name`.

If you want to upgrade multiple custom modules `make upgrade module_name,module_name,module_name`.

That's it!

> **ATTENTION PLEASE** \
> Store your Odoo database name into `WEB_DB_NAME=` variable inside `Makefile`, before execute the command `make psql`.


## Documentations

1. Odoo tutorials \
   <https://www.odoo.com/slides/all/tag/odoo-tutorials-9>
1. Developer > Tutorials > Server framework 101 \
   <https://www.odoo.com/documentation/17.0/developer/tutorials/server_framework_101.html>
1. Contributing > Development > Coding guidelines (Module structure, XML files, Python, JavaScript, CSS, and SCSS) \
   <https://www.odoo.com/documentation/17.0/contributing/development/coding_guidelines.html>
