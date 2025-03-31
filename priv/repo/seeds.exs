# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Sicktix.Repo.insert!(%Sicktix.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

############

alias Sicktix.Repo

alias Sicktix.Schemas.{
  EventTypes,
  Events,
  PerformerTypes,
  Performers,
  Tickets,
  Users,
  VenueSeating,
  Venues
}

# create "hockey" event_type
event_type_attrs = %{name: "hockey", allowed_performer_types: ["1"]}
et_cs = EventTypes.changeset(%EventTypes{}, event_type_attrs)
Sicktix.Repo.insert(et_cs)

# create "hockey_team" performer_type
performer_type_attrs = %{name: "hockey_team"}

pt_cs =
  PerformerTypes.changeset(
    %PerformerTypes{},
    performer_type_attrs
  )

Sicktix.Repo.insert(pt_cs)

# create devils
devils_performer_attrs = %{name: "New Jersey Devils", type: "1", tags: "best team :)"}

dp_cs =
  Performers.changeset(%Performers{}, devils_performer_attrs)

Sicktix.Repo.insert(dp_cs)

# create penguins
penguins_performer_attrs = %{name: "Pittsburgh Penguins", type: "1"}

pp_cs =
  Performers.changeset(%Performers{}, penguins_performer_attrs)

Sicktix.Repo.insert(pp_cs)

# create prudential center
pru_venue_attrs = %{
  name: "Prudential Center",
  location: %{
    street_address: "25 Lafayette Street",
    city: "Newark",
    state: "NJ",
    zip_code: "07102"
  },
  allowed_event_types: ["1", "2"]
}

pv_cs =
  Venues.changeset(%Venues{}, pru_venue_attrs)

Sicktix.Repo.insert(pv_cs)

