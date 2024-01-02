# MySQL External

This Acorn creates an Acorn service for the MySQL and MariaDB databases from an externally hosted server.

## Usage

When you run this Acorn you will be prompted for the following information:

- address: the address of the MySQL server endpoint (redis.example.com)
- port: the port of the MySQL server (3306)
- adminUsername: the main username to use to connect to the MySQL server as an admin
- adminPassword: the main password to use to connect to the MySQL server as an admin
- username: the username to use to connect to the MySQL server db Instance
- password: the password to use to connect to the MySQL server db Instance
- proto: the protocol to use to connect to the MySQL server.
- dbName: the name of the database to use

To launch the Acorn run the following command:

```bash
acorn run -n mysql-external ghcr.io/acorn-io/mysql-external:v#.#.#
```

then run the following to get prompted for the required information:

```bash
acorn login [APP_NAME]
```

In this example the APP_NAME would be `mysql-external` because it was launched with the `-n` flag.

## Example

In this example, we will use a MySQL server hosted on PlanetScale. To proceed you will need an existing [PlanetScale](https://planetscale.com) account or to create a new one.

### Create a new database

Once you have an account and have signed in, we will need to create a new database for our example.

Once you have logged into Planet Scale select "Create a New Database". We will be starting with an empty DB in PlanetScale.

Next we will give the database a name. In this example we will use `acorn`. Then select the region, we will use `us-east-2` since this is where our Acorn project region is by default. Since this is our example, we will also use the free tier. You must enter in a credit card number to proceed, even with the free tier.

Once you have filled out the form, select "Create Database".

Now select "Other" when prompted for a language or framework.

Name the password, we will use `acorn-example` for this step. Click create and copy the password to someplace safe.

Scroll down on the page to where you see the `.env` section. Now lets launch our example application using this DB.

### Launch the example application

Run the following command to launch the example application:

```bash
acorn run -n mysql-external-example ghcr.io/acorn-io/mysql-external/examples:v#.#.#
```

Enter int he following information, this will be specific to your instance in PlanetScale:

- address: aws.connect.psdb.cloud
- port: 3306
- adminUsername: qm8rgbg6z2n06ip453hv
- adminPassword: [copied from PlanetScale]
- username: qm8rgbg6z2n06ip453hv
- password: [copied from PlanetScale]
- proto: TLS

Notice we used the username and password pair for both the admin and regular user. This is because the service interface expects two users, but on creation PlanetScale only supports creating one. If you import an existing database, you might have a separate user and can use that instead.

Also, notice the proto is set to TLS. This is because PlanetScale requires TLS to connect to the database. Also, the application expects that to swap out the Python driver. This proto field can be set to TCP if you are using a different service that does not require TLS.

Additionally, you could use any value that your application is expecting as it is up to the consumer to determine what is needed in the proto field.
