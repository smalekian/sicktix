# Sicktix

To set up database:
  * Run `docker run --name sicktix-postgres -e POSTGRES_PASSWORD=mysecretpassword -p 5432 -d postgres`

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies, and to seed the database
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can make HTTP requests to create and query Events and claim Tickets.

Events:
  * `curl localhost:4000/event`
  * `curl localhost:4000/event/:id`
  * `curl -H 'Content-Type: application/json' \
     -d '{ "name": "test event", "event_type_id": "1", "venue_id": "1", "start_datetime": "2026-12-12T18:00:00Z", "end_datetime": "2026-12-12T20:00:00Z", "performers": ["1", "2"], "status": "scheduled" } ' \
     -X POST localhost:4000/event`

Tickets:
  * ` curl -H 'Content-Type: application/json' \
     -d '{ "owner": {"user": "1"}, "id": "1" } ' \
     -X POST localhost:4000/ticket/claim`