# create prudential hockey seating
seating_map = %{
  "mezzanine" => [
    %{
      "section" => "250",
      "row" => "G",
      "seat" => "1"
    },
    %{
      "section" => "250",
      "row" => "G",
      "seat" => "2"
    },
    %{
      "section" => "250",
      "row" => "G",
      "seat" => "3"
    },
    %{
      "section" => "250",
      "row" => "G",
      "seat" => "4"
    },
    %{
      "section" => "250",
      "row" => "G",
      "seat" => "5"
    },
    %{
      "section" => "250",
      "row" => "F",
      "seat" => "1"
    },
    %{
      "section" => "250",
      "row" => "F",
      "seat" => "2"
    },
    %{
      "section" => "250",
      "row" => "F",
      "seat" => "3"
    },
    %{
      "section" => "250",
      "row" => "F",
      "seat" => "4"
    },
    %{
      "section" => "250",
      "row" => "F",
      "seat" => "5"
    },
    %{
      "section" => "250",
      "row" => "E",
      "seat" => "1"
    },
    %{
      "section" => "250",
      "row" => "E",
      "seat" => "2"
    },
    %{
      "section" => "250",
      "row" => "E",
      "seat" => "3"
    },
    %{
      "section" => "250",
      "row" => "E",
      "seat" => "4"
    },
    %{
      "section" => "250",
      "row" => "E",
      "seat" => "5"
    },
    %{
      "section" => "250",
      "row" => "D",
      "seat" => "1"
    },
    %{
      "section" => "250",
      "row" => "D",
      "seat" => "2"
    },
    %{
      "section" => "250",
      "row" => "D",
      "seat" => "3"
    },
    %{
      "section" => "250",
      "row" => "D",
      "seat" => "4"
    },
    %{
      "section" => "250",
      "row" => "D",
      "seat" => "5"
    },
    %{
      "section" => "250",
      "row" => "C",
      "seat" => "1"
    },
    %{
      "section" => "250",
      "row" => "C",
      "seat" => "2"
    },
    %{
      "section" => "250",
      "row" => "C",
      "seat" => "3"
    },
    %{
      "section" => "250",
      "row" => "C",
      "seat" => "4"
    },
    %{
      "section" => "250",
      "row" => "C",
      "seat" => "5"
    },
    %{
      "section" => "250",
      "row" => "B",
      "seat" => "1"
    },
    %{
      "section" => "250",
      "row" => "B",
      "seat" => "2"
    },
    %{
      "section" => "250",
      "row" => "B",
      "seat" => "3"
    },
    %{
      "section" => "250",
      "row" => "B",
      "seat" => "4"
    },
    %{
      "section" => "250",
      "row" => "B",
      "seat" => "5"
    },
    %{
      "section" => "250",
      "row" => "A",
      "seat" => "1"
    },
    %{
      "section" => "250",
      "row" => "A",
      "seat" => "2"
    },
    %{
      "section" => "250",
      "row" => "A",
      "seat" => "3"
    },
    %{
      "section" => "250",
      "row" => "A",
      "seat" => "4"
    },
    %{
      "section" => "250",
      "row" => "A",
      "seat" => "5"
    },
    %{
      "section" => "200",
      "row" => "G",
      "seat" => "1"
    },
    %{
      "section" => "200",
      "row" => "G",
      "seat" => "2"
    },
    %{
      "section" => "200",
      "row" => "G",
      "seat" => "3"
    },
    %{
      "section" => "200",
      "row" => "G",
      "seat" => "4"
    },
    %{
      "section" => "200",
      "row" => "G",
      "seat" => "5"
    },
    %{
      "section" => "200",
      "row" => "F",
      "seat" => "1"
    },
    %{
      "section" => "200",
      "row" => "F",
      "seat" => "2"
    },
    %{
      "section" => "200",
      "row" => "F",
      "seat" => "3"
    },
    %{
      "section" => "200",
      "row" => "F",
      "seat" => "4"
    },
    %{
      "section" => "200",
      "row" => "F",
      "seat" => "5"
    },
    %{
      "section" => "200",
      "row" => "E",
      "seat" => "1"
    },
    %{
      "section" => "200",
      "row" => "E",
      "seat" => "2"
    },
    %{
      "section" => "200",
      "row" => "E",
      "seat" => "3"
    },
    %{
      "section" => "200",
      "row" => "E",
      "seat" => "4"
    },
    %{
      "section" => "200",
      "row" => "E",
      "seat" => "5"
    },
    %{
      "section" => "200",
      "row" => "D",
      "seat" => "1"
    },
    %{
      "section" => "200",
      "row" => "D",
      "seat" => "2"
    },
    %{
      "section" => "200",
      "row" => "D",
      "seat" => "3"
    },
    %{
      "section" => "200",
      "row" => "D",
      "seat" => "4"
    },
    %{
      "section" => "200",
      "row" => "D",
      "seat" => "5"
    },
    %{
      "section" => "200",
      "row" => "C",
      "seat" => "1"
    },
    %{
      "section" => "200",
      "row" => "C",
      "seat" => "2"
    },
    %{
      "section" => "200",
      "row" => "C",
      "seat" => "3"
    },
    %{
      "section" => "200",
      "row" => "C",
      "seat" => "4"
    },
    %{
      "section" => "200",
      "row" => "C",
      "seat" => "5"
    },
    %{
      "section" => "200",
      "row" => "B",
      "seat" => "1"
    },
    %{
      "section" => "200",
      "row" => "B",
      "seat" => "2"
    },
    %{
      "section" => "200",
      "row" => "B",
      "seat" => "3"
    },
    %{
      "section" => "200",
      "row" => "B",
      "seat" => "4"
    },
    %{
      "section" => "200",
      "row" => "B",
      "seat" => "5"
    },
    %{
      "section" => "200",
      "row" => "A",
      "seat" => "1"
    },
    %{
      "section" => "200",
      "row" => "A",
      "seat" => "2"
    },
    %{
      "section" => "200",
      "row" => "A",
      "seat" => "3"
    },
    %{
      "section" => "200",
      "row" => "A",
      "seat" => "4"
    },
    %{
      "section" => "200",
      "row" => "A",
      "seat" => "5"
    }
  ],
  "loge" => [
    %{
      "section" => "150",
      "row" => "G",
      "seat" => "1"
    },
    %{
      "section" => "150",
      "row" => "G",
      "seat" => "2"
    },
    %{
      "section" => "150",
      "row" => "G",
      "seat" => "3"
    },
    %{
      "section" => "150",
      "row" => "G",
      "seat" => "4"
    },
    %{
      "section" => "150",
      "row" => "G",
      "seat" => "5"
    },
    %{
      "section" => "150",
      "row" => "F",
      "seat" => "1"
    },
    %{
      "section" => "150",
      "row" => "F",
      "seat" => "2"
    },
    %{
      "section" => "150",
      "row" => "F",
      "seat" => "3"
    },
    %{
      "section" => "150",
      "row" => "F",
      "seat" => "4"
    },
    %{
      "section" => "150",
      "row" => "F",
      "seat" => "5"
    },
    %{
      "section" => "150",
      "row" => "E",
      "seat" => "1"
    },
    %{
      "section" => "150",
      "row" => "E",
      "seat" => "2"
    },
    %{
      "section" => "150",
      "row" => "E",
      "seat" => "3"
    },
    %{
      "section" => "150",
      "row" => "E",
      "seat" => "4"
    },
    %{
      "section" => "150",
      "row" => "E",
      "seat" => "5"
    },
    %{
      "section" => "150",
      "row" => "D",
      "seat" => "1"
    },
    %{
      "section" => "150",
      "row" => "D",
      "seat" => "2"
    },
    %{
      "section" => "150",
      "row" => "D",
      "seat" => "3"
    },
    %{
      "section" => "150",
      "row" => "D",
      "seat" => "4"
    },
    %{
      "section" => "150",
      "row" => "D",
      "seat" => "5"
    },
    %{
      "section" => "150",
      "row" => "C",
      "seat" => "1"
    },
    %{
      "section" => "150",
      "row" => "C",
      "seat" => "2"
    },
    %{
      "section" => "150",
      "row" => "C",
      "seat" => "3"
    },
    %{
      "section" => "150",
      "row" => "C",
      "seat" => "4"
    },
    %{
      "section" => "150",
      "row" => "C",
      "seat" => "5"
    },
    %{
      "section" => "150",
      "row" => "B",
      "seat" => "1"
    },
    %{
      "section" => "150",
      "row" => "B",
      "seat" => "2"
    },
    %{
      "section" => "150",
      "row" => "B",
      "seat" => "3"
    },
    %{
      "section" => "150",
      "row" => "B",
      "seat" => "4"
    },
    %{
      "section" => "150",
      "row" => "B",
      "seat" => "5"
    },
    %{
      "section" => "150",
      "row" => "A",
      "seat" => "1"
    },
    %{
      "section" => "150",
      "row" => "A",
      "seat" => "2"
    },
    %{
      "section" => "150",
      "row" => "A",
      "seat" => "3"
    },
    %{
      "section" => "150",
      "row" => "A",
      "seat" => "4"
    },
    %{
      "section" => "150",
      "row" => "A",
      "seat" => "5"
    },
    %{
      "section" => "100",
      "row" => "G",
      "seat" => "1"
    },
    %{
      "section" => "100",
      "row" => "G",
      "seat" => "2"
    },
    %{
      "section" => "100",
      "row" => "G",
      "seat" => "3"
    },
    %{
      "section" => "100",
      "row" => "G",
      "seat" => "4"
    },
    %{
      "section" => "100",
      "row" => "G",
      "seat" => "5"
    },
    %{
      "section" => "100",
      "row" => "F",
      "seat" => "1"
    },
    %{
      "section" => "100",
      "row" => "F",
      "seat" => "2"
    },
    %{
      "section" => "100",
      "row" => "F",
      "seat" => "3"
    },
    %{
      "section" => "100",
      "row" => "F",
      "seat" => "4"
    },
    %{
      "section" => "100",
      "row" => "F",
      "seat" => "5"
    },
    %{
      "section" => "100",
      "row" => "E",
      "seat" => "1"
    },
    %{
      "section" => "100",
      "row" => "E",
      "seat" => "2"
    },
    %{
      "section" => "100",
      "row" => "E",
      "seat" => "3"
    },
    %{
      "section" => "100",
      "row" => "E",
      "seat" => "4"
    },
    %{
      "section" => "100",
      "row" => "E",
      "seat" => "5"
    },
    %{
      "section" => "100",
      "row" => "D",
      "seat" => "1"
    },
    %{
      "section" => "100",
      "row" => "D",
      "seat" => "2"
    },
    %{
      "section" => "100",
      "row" => "D",
      "seat" => "3"
    },
    %{
      "section" => "100",
      "row" => "D",
      "seat" => "4"
    },
    %{
      "section" => "100",
      "row" => "D",
      "seat" => "5"
    },
    %{
      "section" => "100",
      "row" => "C",
      "seat" => "1"
    },
    %{
      "section" => "100",
      "row" => "C",
      "seat" => "2"
    },
    %{
      "section" => "100",
      "row" => "C",
      "seat" => "3"
    },
    %{
      "section" => "100",
      "row" => "C",
      "seat" => "4"
    },
    %{
      "section" => "100",
      "row" => "C",
      "seat" => "5"
    },
    %{
      "section" => "100",
      "row" => "B",
      "seat" => "1"
    },
    %{
      "section" => "100",
      "row" => "B",
      "seat" => "2"
    },
    %{
      "section" => "100",
      "row" => "B",
      "seat" => "3"
    },
    %{
      "section" => "100",
      "row" => "B",
      "seat" => "4"
    },
    %{
      "section" => "100",
      "row" => "B",
      "seat" => "5"
    },
    %{
      "section" => "100",
      "row" => "A",
      "seat" => "1"
    },
    %{
      "section" => "100",
      "row" => "A",
      "seat" => "2"
    },
    %{
      "section" => "100",
      "row" => "A",
      "seat" => "3"
    },
    %{
      "section" => "100",
      "row" => "A",
      "seat" => "4"
    },
    %{
      "section" => "100",
      "row" => "A",
      "seat" => "5"
    }
  ],
  "balcony" => [
    %{
      "section" => "B1",
      "row" => "B",
      "seat" => "1"
    },
    %{
      "section" => "B1",
      "row" => "B",
      "seat" => "2"
    },
    %{
      "section" => "B1",
      "row" => "B",
      "seat" => "3"
    },
    %{
      "section" => "B1",
      "row" => "B",
      "seat" => "4"
    },
    %{
      "section" => "B1",
      "row" => "B",
      "seat" => "5"
    },
    %{
      "section" => "B1",
      "row" => "A",
      "seat" => "1"
    },
    %{
      "section" => "B1",
      "row" => "A",
      "seat" => "2"
    },
    %{
      "section" => "B1",
      "row" => "A",
      "seat" => "3"
    },
    %{
      "section" => "B1",
      "row" => "A",
      "seat" => "4"
    },
    %{
      "section" => "B1",
      "row" => "A",
      "seat" => "5"
    },
    %{
      "section" => "B2",
      "row" => "B",
      "seat" => "1"
    },
    %{
      "section" => "B2",
      "row" => "B",
      "seat" => "2"
    },
    %{
      "section" => "B2",
      "row" => "B",
      "seat" => "3"
    },
    %{
      "section" => "B2",
      "row" => "B",
      "seat" => "4"
    },
    %{
      "section" => "B2",
      "row" => "B",
      "seat" => "5"
    },
    %{
      "section" => "B2",
      "row" => "A",
      "seat" => "1"
    },
    %{
      "section" => "B2",
      "row" => "A",
      "seat" => "2"
    },
    %{
      "section" => "B2",
      "row" => "A",
      "seat" => "3"
    },
    %{
      "section" => "B2",
      "row" => "A",
      "seat" => "4"
    },
    %{
      "section" => "B2",
      "row" => "A",
      "seat" => "5"
    }
  ],
  "general_admission" => [
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA1"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA2"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA3"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA4"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA5"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA6"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA7"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA8"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA9"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA10"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA11"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA12"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA13"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA14"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA15"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA16"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA17"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA18"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA19"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA20"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA21"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA22"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA23"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA24"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA25"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA26"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA27"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA28"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA29"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA30"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA31"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA32"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA33"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA34"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA35"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA36"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA37"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA38"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA39"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA40"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA41"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA42"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA43"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA44"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA45"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA46"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA47"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA48"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA49"
    },
    %{
      "section" => "GA",
      "row" => "GA",
      "seat" => "GA50"
    }
  ]
}

