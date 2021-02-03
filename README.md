# BYLL

## Background

Byll is an `Aplication Programming Interface (API)` of a sample billing system for a law firm in Ghana. To be as efficient as possible, the firm uses a
billable rate system. This means every lawyer, depending on their grade has a billable rate and
for any project they work on, must send in the total number of hours they’ve worked on so that
the finance team can create invoices for clients to pay.

The lawyers send their timetable with the following information:

- Employee ID
- Billable Rate (per hour)
- Company
- Date
- Start Time
- End Time

The finance team members can then create an invoice from the created timesheets for a particular company/client using the company name.

## Technologies used

This project is built with the Ruby on Rails Framework with the following stack:

- Ruby version:

  `ruby 2.7.2`

- System dependencies

  Rails: `rails 6.1.1`

  Bundler: `bundler 2.1.4`

  Database: `Postgresql`

## Available endpoints

| HTTP Method   | Endpoint             | Parameters                                                                  | Description                                                                                                                                                  |
| ------------- | -------------------- | --------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `POST`        | `/v1/auth/register`  | `email`, `password`, `role`                                                 | Creating a new user account. Role accepts either `finance_team` or `lawyer` and defaults to `lawyer` when not provided and returns a `token` when successful |
| `POST`        | `/v1/auth/login`     | `email`, `password`                                                         | Log in to user account and returns a `token` when successful                                                                                                 |
| `POST`        | `/v1/invoice`        | `company`                                                                   | `Accessible to only finance team` to generate an invoice for the given company                                                                               |
| `GET`         | `/v1/timesheets`     |                                                                             | Fetch all timesheets. `Lawyers get only their own timesheets`                                                                                                |
| `POST`        | `/v1/timesheets`     | `employee_id`, `billable_rate`, `company`, `date`, `start_time`, `end_time` | Create a new timesheet. `Lawyers can only create timesheets for themselves.`                                                                                 |
| `GET`         | `/v1/timesheets/:id` |                                                                             | Get the timesheet matching the `id`. `Lawyers can only get their own timesheet`                                                                              |
| `PUT`/`PATCH` | `/v1/timesheets/:id` | `employee_id`, `billable_rate`, `company`, `date`, `start_time`, `end_time` | Update an existing timesheet with the provided `id`. `Lawyers can only update their own timesheet`                                                           |
| `DELETE`      | `/v1/timesheets/:id` |                                                                             | Delete timesheet matching the given `id`. `Lawyers can only delete their own timesheet`                                                                      |

## How to run the project locally

### Configuration

#### Clone this repository

    $  git clone https://github.com/mikeattara/billed.git

#### Navigate to the project directory

    $  cd billed

#### Install dependencies from the gemfile

    $  bundle install

### Database creation and initialization

#### Create database

    $ rails db:create

#### Migrate database

    $ rails db:migrate

## Running the server

You can run the server by running the command below in the project directory

    $ rails server

## How to run the test suite

```shell
  rspec
```

## Services

No external services used at the moment

## Deployed project

This project is deployed on `Heroku` as [https://byll.herokuapp.com](https://byll.herokuapp.com)
