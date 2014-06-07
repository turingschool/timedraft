## TimeDraft

TimeDraft is a system for equitably scheduling low-priority meetings such as:

* a team lead who wants team members to be able to schedule lunch with her ("Leader")
* a teacher who has some space for one-on-one mentoring ("Guest")

## How it Works

* The requesters are members of a pool (a "team" or a "class" in the above examples)
* The person offering the meeting opens one or more appointment slots and sets a waiver window
* The requesters put in their requests
* When the waiver window closes the requests are processed
* If a request is awarded to a requester, that requester moves to the bottom of the
priority list for the next round

The prioritization allows infrequent requesters to get a turn and frequent requesters
to make use of any spots available.

## Usage

### As a Leader

```ruby
me = User.login
me.username # => jcasimir
appointment = me.create_appointment(
  name: "Friday Lunch",
  weekday: :friday,
  starts: "12:00",
  ends: "1:00",
  recurs: :none,
  window_closes: "3 days"
)
```

### As a Guest

```ruby
guest = User.login
appointment = Appointment.find(:username => :jcasimir, :name => "Lunch")
request = guest.add_request(appointment)
request.status # => :pending
```

Then, once the window closes:

```ruby
request.status # => :scheduled or :rejected
```