pru_hockey_seating_attrs = %{venue_id: "1", event_type: "1", seating_chart: seating_map}

phs_cs =
  VenueSeating.changeset(
    %VenueSeating{},
    pru_hockey_seating_attrs
  )

Sicktix.Repo.insert(phs_cs)

# create first event
event_attrs = %{
  name: "December 8th, 2026: New Jersey Devils vs. Pittsburgh Penguins",
  event_type_id: "1",
  venue_id: "1",
  start_datetime: "2026-12-08T19:00:00Z",
  end_datetime: "2026-12-08T22:00:00Z",
  performers: ["1", "2"],
  status: "scheduled",
  tags: ["first event"]
}

seeding_opts = [seeding: true]
Events.Interface.create_event(event_attrs, seeding_opts)

# create user
user_attrs = %{
  email: "user.one@test.com",
  registered_datetime: DateTime.utc_now(),
  roles: ["customer"],
  data: %{
    first_name: "Test",
    last_name: "Person",
    timezone: "America/New_York"
  }
}

Users.Interface.create_user(user_attrs, seeding_opts)

# event_attrs = %{
#   name: "Test event",
#   event_type_id: "1",
#   venue_id: "1",
#   start_datetime: "2025-01-08T19:00:00Z",
#   end_datetime: "2025-01-08T22:00:00Z",
#   performers: ["1"],
#   status: "scheduled",
#   tags: ["a test event"]
# }
