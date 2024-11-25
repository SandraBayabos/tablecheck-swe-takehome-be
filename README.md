# Tablecheck Backend Takehome

This is the backend application for the Tablecheck SWE take-home assignment, built with Ruby on Rails. It sets up a Ruby on Rails backend API for the corresponding frontend application. It also includes the set-up for a PostgreSQL and Redis server on Docker, which the application will interact with.

## Clone the Repository

First, clone this repository to your computer:

```bash
git clone https://github.com/SandraBayabos/tablecheck-swe-takehome-be.git
cd tablecheck-swe-takehome-be
```

## Prerequisites

Make sure you have the following installed on your machine

- Ruby (v3)
- Node.js (v18 and up)
- Docker (v25 and up)
- Docker Desktop (v4 and up)

## Install the Dependencies & Set Up App

Install the rails dependencies:

```bash
bundle install
yarn install
```

## Start up Postgres and Redis on Docker

Running the following command will:

1. Start up a postgres db on `PORT 5432`. NOTE: Stop any PostgreSQL instances running in the background on your machine, as they may interfere with the PostgreSQL instance running in Docker.
2. Run `db:prepare` to create, migrate and seed the database
3. Start up Redis on `PORT 6379`

```bash
docker-compose up-d
```

## Start up the Rails Server

The app will run on `PORT 3000` ([http://localhost:3000](http://localhost:3000)).

```bash
./bin/dev
```

## View the Active Admin Dashboard

Navigate to [http://localhost:3000/admin](http://localhost:3000/admin) and sign in with the following credentials to view which parties have inserted themselves into the queue and to view their current queue status and position:

```bash
admin
admin123
```

On the dashboard, you may also:

1. Manually create a new Party
2. Seed random parties
3. Toggle the "Allow Jump Queue" feature
